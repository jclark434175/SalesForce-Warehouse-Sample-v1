public class MyMarketController {
    public String repAcctNbr {get; set;}
    public String drillDownAcctNbr {get; set;}
    public String filter1 {get; set;}
    public String filter2 {get; set;}
    public String zoneFilter {get; set;}
    public List<DownlineGroup> downlineGroups {get; set;}
    public Integer totalDownlines {get; set;}
    public Integer recCount {get; set;}
    public Search_Criteria__c srchCrit {get; set;}
    public Market__c market {get; set;}
    public String userProfile {get; private set;}
    public List<Leader_Title__c> leaderTitles {get; private set;}
    private static Map<String,String> filter1Crit;
    private static Map<String,String> filter2Crit = new Map<String,String>();
    private User currUsr;
    public List<String> zoneList {get; private set;}
    public String printAcctNbrs {get; private set;}
    public Boolean printSelected {get; private set;}

    public Integer endRow {get; private set;}
    public Integer startRow {get; private set;}
    public Integer pageNbr {get; private set;}
    
    private static Integer MAX_ROWS_PER_PAGE=100;
    
    static{
        filter1Crit = new Map<String,String>();
        filter1Crit.put('All','');
        filter1Crit.put('All Leaders',' AND (and Representative__r.LDRSHP_TITL_LVL_NBR__c!=\'-2\')');
        filter1Crit.put('Non-Leadership',' AND (and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'-2\')');
        filter1Crit.put('Title Level 0',' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'0\'');
        filter1Crit.put('Title Level 1',' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'1\'');
        filter1Crit.put('Title Level 2',' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'2\'');
        filter1Crit.put('Title Level 3',' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'3\'');
        filter1Crit.put('Title Level 4',' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'4\'');
        filter1Crit.put('Title Level -2',' and Representative__r.LDRSHP_TITL_LVL_NBR__c=\'-2\'');
        /*
Avon LOA 1-6
Avon LOA 7 - 1 year
Avon LOA + 1 year
Leadership LOA 1-6
Leadership LOA 7 - 1 year
Leadership LOA + 1 yea  r     
        */
        filter1Crit.put('Seller Status',' AND (Representative__r.MRKT_TOP_SLR_LANG_KEY__c !=null)');
        filter1Crit.put('Length Association 1 - 6',' AND (Representative__r.LDRSHP_LOA_1_6_IND__c=\'Y\')');
        filter1Crit.put('Length Association 7 - 1 year',' AND (Representative__r.LDRSHP_LOA_7_1_YR_IND__c=\'Y\')');
        filter1Crit.put('Length Association - +1 year',' AND (Representative__r.LDRSHP_LOA_1_YR_PLUS_IND__c=\'Y\')');
        filter1Crit.put('Avon LOA 1-6',' AND (Representative__r.AVON_LOA_1_6_IND__c=\'Y\')');
        filter1Crit.put('Avon LOA 7 - 1 year',' AND (Representative__r.AVON_LOA_7_1_YR_IND__c=\'Y\')');
        filter1Crit.put('Avon LOA + 1 year',' AND (Representative__r.AVON_LOA_1_YR_PLUS_IND__c=\'Y\')');
        filter1Crit.put('Leadership LOA + 1 year',' AND (Representative__r.LDRSHP_LOA_1_YR_PLUS_IND__c=\'Y\')');
        filter1Crit.put('Leadership LOA 1-6',' AND (Representative__r.LDRSHP_LOA_1_6_IND__c=\'Y\')');
        filter1Crit.put('Leadership LOA 7 - 1 year',' AND (Representative__r.LDRSHP_LOA_7_1_YR_IND__c=\'Y\')');
        //filter1Crit.put('Removed',' and Representative__r.REP_OMS_STUS_CD__c=\'2\' and (Representative__r.REP_RMOVL_CMPGN_NR__c=:prevCmpgnNbr or Representative__r.REP_RMOVL_CMPGN_NR__c=:currCmpgnNbr)');
        filter1Crit.put('New Addition',' AND (Representative__r.REP_APPT_CMPGN_NR=:currCmpgnNbr)');

        filter2Crit = new Map<String,String>();
        filter2Crit.put('All Conditions','');
        filter2Crit.put('No Personal Order',' and (Personal_Sales__c=null or Personal_Sales__r.NET_SLS_AMT__c<=0)');
        filter2Crit.put('Order Qualifier not Achieved',' AND (Personal_Sales__r.NET_SLS_AMT__c>0 and Personal_Sales__r.ORD_UND_MIN_IND__c=\'Y\')');
        filter2Crit.put('Order Qualifier Achieved',' AND (Personal_Sales__r.NET_SLS_AMT__c>0 and Personal_Sales__r.ORD_UND_MIN_IND__c=\'N\')');
        filter2Crit.put('Past Due',' AND (Personal_Sales__r.PAST_DUE_AMT__c> 0)');
        filter2Crit.put('Hold Order',' AND (Personal_Sales__r.ORD_HOLD_AMT__c> 0)');
        filter2Crit.put('Title at Risk',' AND (Representative__r.LDRSHP_TAR_IND__c=\'Y\')');
        filter2Crit.put('Title Lost',' AND (Representative__r.LDRSHP_TITL_DMTD_IND__c=\'Y\')');
        filter2Crit.put('Promoted to Next Level',' AND (Representative__r.LDRSHP_TITL_PROMTD_IND__c=\'Y\')');
        filter2Crit.put('Avon Anniversary (upcoming)',' AND (Representative__r.ANNIV_WITHIN_10_DAYS__c=\'TRUE\')');
        filter2Crit.put('Birthday (upcoming)',' AND (Representative__r.BDAY_WITHIN_10_DAYS__c=\'TRUE\')');
        filter2Crit.put('Potential Removal',' and (Representative__r.INACTV_CMPGN_CNT__c >= 2) ');
        filter2Crit.put('Removed',' and Representative__r.REP_OMS_STUS_CD__c=\'2\' and (Representative__r.REP_RMOVL_CMPGN_NR__c=:prevCmpgnNbr or Representative__r.REP_RMOVL_CMPGN_NR__c=:currCmpgnNbr)');
        filter2Crit.put('Performance Points',' AND (Personal_Sales__r.PRFRMNC_POINT_QTY__c > 0)');
    }
    MarketLeaderTitleUtils ldrTitlUtils;
    MarketSellerStsUtils sellStsUtils;
    private Integer ITEMS_PER_ROW = 4;
    private static String BASE_SOQL=
                                    'Select MRKT_ID__c,'+ 
                                    '       UPLN_GENRTN_3_ACCT_NR__c, UPLN_GENRTN_2_ACCT_NR__c,'+ 
                                    '       UPLN_GENRTN_1_ACCT_NR__c, '+ 
                                    '       MRKT_ACCT_KEY__c,'+ 
                                    '       UPLN_GENRTN_1_FULL_NM__c,'+ 
                                    '       LDRSHP_TITL_LVL_NR__c, Id,'+ 
                                    '       DWNLN_GENRTN_LVL_CNT__c, ACCT_NR__c,'+
                                    '    MLdr_GRP_AWRD_SLS_AMT__c,' +  
                                    '       Personal_Sales__c,Group_Sales__c,'+
                                    '       Personal_Sales__r.NET_SLS_AMT__c,'+
                                    '       Personal_Sales__r.AWRD_SLS_AMT__c,'+
                                    '       Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c,'+
                                    '       Representative__r.LastName,'+
                                    '       Representative__r.FirstName,'+
                                    '       Representative__r.Name,'+
                                    '       Representative__r.LDRSHP_TITL_LVL_NBR__c,'+
                                    '       Representative__r.MRKT_TOP_SLR_LANG_KEY__c,'+
                                    '       Representative__r.Phone,'+
                                    '       Representative__r.ACCT_NR__c,'+
                                    '       Group_Sales__r.GENRTN_1_GRP_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.CC_TOTAL_ORD_RCVD__c'+       
                                    ' From  Genealogy__c '+
                                    ' where MRKT_ID__c =:mktId';         
    public PageReference init(){
        currUsr = [select   Id,DFALT_ZONE_CD__c,DFALT_DIV_NM__c,MRKT_ID__c,
                                LanguageLocaleKey
                        from    User
                        where   Id=:UserInfo.getUserId()];
        Profile usrProfile = [  select  Id,Name
                                from    Profile
                                where   Id=:UserInfo.getProfileId()
                            ];
        this.userProfile = usrProfile.Name;
        if(this.ldrTitlUtils == null || this.sellStsUtils == null){
            if(this.ldrTitlUtils == null){
                ldrTitlUtils = new MarketLeaderTitleUtils();
                this.leaderTitles = ldrTitlUtils.initializeAndRetList(currUsr);
            }
            if(this.sellStsUtils == null){
                sellStsUtils = new MarketSellerStsUtils();
                sellStsUtils.initialize(currUsr);
            }
            this.market = [ select   SPPY_CMPGN_NR__c, PREV_1_CMPGN_NR__c, Name, 
                  Market_Id__c, Mail_Plan_Enabled__c, CURRNT_CMPGN_RMN_DAY_CNT__c, 
                  CMPGN_STRT_DT__c, CMPGN_NR__c, CMPGN_END_DT__c,
                  LAST_UPDT_DT__c
                            from    Market__c
                            where Market_Id__c = :currUsr.MRKT_ID__c];
            
        }
        String key;             
        if(usrProfile.Name == 'Avon Zone Manager'){
            key = currUsr.DFALT_ZONE_CD__c; 
            if(this.zoneList ==null){
                zoneList = new List<String>();
                zoneList.add(key);
                this.zoneFilter = 'All';
            }
        }else if(usrProfile.Name == 'Avon Division Manager'){
            if(this.zoneList ==null){
                zoneList = new List<String>();
                this.zoneFilter = 'All';
                for(Sales_Organization__c slsOrg :[ Select SLS_ZONE_CD__c, SLS_DIV_NM__c 
                                                    From Sales_Organization__c
                                                    where SLS_ORG_LVL_NR__c='Z'
                                                    and SLS_DIV_NM__c = :currUsr.DFALT_DIV_NM__c
                                                    and Market__r.Market_Id__c=:currUsr.MRKT_ID__c]){
                    zoneList.add(slsOrg.SLS_ZONE_CD__c);                                    
                }
            }
        }
        System.debug('>>>>>>>>>>>>>>>>>>>>>>zoneList:'+zoneList);
    
        if(this.srchCrit == null){
            /*
                Default Criteria for Leader: Get all 1st/2nd and 3rd Gen Downlines 
            */
            this.srchCrit = new Search_Criteria__c( Ldr_Gene_Filter_2__c='All Conditions');
            getDownlineRecords();
        }
        if(printSelected==null){
            printSelected=false;    
        }
        System.debug('>>>>>>>>>>>>>>> downlineGroups'+this.downlineGroups);
        return null;
    }

    public PageReference next(){
        startRow=endRow+1;
        endRow +=MAX_ROWS_PER_PAGE;
        getDownlineRecords();
        pageNbr++;
        return null;
    }
    public PageReference previous(){
        startRow-=MAX_ROWS_PER_PAGE;
        endRow-=MAX_ROWS_PER_PAGE;
        getDownlineRecords();
        pageNbr--;
        return null;
    }
    
    public PageReference filterRecords(){
        this.startRow=null;
        this.endRow=null;
        getDownlineRecords();
        printSelected=false;
        pageNbr=1;
        return null;
    }
    
    public PageReference printSelected(){
        this.printAcctNbrs = getSelectedAcctNbrs();
        printSelected=true;
        return null;
    }
    
    public PageReference emailSelected(){
        String acctNbrs = getSelectedAcctNbrs();
        if(acctNbrs.length()>0){
            PageReference emailRep = Page.EmailReps;
            emailRep.getParameters().put('acctNbr',acctNbrs);
            emailRep.getParameters().put('rptName','Downline');
            emailRep.getParameters().put('retUrl',EncodingUtil.urlEncode('/apex/MyMarket?pgId=11','UTF-8'));
            
            return emailRep;        
        }else{
            return null;
        }       
        
        return null;        
    }

    private void getDownlineRecords(){
        //try{
            Integer dwnLineCnt = 0;
            recCount=0;
            this.totalDownlines=0;
            DownlineGroup downlineGroup = new DownlineGroup();
            this.downlineGroups = new List<DownlineGroup>();
            String critRepAcctNbr = this.drillDownAcctNbr;
            List<String> zonesToLook = this.zoneList;
            String zoneCd = this.zoneFilter;
            String mktId = this.market.Market_Id__c;
            System.debug('>>>>>>>>>>>>>>>>>>>>       mktId:'+mktId);
            System.debug('>>>>>>>>>>>>>>>>>>>>      zoneCd:'+zoneCd);
            System.debug('>>>>>>>>>>>>>>>>>>>> zonesToLook:'+zonesToLook);
            String prevCmpgnNbr = this.market.PREV_1_CMPGN_NR__c;
            String currCmpgnNbr = this.market.CMPGN_NR__c;
            
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
              //System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>totalDownlines='+totalDownlines+',recCount='+recCount+',startRow='+startRow+',endRow='+endRow);
              recCount++;
                if(recCount<startRow){
                    continue;   
                }
                totalDownlines++;
                downlineGroup.downlines.add(new MyDownlineClass(  downline,
                                        ldrTitlUtils.getLeaderTitle(downline.Representative__r.LDRSHP_TITL_LVL_NBR__c),
                                                          sellStsUtils.getSellerStatus(downline.Representative__r.MRKT_TOP_SLR_LANG_KEY__c),
                                                          downline.Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c));
                dwnLineCnt++;
                if((dwnLineCnt/ITEMS_PER_ROW) == 1){
                    dwnLineCnt=0;
                    this.downlineGroups.add(downlineGroup);
                    downlineGroup = new DownlineGroup();
                }
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
        if(this.zoneFilter=='All'){
            tempSoql += ' AND Representative__r.SLS_ZONE_CD__c in :zonesToLook';
        }else{
            tempSoql += ' AND Representative__r.SLS_ZONE_CD__c=:zoneCd';
        }   
        String currCmpgnNbr = this.market.CMPGN_NR__c;

        if(this.srchCrit.Ldr_Gene_Filter_2__c != 'Removed' && this.srchCrit.Ldr_Gene_Filter_2__c != 'Past Due'){
           tempSoql += ' and Representative__r.REP_OMS_STUS_CD__c=\'1\'';
        }
        
        if(this.srchCrit.Zone_Gene_Filter_1__c ==null){
            this.srchCrit.Zone_Gene_Filter_1__c='Title Level 3';    
        }
        if(this.srchCrit.Ldr_Gene_Filter_2__c ==null){
            this.srchCrit.Ldr_Gene_Filter_2__c='All Conditions';    
        }
        tempSoql += filter1Crit.get(this.srchCrit.Zone_Gene_Filter_1__c);
        tempSoql += filter2Crit.get(this.srchCrit.Ldr_Gene_Filter_2__c);
        tempSoql +=' order by Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c desc NULLS LAST';
        System.debug('>>>>>>>>>>>>>>>>>>>> SOQL='+tempSoql);
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

    public static testmethod void testMyMarket(){
        TestDataHelper testData= new TestDataHelper();
        testData.createMarket();
        testData.createSalesOrgs();
        User testUsr = testData.createZoneUser('Z123456');
        List<Genealogy__c> geneData = testData.createDownlineData('123456',6,testUsr.Id);
        
        MyMarketController ctlr = new MyMarketController();
        PageReference pageRef = Page.MyMarket;
        Test.setCurrentPage(pageRef);

        //MyMarketController.MAX_ROWS_PER_PAGE=2;
        System.runAs(testUsr ){
            //ctlr.repAcctNbr = testData.testContact.MRKT_ACCT_KEY__c;
            ctlr.init();
            System.debug('>>>>>>>>>>>>>>> ctlr.downlineGroups.size()='+ctlr.downlineGroups.size());
            System.assert(ctlr.downlineGroups.size()==1);
            DownlineGroup grp = ctlr.downlineGroups[0];
            System.debug('>>>>>>>>>>>>>>> ctlr.downlineGroups[0].downlines.size()='+ctlr.downlineGroups[0].downlines.size());
            //System.assert(grp.downlines.size()==1);
            //grp.downlines[0].selected=true;
            //grp.downlines[1].selected=true;
            PageReference pageRef1 = ctlr.printSelected();
            pageRef1 = ctlr.emailSelected();
            //System.debug('>>>>>>>> Email Url:'+pageRef1.getUrl());
            //System.assert(pageRef1.getUrl()=='/apex/emailreps?acctNbr=XX1234563%2C&retUrl=%252Fapex%252FMyMarket%253FpgId%253D11&rptName=Downline');
            ctlr.srchCrit.Zone_Gene_Filter_1__c='All';
            ctlr.filterRecords();
            //System.assert(ctlr.downlineGroups.size()==3);
            ctlr = new MyMarketController();
            ctlr.init();
            ctlr.next();
            ctlr.previous();
            ctlr.zoneFilter='Z1';
            ctlr.filterRecords();
            System.debug('>>>>>>>>>>>>>>> ctlr.downlineGroups.size()='+ctlr.downlineGroups.size());
            
        }   
        ctlr = new MyMarketController();
        testUsr = testData.createDivUser('D123456');
        geneData = testData.createDownlineData('X123456',6,testUsr.Id);
        System.runAs(testUsr ){
            //ctlr.repAcctNbr = testData.testContact.MRKT_ACCT_KEY__c;
            ctlr.init();
            System.debug('>>>>>>>>>>>>>>> ctlr.downlineGroups.size()='+ctlr.downlineGroups.size());
            System.assert(ctlr.downlineGroups.size()==1);
            DownlineGroup grp = ctlr.downlineGroups[0];
            //System.assert(grp.downlines.size()==1);
        }   
    }
}
			                            	