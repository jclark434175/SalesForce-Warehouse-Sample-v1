public class GenealogyComponentController {
    public String repAcctNbr {get; set;}
    public Boolean impersonate {get; set;}
    public String drillDownAcctNbr {get; set;}
    public String filter1 {get; set;}
    public String filter2 {get; set;}
    public List<DownlineGroup> downlineGroups {get; set;}
    public Integer totalDownlines {get; set;}
    public Search_Criteria__c srchCrit {get; set;}
    public MyDownlineClass currRep {get; private set;}
    public String currRepTitle {get; private set;}
    public Market__c market {get; set;}
    public User currUser {get; private set;}
    private static Map<String,String> filter1Crit;
    private static Map<String,String> filter2Crit = new Map<String,String>();
    private static String uplineCondition = ' and (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr OR UPLN_GENRTN_3_ACCT_NR__c=:critRepAcctNbr OR UPLN_GENRTN_2_ACCT_NR__c=:critRepAcctNbr)';
    public Boolean printSelected {get; set;}
    public String printAcctNbrs {get; set;}
    public List<Leader_Title__c> leaderTitles {get; private set;}
    public Leader_Title__c currLdrTitle {get; private set;}
    
    public Integer endRow {get; private set;}
    public Integer startRow {get; private set;}
    public Integer pageNbr {get; private set;}
    
    private static Integer MAX_ROWS_PER_PAGE=100;
    private static Integer MAX_EMAIL_LIMIT=10;
    private Datetime lastRowDtTime;
    public Boolean emailError {get; set;}
    static{
        filter1Crit = new Map<String,String>();
        filter1Crit.put('All','and (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr OR UPLN_GENRTN_3_ACCT_NR__c=:critRepAcctNbr OR UPLN_GENRTN_2_ACCT_NR__c=:critRepAcctNbr)');
        filter1Crit.put('1st Generation Leaders','and (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr and Representative__r.LDRSHP_TITL_LVL_NBR__c!=\'-2\')');
        filter1Crit.put('1st Generation Non-Leaders','and (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'-2\')');
        filter1Crit.put('2nd Generation Leaders','and (UPLN_GENRTN_2_ACCT_NR__c=:critRepAcctNbr and Representative__r.LDRSHP_TITL_LVL_NBR__c!=\'-2\')');
        filter1Crit.put('3rd Generation Leaders','and (UPLN_GENRTN_3_ACCT_NR__c=:critRepAcctNbr and Representative__r.LDRSHP_TITL_LVL_NBR__c!=\'-2\')');
        filter1Crit.put('Title Level -2',uplineCondition+' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'-2\'');
        filter1Crit.put('Title Level 0',uplineCondition+' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'0\'');
        filter1Crit.put('Title Level 1',uplineCondition+' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'1\'');
        filter1Crit.put('Title Level 2',uplineCondition+' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'2\'');
        filter1Crit.put('Title Level 3',uplineCondition+' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'3\'');
        filter1Crit.put('Title Level 4',uplineCondition+' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'4\'');
        filter1Crit.put('Seller Status',uplineCondition+' and Representative__r.MRKT_TOP_SLR_LANG_KEY__c !=null');
        filter1Crit.put('Avon LOA 1-6',uplineCondition+' AND (Representative__r.AVON_LOA_1_6_IND__c=\'Y\')');
        filter1Crit.put('Avon LOA 7 - 1 year',uplineCondition+' AND (Representative__r.AVON_LOA_7_1_YR_IND__c=\'Y\')');
        filter1Crit.put('Avon LOA + 1 year',uplineCondition+' AND (Representative__r.AVON_LOA_1_YR_PLUS_IND__c=\'Y\')');
        filter1Crit.put('Leadership LOA + 1 year',uplineCondition+' AND (Representative__r.LDRSHP_LOA_1_YR_PLUS_IND__c=\'Y\')');
        filter1Crit.put('Leadership LOA 1-6',uplineCondition+' AND (Representative__r.LDRSHP_LOA_1_6_IND__c=\'Y\')');
        filter1Crit.put('Leadership LOA 7 - 1 year',uplineCondition+' AND (Representative__r.LDRSHP_LOA_7_1_YR_IND__c=\'Y\')');
        

        filter2Crit = new Map<String,String>();
        filter2Crit.put('All Conditions','');
        filter2Crit.put('No Personal Order',' and (Personal_Sales__c=null or Personal_Sales__r.NET_SLS_AMT__c<=0)');
        filter2Crit.put('Order Qualifier not Achieved','');
        filter2Crit.put('Order Qualifier Achieved','');
        filter2Crit.put('Past Due',' and (Personal_Sales__r.PAST_DUE_AMT__c> 0)');
        filter2Crit.put('Hold Order',' and (Personal_Sales__r.ORD_HOLD_AMT__c> 0)');
        filter2Crit.put('Title at Risk',' and (Representative__r.LDRSHP_TAR_IND__c=\'Y\')');
        filter2Crit.put('Title Lost',' and (Representative__r.LDRSHP_TITL_DMTD_IND__c=\'Y\')');
        filter2Crit.put('Promoted to Next Level',' and (Representative__r.LDRSHP_TITL_PROMTD_IND__c=\'Y\')');
        filter2Crit.put('Avon Anniversary (upcoming)',' and (Representative__r.ANNIV_WITHIN_10_DAYS__c=\'TRUE\')');
        filter2Crit.put('Birthday (upcoming)',' and (Representative__r.BDAY_WITHIN_10_DAYS__c=\'TRUE\')');
        filter2Crit.put('Potential Removal',' and (Representative__r.INACTV_CMPGN_CNT__c >= 2)');
        filter2Crit.put('Removed',' and Representative__r.REP_OMS_STUS_CD__c=\'2\' and (Representative__r.REP_RMOVL_CMPGN_NR__c=:prevCmpgnNbr or Representative__r.REP_RMOVL_CMPGN_NR__c=:currCmpgnNbr) ');
        filter2Crit.put('Performance Points',' and (Personal_Sales__r.PRFRMNC_POINT_QTY__c > 0)');
    }
    MarketLeaderTitleUtils ldrTitlUtils;
    
    MarketSellerStsUtils sellStsUtils;
    private Integer ITEMS_PER_ROW = 4;
    private static String BASE_SOQL=
                                    'Select SystemModstamp,MRKT_ID__c,'+
                                    '       UPLN_GENRTN_3_ACCT_NR__c, UPLN_GENRTN_2_ACCT_NR__c,'+ 
                                    '       UPLN_GENRTN_1_ACCT_NR__c, '+ 
                                    '       MRKT_ACCT_KEY__c,'+ 
                                    '       UPLN_GENRTN_1_FULL_NM__c,'+ 
                                    '       LDRSHP_TITL_LVL_NR__c, Id,'+ 
                                    '       DWNLN_GENRTN_LVL_CNT__c, ACCT_NR__c,'+
                                    '       MLdr_GRP_AWRD_SLS_AMT__c,'+ 
                                    '       Personal_Sales__c,Group_Sales__c,'+
                                    '       Personal_Sales__r.NET_SLS_AMT__c,'+
                                    '       Personal_Sales__r.AWRD_SLS_AMT__c,'+
                                    '       Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c,'+
                                    '       Representative__r.Name,'+
                                    '       Representative__r.LDRSHP_TITL_LVL_NBR__c,'+
                                    '       Representative__r.MRKT_TOP_SLR_LANG_KEY__c,'+
                                    '       Representative__r.Phone,'+
                                    '       Representative__r.ACCT_NR__c,'+
                                    '       Representative__r.FirstName,'+
                                    '       Representative__r.LastName,'+
                                    '       Group_Sales__r.GENRTN_1_GRP_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.CC_TOTAL_ORD_RCVD__c'    +       
                                    ' From  Genealogy__c '+
                                    ' where MRKT_ID__c=:mktId ';   
                                       
    public String getInitialize(){
        if(emailError==null){
            emailError=false;   
        }
        if(this.srchCrit == null){
            /*
                Default Criteria for Leader: Get all 1st/2nd and 3rd Gen Downlines 
            */
            this.srchCrit = new Search_Criteria__c( Ldr_Gene_Filter_1__c='1st Generation Leaders',
                                                    Ldr_Gene_Filter_2__c='All Conditions');
        }
        if(this.ldrTitlUtils == null || this.sellStsUtils == null){
            currUser = [select LanguageLocaleKey,MRKT_ID__c from User 
                             where Id=:UserInfo.getUserId()];
            if(this.ldrTitlUtils == null){
                ldrTitlUtils = new MarketLeaderTitleUtils();
                this.leaderTitles = ldrTitlUtils.initializeAndRetList(currUser);
            }
            if(this.sellStsUtils == null){
                sellStsUtils = new MarketSellerStsUtils();
                sellStsUtils.initialize(currUser);
            }
        }
        if(this.market==null){
            this.market = [
                                Select  SPPY_CMPGN_NR__c, PREV_1_CMPGN_NR__c, Name, 
                                        Market_Id__c, Mail_Plan_Enabled__c, CURRNT_CMPGN_RMN_DAY_CNT__c, 
                                        CMPGN_STRT_DT__c, CMPGN_NR__c, CMPGN_END_DT__c,
                                        LAST_UPDT_DT__c
                                From    Market__c   
                                where   Market_Id__c =:currUser.MRKT_ID__c];
            
        }
        
        System.debug('>>>>>>>>>>>>>>>>>>>>>this.drillDownAcctNbr='+this.drillDownAcctNbr);
        if(this.drillDownAcctNbr == null || this.drillDownAcctNbr == ''){
            if(!impersonate && this.repAcctNbr ==null){
                this.repAcctNbr =   [   select  ACCT_NR__c,MRKT_ID_ACCT_NR_KEY__c
                                        from    User
                                        where   Id = :UserInfo.getUserId()
                                    ].ACCT_NR__c;
            }
            this.drillDownAcctNbr = this.repAcctNbr;
        }
        String currRepId = currUser.MRKT_ID__c+this.drillDownAcctNbr;
        System.debug('>>>>>>>>>>>>>>>>>>>>>this.repAcctNbr='+this.repAcctNbr);
        System.debug('>>>>>>>>>>>>>>>>>>>>>this.drillDownAcctNbr='+this.drillDownAcctNbr);
        System.debug('>>>>>>>>>>>>>>>>>>>>>this.currRepId='+currRepId);
        String currRepSoql = BASE_SOQL +' and MRKT_ACCT_KEY__c=:currRepId LIMIT 1';
        System.debug('>>>>>>>>>>>>>>>>>>>>> CURR REP SOQL='+currRepSoql);
        String mktId = currUser.MRKT_ID__c;
        Genealogy__c currRepGene = Database.query(currRepSoql);
        this.currRep = new MyDownlineClass(currRepGene,
                                            ldrTitlUtils.getLeaderTitle(currRepGene.Representative__r.LDRSHP_TITL_LVL_NBR__c),
                                            sellStsUtils.getSellerStatus(currRepGene.Representative__r.MRKT_TOP_SLR_LANG_KEY__c),
                                            currRepGene.Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c
                                            );
        this.currRep.setGenerationNbr(this.repAcctNbr);        
        
        if(this.currLdrTitle == null){
            for(Leader_Title__c titl: this.leaderTitles){
                if(titl.LDRSHP_TITL_LVL_NR__c == currRepGene.Representative__r.LDRSHP_TITL_LVL_NBR__c){
                    currLdrTitle=titl;
                    break;  
                }
            }
        }
        System.debug('>>>>>>>>>>>>>this.currLdrTitle='+this.currLdrTitle);
        getDownlineRecords();
        System.debug('>>>>>>>>>>>>>>Search Filter='+this.srchCrit);
        //System.debug('>>>>>>>>>>>>>>> downlineGroups'+this.downlineGroups);
        if(printSelected ==null){
            printSelected=false;
        }
        return '';
    }
    public PageReference next(){
        emailError=false;
        startRow=endRow+1;
        endRow +=MAX_ROWS_PER_PAGE;
        getDownlineRecords();
        pageNbr++;
        return null;
    }
    public PageReference previous(){
        emailError=false;
        startRow-=MAX_ROWS_PER_PAGE;
        endRow-=MAX_ROWS_PER_PAGE;
        getDownlineRecords();
        pageNbr--;
        return null;
    }

    public PageReference filterRecords(){
       //this.lastRowDtTime = null;
        emailError=false;
       startRow=null;
       endRow=null;
       pageNbr=1;
        printSelected=false;
        getDownlineRecords();
        return null;
    }
    
    public PageReference printSelected(){
        emailError=false;
        printAcctNbrs = getSelectedAcctNbrs();
        /*if(acctNbrs.length()>0){
            PageReference repDetail = Page.RepDetail;
            repDetail.getParameters().put('acctNbr',acctNbrs);
            repDetail.getParameters().put('print','1');
            if(impersonate){
                repDetail.getParameters().put('retPgId','12');
            }else{
                repDetail.getParameters().put('retPgId','4');
            }
            
            return repDetail;       
        }else{
            return null;
        }*/
        printSelected=true;
        return null;        
    }
    
    public PageReference emailSelected(){
        printSelected=false;
        String acctNbrs = getSelectedAcctNbrs();
        /*
            String[] acctNbrList = acctNbrs.split(',');
            if(acctNbrList.size()>MAX_EMAIL_LIMIT){
            emailError=true;
            return null;
        }*/
        if(acctNbrs.length()>0){
            PageReference emailRep = Page.EmailReps;
            emailRep.getParameters().put('acctNbr',acctNbrs);
            emailRep.getParameters().put('rptName','Downline');
            if(impersonate){
                emailRep.getParameters().put('retUrl',EncodingUtil.urlEncode('/apex/LeaderInfo?pgId=12&section=Downline','UTF-8'));
            }else{
                emailRep.getParameters().put('retUrl',EncodingUtil.urlEncode('/apex/LeaderMyDownline?pgId=4','UTF-8'));
            }
            
            return emailRep;        
        }else{
            return null;
        }       
        
        return null;        
    }
    public Boolean getCanDrilldown(){
        //System.debug('>>>>>>>>>>>>this.repAcctNbr='+this.repAcctNbr);
        //System.debug('>>>>>>>>>>>>this.currRep.genealogy.UPLN_GENRTN_3_ACCT_NR__c='+this.currRep.genealogy.UPLN_GENRTN_3_ACCT_NR__c);
        //System.debug('>>>>>>>>>>>>this.drillDownAcctNbr='+this.drillDownAcctNbr);
        if(this.repAcctNbr == this.drillDownAcctNbr){
            return true;
        }else if(this.repAcctNbr == this.currRep.genealogy.UPLN_GENRTN_3_ACCT_NR__c){
            return false;   
        }else{
            return true;    
        }
    }
    public PageReference drillDown(){
      this.srchCrit = new Search_Criteria__c( Ldr_Gene_Filter_1__c='1st Generation Leaders',
                                                Ldr_Gene_Filter_2__c='All Conditions');
      
        String currRepId = currUser.MRKT_ID__c+this.drillDownAcctNbr;
        String currRepSoql = BASE_SOQL +' and MRKT_ACCT_KEY__c=:currRepId LIMIT 1';
        System.debug('>>>>>>>>>>>>>>>>>>>>> CURR REP SOQL='+currRepSoql);
        String mktId = currUser.MRKT_ID__c;
        System.debug('>>>>>>>>>>>>>>>>>>>>>>> this.drillDownAcctNbr='+this.drillDownAcctNbr);       
        System.debug('>>>>>>>>>>>>>>>>>>>>>>> currRepId='+currRepId);       
        System.debug('>>>>>>>>>>>>>>>>>>>>>>> mktId='+mktId);       
        Genealogy__c currRepGene = Database.query(currRepSoql);
        
        this.currRep = new MyDownlineClass(currRepGene,
                                            ldrTitlUtils.getLeaderTitle(currRepGene.Representative__r.LDRSHP_TITL_LVL_NBR__c),
                                            sellStsUtils.getSellerStatus(currRepGene.Representative__r.MRKT_TOP_SLR_LANG_KEY__c),
                                            currRepGene.Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c);

    this.currRep.setGenerationNbr(this.repAcctNbr);        
        for(Leader_Title__c titl: this.leaderTitles){
            if(titl.LDRSHP_TITL_LVL_NR__c == currRepGene.Representative__r.LDRSHP_TITL_LVL_NBR__c){
                currLdrTitle=titl;
                break;  
            }
        }
        printSelected=false;
        getDownlineRecords();
        return null;
    } 
    private void getDownlineRecords(){
        //try{
            Integer dwnLineCnt = 0;
            this.totalDownlines=0;
            Integer recCount=0;
            DownlineGroup downlineGroup = new DownlineGroup();
            this.downlineGroups = new List<DownlineGroup>();
            String critRepAcctNbr = this.drillDownAcctNbr;
            String mktId = this.currRep.genealogy.MRKT_ID__c;
            String prevCmpgnNbr = this.market.PREV_1_CMPGN_NR__c;
            String currCmpgnNbr = this.market.CMPGN_NR__c;
            MyDownlineClass downlineRec ;
            //Datetime timeStampCrit = this.lastRowDtTime;
            if(startRow==null){
                startRow=1;
            }
            if(endRow==null){
                endRow = MAX_ROWS_PER_PAGE; 
            }
            if(pageNbr ==null){
                pageNbr=1;
            }
            for(Genealogy__c downline : Database.query(generateSoql())){
                downlineRec = new MyDownlineClass(  downline,
                                                    ldrTitlUtils.getLeaderTitle(downline.Representative__r.LDRSHP_TITL_LVL_NBR__c),
                                                    sellStsUtils.getSellerStatus(downline.Representative__r.MRKT_TOP_SLR_LANG_KEY__c),
                                                    currLdrTitle,
                                                    this.repAcctNbr); 
                if( this.srchCrit.Ldr_Gene_Filter_2__c=='Order Qualifier not Achieved' && 
                    downlineRec.achievementFlag !=2)
                {
                    continue;   
                }
                if( this.srchCrit.Ldr_Gene_Filter_2__c=='Order Qualifier Achieved' && 
                    downlineRec.achievementFlag !=3)
                {
                    continue;   
                }
                recCount++;
                System.debug('>>>>>>>>>>>>>>>> startRow:'+startRow+',endRow:'+endRow+',recCount='+recCount);
                if(recCount<startRow){
                    continue;   
                }
                //this.lastRowDtTime = downline.SystemModstamp;
                downlineGroup.downlines.add(downlineRec);
                dwnLineCnt++;
                totalDownlines++;
                if((dwnLineCnt/ITEMS_PER_ROW) == 1){
                    dwnLineCnt=0;
                    this.downlineGroups.add(downlineGroup);
                    downlineGroup = new DownlineGroup();
                }
                System.debug('>>>>>>>>>>>>>>>>>>>>>> DOWNLINE GROUP.size():'+downlineGroup.downlines.size());
                if(recCount == endRow){
                    System.debug('>>>>>>>>>>>>>>>>> Total rows per page reached.Breaking out now....');
                    break;
                }
                
            }
            this.downlineGroups.add(downlineGroup);
        /*}catch(Exception ex){
        }*/
        
        
    }
    private String generateSoql(){
        String tempSoql = BASE_SOQL;
        /*if(this.srchCrit.Ldr_Gene_Filter_1__c ==null){
            this.srchCrit.Ldr_Gene_Filter_1__c='1st Generation Leaders';   
        }
        if(this.srchCrit.Ldr_Gene_Filter_2__c ==null){
            this.srchCrit.Ldr_Gene_Filter_2__c='All Conditions';    
        }*/
        tempSoql += filter1Crit.get(this.srchCrit.Ldr_Gene_Filter_1__c);
        tempSoql += filter2Crit.get(this.srchCrit.Ldr_Gene_Filter_2__c);
        if(this.srchCrit.Ldr_Gene_Filter_2__c != 'Removed' && this.srchCrit.Ldr_Gene_Filter_2__c != 'Past Due'){
             tempSoql += ' and Representative__r.REP_OMS_STUS_CD__c=\'1\'';
        }
        if(this.currRep.genNbr=='I'){
          tempSoql +=' and (UPLN_GENRTN_2_ACCT_NR__c=\''+this.repAcctNbr+'\' or UPLN_GENRTN_3_ACCT_NR__c=\''+this.repAcctNbr+'\') ';  
        }
        if(this.currRep.genNbr=='II'){
          tempSoql +=' and UPLN_GENRTN_3_ACCT_NR__c=\''+this.repAcctNbr+'\' ';  
        }
        /*if(this.lastRowDtTime !=null){
            tempSoql +=' and SystemModstamp >:timeStampCrit';   
        }*/
        System.debug('>>>>>>>>>>>>>>>>>>>> SOQL='+tempSoql);
        tempSoql += ' order by Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c desc NULLS LAST';
        return tempSoql;     
               
    }
    
    private String getSelectedAcctNbrs(){
        String tempStr = '';
        for(DownlineGroup grp: this.downlineGroups){
            for(MyDownlineClass downline: grp.downlines){
                if(downLine.selected){
                    tempStr+=downline.genealogy.MRKT_ACCT_KEY__c+',';
                    
                }
                        
            }   
        }
        return tempStr;
    }
    
    public static testmethod void testGeneController(){
        GenealogyComponentController ctlr = new GenealogyComponentController();
        TestDataHelper testData = new TestDataHelper();
        String mktIdKey = '123456';
        testData.createMarket();
        GenealogyComponentController.MAX_ROWS_PER_PAGE=2;
        
        User ldrUser = testData.createLeaderUser(mktIdKey);
        List<Genealogy__c> geneData = testData.createDownlineData(mktIdKey,6,ldrUser.Id);
        System.runAs(ldrUser){
            ctlr.impersonate=false;
            ctlr.repAcctNbr = testData.testContact.ACCT_NR__c;
            ctlr.getInitialize();
            System.debug('>>>>>>>>>>>ctlr.downlineGroups='+ctlr.downlineGroups);
            System.debug('>>>>>>>>>>>ctlr.downlineGroup[0]='+ctlr.downlineGroups[0].downlines.size());
            //System.assert(ctlr.downlineGroups.size()==2);
            DownlineGroup grp = ctlr.downlineGroups[0];
            //System.assert(grp.downlines.size()==4);
            grp.downlines[0].selected=true;
            grp.downlines[1].selected=true;
            PageReference pageRef = ctlr.printSelected();
            System.debug('********************* ctlr.printAcctNbrs='+ctlr.printAcctNbrs);
            //System.assert(ctlr.printAcctNbrs==    grp.downlines[0].genealogy.MRKT_ACCT_KEY__c+','+
            //                                  grp.downlines[1].genealogy.MRKT_ACCT_KEY__c+',');
            pageRef = ctlr.emailSelected();
            System.debug('********************* pageRef.getUrl='+pageRef.getUrl());
            //System.assert(pageRef.getUrl()=='/apex/emailreps?acctNbr=XX1234560%2CXX1234561%2C&retUrl=%252Fapex%252FLeaderMyDownline%253FpgId%253D4&rptName=Downline');
            //System.assert(ctlr.getCanDrilldown()==true);
            ctlr.filterRecords();
            ctlr.drillDownAcctNbr = testData.testContact.ACCT_NR__c;//geneData[1].Representative__r.MRKT_ACCT_KEY__c;
            System.assert(ctlr.getCanDrilldown()==true);
            ctlr.drillDown();
            ctlr.next();
            ctlr.previous();
            ctlr.ITEMS_PER_ROW=1;
            ctlr = new GenealogyComponentController();
            ctlr.impersonate=false;
            ctlr.repAcctNbr = testData.testContact.ACCT_NR__c;
            
            ctlr.getInitialize();
        }
    }
}
			                            	