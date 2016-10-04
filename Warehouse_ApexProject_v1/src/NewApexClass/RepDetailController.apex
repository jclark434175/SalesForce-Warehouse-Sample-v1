public class RepDetailController {
    public List<DrilldownReportRow> contactList {get; private set;}
    public User currUsr {get; set;} 
    public Market__c market {get; private set;}
    private MarketTagUtils mktTags;
    private MarketSellerStsUtils sellStsUtils;
    private MarketLeaderTitleUtils ldrTitlUtils;
    private Map<String,Sales_Organization__c> salesOrgMap;
    public DrilldownReportRow firstContact {get; private set;}

    private static String BASE_SOQL=
                                    'Select UPLN_GENRTN_3_ACCT_NR__c, UPLN_GENRTN_2_ACCT_NR__c,'+ 
                                    '       UPLN_GENRTN_1_ACCT_NR__c, '+ 
                                    '       MRKT_ACCT_KEY__c,UPLN_GENRTN_1_PHON_NR__c,'+ 
                                    '       UPLN_GENRTN_1_FULL_NM__c,'+ 
                                    '       LDRSHP_TITL_LVL_NR__c, Id,'+ 
                                    '       DWNLN_GENRTN_LVL_CNT__c, ACCT_NR__c,'+
                                    '       Personal_Sales__c,Group_Sales__c,'+
                                    '       Representative__r.MRKT_ID__c,'+
                                    '       Representative__r.Birthday__c,'+
                                    '       Representative__r.Name,'+
                                    '       Representative__r.Email,'+
                                    '       Representative__r.HomePhone,'+
                                    '       Representative__r.MobilePhone,'+
                                    '       Representative__r.Phone,'+
                                    '       Representative__r.MailingStreet,'+
                                    '       Representative__r.MailingCity,'+
                                    '       Representative__r.MailingState,'+
                                    '       Representative__r.MailingPostalCode,'+
                                    '       Representative__r.MailingCountry,'+
                                    '       Representative__r.REP_ADDR_STR_2_TXT__c,'+
                                    '       Representative__r.REP_ADDR_STR_3_TXT__c,'+
                                    '       Representative__r.REP_ADDR_STR_4_TXT__c,'+
                                    '       Representative__r.REP_CNTRY_CD__c,'+
                                    '       Representative__r.ACCT_NR__c,'+
                                    '       Representative__r.REP_LANG_CD__c,'+     
                                    '       Representative__r.MRKT_TOP_SLR_LANG_KEY__c,'+
                                    '       Representative__r.LDRSHP_TITL_LVL_NBR__c,'+
                                    '       Representative__r.SLS_ZONE_CD__c,'+
                                    '       Representative__r.REP_APPT_DT__c,'+
                                    '       Representative__r.TERR_IND__c,'+
                                    '       Representative__r.LOA_NR__c,'+
                                    '       Representative__r.LDRSHP_LOA_NR__c,'+ 
                                    '       Representative__r.Birthdate,'+
                                    '       Representative__r.PATD_CERTFCTN_IND__c,'+
                                    '       Representative__r.PATD_CERTFCTN_LVL_DESC_TXT__c,'+
                                    '       Representative__r.LDRSHP_TAR_IND__c,'+
                                    '       Representative__r.MRKT_ZONE_MLPLN_KEY__c,'+
                                    '       Representative__r.MRKT_SLS_ORG_KEY__c,'+
                                    '       Representative__r.DETL_CNTCT_MRKT_TAG_1_AMT__c,'+
                                    '       Representative__r.DETL_CNTCT_MRKT_TAG_2_NR__c,'+
                                    '       Representative__r.DETL_CNTCT_MRKT_TAG_3_PCT__c,'+
                                    '       Representative__r.DETL_CNTCT_MRKT_TAG_4_TXT__c,'+
                                    '       Representative__r.MLPLN_CD__c,'+
                                    '       Personal_Sales__r.AWRD_SLS_AMT__c,'+
                                    '       Personal_Sales__r.PC_AWRD_SLS_AMT__c,'+
                                    '       Personal_Sales__r.YTD_AWRD_SLS_AMT__c,'+
                                    '       Personal_Sales__r.BAL_DUE_AMT__c,'+
                                    '       Personal_Sales__r.RTURN_NET_SLS_AMT__c,'+
                                    '       Personal_Sales__r.Percent_of_Current_Net_Sales__c,'+
                                    '       Personal_Sales__r.YTD_RTURN_NET_SLS_AMT__c,'+
                                    '       Personal_Sales__r.Percent_of_YTD_Net_Sales__c,'+
                                    '       Personal_Sales__r.PAST_DUE_AMT__c,'+
                                    '       Personal_Sales__r.AVG_CUST_CNT__C,'+
                                    '       Personal_Sales__r.YTD_CUST_SERVD_CNT__c,'+
                                    '       Personal_Sales__r.DETL_SLS_MRKT_TAG_1_AMT__c,'+
                                    '       Personal_Sales__r.DETL_SLS_MRKT_TAG_2_NR__c,'+
                                    '       Personal_Sales__r.DETL_SLS_MRKT_TAG_3_PCT__c,'+
                                    '       Personal_Sales__r.DETL_SLS_MRKT_TAG_4_TXT__c,'+
                                    '       Personal_Sales__r.YTD_AVG_CUST_CNT__c,'+
                                    '       Group_Sales__r.GENRTN_1_GRP_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.CC_GRP_NO_ORD_CNT__c,'+
                                    '       Group_Sales__r.CC_GRP_ORD_ABV_MIN_CNT__c,'+
                                    '       Group_Sales__r.CC_GRP_ORD_UND_MIN_CNT__c,'+
                                    '       Group_Sales__r.TOTAL_TAR_CNT__c,'+
                                    '       Group_Sales__r.TOTAL_CTT_CNT__c,'+
                                    '       Group_Sales__r.CC_GRP_AVG_CUST_CNT__c,'+
                                    '       Group_Sales__r.YTD_CUST_SERVD_CNT__c,'+
                                    '       Group_Sales__r.TOTAL_GENRTN_1_STF_CNT__c,'+
                                    '       Group_Sales__r.TOTAL_GENRTN_2_STF_CNT__c,'+
                                    '       Group_Sales__r.TOTAL_GENRTN_3_STF_CNT__c,'+
                                    '       Group_Sales__r.TITL_1_STF_CNT__c,'+
                                    '       Group_Sales__r.TITL_2_STF_CNT__c,'+
                                    '       Group_Sales__r.TITL_3_STF_CNT__c,'+
                                    '       Group_Sales__r.TITL_4_STF_CNT__c,'+
                                    '       Group_Sales__r.TITL_5_STF_CNT__c,'+
                                    '       Group_Sales__r.CC_GRP_APPT_CNT__c,'+
                                    '       Group_Sales__r.YTD_APPT_CNT__c,'+
                                    '       Personal_Sales__r.PRFRMNC_POINT_QTY__c,'+
                                    '       Group_Sales__r.CC_GRP_RMOVL_CNT__c,'+
                                    '       Group_Sales__r.YTD_RMOVL_CNT__c,'+
                                    '       Group_Sales__r.DETL_LDRSHP_MRKT_TAG_1_AMT__c,'+
                                    '       Group_Sales__r.DETL_LDRSHP_MRKT_TAG_2_NR__c,'+
                                    '       Group_Sales__r.DETL_LDRSHP_MRKT_TAG_3_PCT__c,'+
                                    '       Group_Sales__r.DETL_LDRSHP_MRKT_TAG_4_TXT__c,'+
                                    '       Group_Sales__r.CC_BLW_MIN_AWRD_SLS_AMT__c,'+
                                    '       Group_Sales__r.AVG_ORD_WITH_MULTS_AMT__c,'+
                                    '       Group_Sales__r.CC_GRP_CUST_CNT__c '+
                                    ' From  Genealogy__c '+
                                    ' where MRKT_ID__c =:mktId '+
                                    ' and MRKT_ACCT_KEY__c IN :critAcctNbrList';         

    public PageReference init(){
        String critAcctNbrs= ApexPages.currentPage().getParameters().get('acctNbr');
        List<String> critAcctNbrList = critAcctNbrs.split(',');
        currUsr = [Select  Name,MRKT_TAG_1_HDR_TXT__c, MRKT_ID__c, MLPLN_CD__c, USER_CNTRY_CD__c,
                                LastName, LanguageLocaleKey, FirstName,MRKT_ID_ACCT_NR_KEY__c,
                                DFALT_ZONE_CD__c, DFALT_DIV_NM__c,ACCT_NR__c
                        From User
                        where Id = :UserInfo.getUserId()];
        this.market = [
                                Select  SPPY_CMPGN_NR__c, PREV_1_CMPGN_NR__c, Name, 
                                        Market_Id__c, Mail_Plan_Enabled__c, CURRNT_CMPGN_RMN_DAY_CNT__c, 
                                        CMPGN_STRT_DT__c, CMPGN_NR__c, CMPGN_END_DT__c,
                                        LAST_UPDT_DT__c,Id
                                From    Market__c   
                                where   Market_Id__c =:currUsr.MRKT_ID__c];
                                
        this.salesOrgMap = new Map<String,Sales_Organization__c>();
        for(Sales_Organization__c slsOrg:  [    Select  SLS_ZONE_MGR_FULL_NM__c,
                                                        SLS_ZONE_MGR_EMAIL_TXT__c,
                                                        SLS_ZONE_CD__c,
                                                        SLS_DIV_NM__c,
                                                        SLS_REGN_NM__c 
                                                From    Sales_Organization__c s
                                                where   Market__c=:this.market.Id
                                                and     SLS_ORG_LVL_NR__c='Z'])
        {
            salesOrgMap.put(slsOrg.SLS_ZONE_CD__c,slsOrg);              
        }

        List<String> mktTagSubjAreas = new List<String>();
        mktTagSubjAreas.add('Representative Detail');
        mktTagSubjAreas.add('Ldr-My Business');
        mktTagSubjAreas.add('Ldr-Downline Performance');
        mktTags = new MarketTagUtils();
        mktTags.initialize(mktTagSubjAreas,currUsr.MRKT_ID__c,currUsr.LanguageLocaleKey);
        ldrTitlUtils = new MarketLeaderTitleUtils();
        ldrTitlUtils.initialize(currUsr);
        sellStsUtils = new MarketSellerStsUtils();
        sellStsUtils.initialize(currUsr);
        DrilldownReportRow rptRow;
        Sales_Organization__c salesOrg;
        this.contactList = new List<DrilldownReportRow>();
        String mktId = this.market.Market_Id__c;
        System.debug('>>>>>>>>>>>>>>>>>> mktId='+mktId);
        System.debug('>>>>>>>>>>>>>>>>>> mktId='+mktId);
        for(Genealogy__c downline: Database.query(BASE_SOQL)){
            rptRow = new DrilldownReportRow(currUsr.ACCT_NR__c,
                                                        downline,
                                                        false);
            rptRow.salesOrg = this.salesOrgMap.get(downline.Representative__r.SLS_ZONE_CD__c);
            rptRow.title = ldrTitlUtils.getLeaderTitle(downline.Representative__r.LDRSHP_TITL_LVL_NBR__c);
            rptRow.sellerSts = sellStsUtils.getSellerStatus(downline.Representative__r.MRKT_TOP_SLR_LANG_KEY__c);
            this.contactList.add(rptRow);
        }
        if(this.contactList.size()==1){
            this.firstContact = this.contactList[0];
        }
        
        return null;
    }

    /*public String getTitle(){
        return this.ldrTitlUtils.getLeaderTitle(this.contact.Representative__r.LDRSHP_TITL_LVL_NBR__c);
    }
    
    public String getSellerStatus(){
        return this.sellStsUtils.getSellerStatus(this.contact.Representative__r.MRKT_TOP_SLR_LANG_KEY__c);
    }
    */  
    public String getRepMktTag1Lbl(){
        return this.mktTags.getLabel('Representative Detail','Market Tag 1',null);
    }
    
    public String getRepMktTag2Lbl(){
        return this.mktTags.getLabel('Representative Detail','Market Tag 2',null);
    }
    public String getRepMktTag3Lbl(){
        return this.mktTags.getLabel('Representative Detail','Market Tag 3',null);
    }
    public String getRepMktTag4Lbl(){
        return this.mktTags.getLabel('Representative Detail','Market Tag 4',null);
    }
    
    public String getOrderMktTag1Lbl(){
        return this.mktTags.getLabel('Ldr-My Business','Market Tag 1',null);
    }
    
    public String getOrderMktTag2Lbl(){
        return this.mktTags.getLabel('Ldr-My Business','Market Tag 2',null);
    }
    public String getOrderMktTag3Lbl(){
        return this.mktTags.getLabel('Ldr-My Business','Market Tag 3',null);
    }
    public String getOrderMktTag4Lbl(){
        return this.mktTags.getLabel('Ldr-My Business','Market Tag 4',null);
    }

    public String getLdrMktTag1Lbl(){
        return this.mktTags.getLabel('Ldr-Downline Performance','Market Tag 1',null);
    }
    
    public String getLdrMktTag2Lbl(){
        return this.mktTags.getLabel('Ldr-Downline Performance','Market Tag 2',null);
    }
    public String getLdrMktTag3Lbl(){
        return this.mktTags.getLabel('Ldr-Downline Performance','Market Tag 3',null);
    }
    public String getLdrMktTag4Lbl(){
        return this.mktTags.getLabel('Ldr-Downline Performance','Market Tag 4',null);
    }
    
    public String getLdrTitleLvl0(){
        return this.ldrTitlUtils.getLeaderTitle('0');
    }
    public String getLdrTitleLvl1(){
        return this.ldrTitlUtils.getLeaderTitle('1');
    }
    public String getLdrTitleLvl2(){
        return this.ldrTitlUtils.getLeaderTitle('2');
    }

    public String getLdrTitleLvl3(){
        return this.ldrTitlUtils.getLeaderTitle('3');
    }

    public String getLdrTitleLvl4(){
        return this.ldrTitlUtils.getLeaderTitle('4');
    }

    public String getLdrTitleLvl5(){
        return this.ldrTitlUtils.getLeaderTitle('5');
    }

    public static testmethod void testRepDetails(){
        RepDetailController ctlr = new RepDetailController();
        String mktIdKey = '123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createLeaderUser('123456');
        testData.createSalesOrgs();
        List<Genealogy__c> geneData = testData.createDownlineData(testUsr.MRKT_ID_ACCT_NR_KEY__c,1,testUsr.Id);
        System.debug('*****************************'+geneData);
        PageReference pageRef = Page.RepDetail;
        System.debug('*****************************'+geneData[1].MRKT_ACCT_KEY__c);
        pageRef.getParameters().put('acctNbr',geneData[1].MRKT_ACCT_KEY__c);
        Test.setCurrentPage(pageRef);
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.contactList.size() == 1);
            System.assert(ctlr.getRepMktTag1Lbl()==null);
            System.assert(ctlr.getRepMktTag2Lbl()==null);
            System.assert(ctlr.getRepMktTag3Lbl()==null);
            System.assert(ctlr.getRepMktTag4Lbl()==null);
            System.assert(ctlr.getOrderMktTag1Lbl()==null);
            System.assert(ctlr.getOrderMktTag2Lbl()==null);
            System.assert(ctlr.getOrderMktTag3Lbl()==null);
            System.assert(ctlr.getOrderMktTag4Lbl()==null);
            System.assert(ctlr.getLdrMktTag1Lbl()==null);
            System.assert(ctlr.getLdrMktTag2Lbl()==null);
            System.assert(ctlr.getLdrMktTag3Lbl()==null);
            System.assert(ctlr.getLdrMktTag4Lbl()==null);
            System.assert(ctlr.getLdrTitleLvl0()==null);
            System.assert(ctlr.getLdrTitleLvl1()=='Title 1');
            System.assert(ctlr.getLdrTitleLvl2()=='Title 2');
            System.assert(ctlr.getLdrTitleLvl3()=='Title 3');
            System.assert(ctlr.getLdrTitleLvl4()=='Title 4');
            System.assert(ctlr.getLdrTitleLvl5()=='Title 5');           
        }
        
    }

}
			                            	