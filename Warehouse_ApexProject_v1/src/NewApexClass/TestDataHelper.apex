public class TestDataHelper {

    public Market__c market {get; set;}
    public List<My_Business__c> myBusData {get; set;}
    public List<Genealogy__c> geneData {get; set;}
    public List<Leader_Downline_Summary__c> ldrData {get; set;}
    public List<MyBusiness_Row_Config__c> myBusCfg {get; set;}
    public List<Ldr_Downline_Perf_Row_Config__c> dwnPerfCfg {get; set;}
    public List<Current_Performance_Config__c> currPerfCfg {get; set;}
    public List<Downline_Analysis_Config__c> ldrAnlCfg {get; set;}
    public List<Market_Action_Items__c> mkActItems {get; set;}
    public List<Market_Tag_Label__c> mktTags {get; set;}
    public User leaderUser {get; set;}
    public User zoneUser {get; set;}
    public User divUser {get; set;}
    public List<Leader_Title__c> titles {get; set;}
    public List<Seller_Status__c> sellerStatus {get; set;}
    public Contact testContact {get; set;}
    public Account testAcct {get; set;}
    public List<Action_Items__c> actItems {get; set;}
    public List<MailPlan_Order_Oppty__c> mplans{get; set;}
    public List<Sales_Organization__c> slsOrgs {get; set;}
    public List<Market_Activity_Config__c> mktActvty {get; set;}
    public List<Leader_Activity_Config__c> ldrActvty {get; set;}
    public List<Sales_Org_Activity__c> slsOrgActvty {get; set;}
    public List<Sales_Org_Leadership__c> slsOrgLdrshp {get; set;}
    public List<Sales_Org_Ldrship_MktTags__c> slsOrgLdrMkt {get; set;}
    public List<Market_Analysis_Config__c> mktAnlCfg {get; set;}
    public Market__c createMarket(){
        if(this.market == null){
            this.market = new Market__c(Name='Test Market',Market_Id__c='XX',Market_Administrator__c=UserInfo.getUserId(),
                                        Available_Languages__c='en_US',
                                        My_Bus_SPPY_Enabled__c=true, My_Bus_PC_Enabled__c=true, 
                                        My_Bus_NC_Enabled__c=true, My_Bus_CC_Enabled__c=true,
                                        Downline_Perf_SPPY_Enabled__c=true, Downline_Perf_PC_Enabled__c=true, 
                                        Downline_Perf_NC_Enabled__c=true, Downline_Perf_CC_Enabled__c=true,
                                        Downline_Perf_CC_Gen1_Enabled__c=true,Downline_Perf_CC_Gen2_Enabled__c=true,
                                        Downline_Perf_CC_Gen3_Enabled__c=true,
                                        Mkt_Actvty_SPPY_Enabled__c=true,Mkt_Actvty_PC_Enabled__c=true,
                                        Mkt_Actvty_NC_Enabled__c=true,Mkt_Actvty_CC_Enabled__c=true,
                                        Mkt_Actvty_Plan_Enabled__c=true,Mkt_Actvty_Ldr_Enabled__c=true,
                                        Mkt_Actvty_Non_Ldr_Enabled__c=true,
                                        Ldr_Actvty_SPPY_Enabled__c=true,
                                        Ldr_Actvty_PC_Enabled__c=true,
                                        Ldr_Actvty_NC_Enabled__c=true,
                                        Ldr_Actvty_CC_Enabled__c=true,
                                        Ldr_Actvty_Plan_Enabled__c=true,
                                        Ldr_Actvty_NonLdr_Enabled__c=true,
                                        Ldr_Actvty_Titl_Lvl_1_Enabled__c=true,
                                        Ldr_Actvty_Titl_Lvl_2_Enabled__c=true,
                                        Ldr_Actvty_Titl_Lvl_3_Enabled__c=true,
                                        Ldr_Actvty_Titl_Lvl_4_Enabled__c=true,
                                        Ldr_Actvty_Titl_Lvl_5_Enabled__c=true,
                                        Ldr_Actvty_Titl_Lvl_UQ_Enabled__c=true,
                                        OPERTNL_CMPGN_CMPLTN_PCT__c=50.0,
                                        Mail_Plan_Enabled__c=true,
                                        ASLF_Timezone_Offset__c=0.0,
                                        Action_Item_Mail_Plans__c=3.0,
                                        ASLF_Report_URL__c='http://aslf.report.avon.com');
            insert this.market;
        }
        return this.market;
        
    }   
    
    public List<Action_Items__c> createActionItems(){
        this.actItems = new List<Action_Items__c>();
        Action_Items__c actItem;
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Orders / Sales under minimum',Default__c=false,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_ORD_UND_MIN__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Orders',Datatype__c='Number');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Minimum Orders Received',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_NET_SLS_AMT__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Orders',Datatype__c='Currency');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Minimum Orders Received',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c='ANNIV_WITHIN_10_DAYS__c',Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Orders',Datatype__c='Number');
        actItems.add(actItem);      

        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Return Orders',Default__c=false,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_ORD_UND_MIN__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Sales',Datatype__c='Number');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Net Sales',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_ORD_UND_MIN__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Sales',Datatype__c='Number');
        actItems.add(actItem);

        actItem = new Action_Items__c(  Action_Item_Type__c='Summary',Category__c='P.A.T.D. Certified',Default__c=false,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Current Business',Datatype__c='Number');
        actItems.add(actItem);

        actItem = new Action_Items__c(  Action_Item_Type__c='Summary',Category__c='Randking and Recognition',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c',Subject_Area__c='Current Business',Datatype__c='Number');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Summary',Category__c='Randking and Recognition',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Leader',
                                        Smry_Criteria_Fld__c='TITL_1_WO_PATD_CNT__c'+'\n'+'TITL_1_WO_PATD_CNT__c',
                                        Subject_Area__c='Current Business',Datatype__c='Number');
        actItems.add(actItem);

        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Orders / Sales under minimum',Default__c=false,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_ORD_UND_MIN__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Orders',Datatype__c='Number');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Minimum Orders Received',Default__c=true,
                                        Genealogy_Criteria_Fld__c='ActionItem_ORD_NOT_SUBMITTED__c',Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Orders',Datatype__c='Currency');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Minimum Orders Received',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c='ANNIV_WITHIN_10_DAYS__c',Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Orders',Datatype__c='Number');
        actItems.add(actItem);      

        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Return Orders',Default__c=false,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_ORD_UND_MIN__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Sales',Datatype__c='Number');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Downline',Category__c='Net Sales',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c='ActionItem_ORD_UND_MIN__c',
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Sales',Datatype__c='Number');
        actItems.add(actItem);

        actItem = new Action_Items__c(  Action_Item_Type__c='Summary',Category__c='P.A.T.D. Certified',Default__c=false,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Current Business',Datatype__c='Number');
        actItems.add(actItem);

        actItem = new Action_Items__c(  Action_Item_Type__c='Summary',Category__c='Randking and Recognition',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',Subject_Area__c='Current Business',Datatype__c='Number');
        actItems.add(actItem);
        actItem = new Action_Items__c(  Action_Item_Type__c='Summary',Category__c='Randking and Recognition',Default__c=true,
                                        Genealogy_Criteria_Fld__c=null,Order_Criteria_Fld__c=null,
                                        Rep_Criteria_Fld__c=null,Zone_Or_Leader__c='Zone',
                                        Smry_Criteria_Fld__c='AVG_ORD_AMT__c',
                                        Subject_Area__c='Current Business',Datatype__c='Number');
        actItems.add(actItem);
        
        insert actItems;
        return actItems;
    }
    public List<Leader_Title__c> createLeaderTitles(){
        createMarket();
        String[] titlLvls = new String[]{'1','2','3','4','5','6'};
        titles = new List<Leader_Title__c>();
        Leader_Title__c title;
        for(String lvl: titlLvls){
            title = new Leader_Title__c(
                                        GENRTN_1_ERNGS_PCT__c=10.0,GENRTN_1_MIN_ORD_AMT__c=100.00,GENRTN_2_ERNGS_PCT__c=10.0,
                                        GENRTN_2_MIN_ORD_AMT__c=200.00,GENRTN_3_ERNGS_PCT__c=40.0,GENRTN_3_MIN_ORD_AMT__c=500.00,
                                        LANG_CD__c='en_US',LCL_LDRSHP_TITL_LANG_DESC_TXT__c='Title '+lvl,
                                        LDRSHP_TITL_LVL_NR__c=lvl,Market__c=this.market.Id,MIN_FRST_LVL_TITL_REQD_NR__c=100.00,
                                        MIN_GRP_SLS_REQD_AMT__c=100.0,MIN_PRSNL_SLS_REQD_AMT__c=100.00,MIN_REP_RCRTMNTS_REQD_NR__c=10,
                                        MIN_SCN_LVL_TITL_REQD_NR__c=10,MIN_THRD_LVL_TITL_REQD_NR__c=10,
                                        MRKT_TAG_QLFR_1_NR__c=10,
                                        MRKT_TAG_QLFR_2_NR__c=10,MRKT_TAG_QLFR_3_NR__c=10);
            titles.add(title);
        }
        insert titles;
        return titles;
    }
    
    public List<Seller_Status__c> createSellerStatus(){
        createMarket();
        sellerStatus = new List<Seller_Status__c>();
        Seller_Status__c sts;
        sts = new Seller_Status__c( LANG_CD__c='en_US',LCL_TOP_SLR_LVL_KEY__c='SELLSTS1',
                                    LCL_TOP_SLR_LVL_LANG_DESC_TXT__c='Seller Status 1',Market__c=this.market.Id);
        sellerStatus.add(sts);                                  
        sts = new Seller_Status__c( LANG_CD__c='en_US',LCL_TOP_SLR_LVL_KEY__c='SELLSTS2',
                                    LCL_TOP_SLR_LVL_LANG_DESC_TXT__c='Seller Status 2',Market__c=this.market.Id);
        sellerStatus.add(sts);                                  
        sts = new Seller_Status__c( LANG_CD__c='en_US',LCL_TOP_SLR_LVL_KEY__c='SELLSTS3',
                                    LCL_TOP_SLR_LVL_LANG_DESC_TXT__c='Seller Status 3',Market__c=this.market.Id);
        sellerStatus.add(sts);          
        insert sellerStatus;
        return sellerStatus;                        
    }
    private void createAccount(){
        if(this.testAcct == null){
            this.testAcct = new Account(Name='Test Acount');
            insert this.testAcct;
        }
        
    }   
    public Contact createContact(String acctNbr,String ownerId){
        createMarket();
        createLeaderTitles();
        createSellerStatus();
        createMailPlans();
        createAccount();
        if(this.testContact == null){
            this.testContact= new Contact(  AccountId=this.testAcct.Id,ACCT_NR__c=acctNbr,ACHVMT_MRKT_LDRSHP_TITL_LANG_C__c='',AVON_LOA_1_6_IND__c='Y',
                                            AVON_LOA_1_YR_PLUS_IND__c='Y',AVON_LOA_7_1_YR_IND__c='Y',CMPGN_OF_UDATE_NR__c=1.0,DETL_CNTCT_MRKT_TAG_1_AMT__c=10.80,
                                            DETL_CNTCT_MRKT_TAG_2_NR__c=145,DETL_CNTCT_MRKT_TAG_3_PCT__c=10.5,DETL_CNTCT_MRKT_TAG_4_TXT__c='Some Text',
                                            Email='test@avon.com',FirstName=acctNbr+'First',LastName=acctNbr+'Last',HomePhone='9999999999',INACTV_CMPGN_CNT__c=5,
                                            LDRSHP_CTT_IND__c='Y',LDRSHP_LOA_1_6_IND__c='Y',LDRSHP_LOA_1_YR_PLUS_IND__c='Y',LDRSHP_LOA_7_1_YR_IND__c='Y',
                                            LDRSHP_LOA_NR__c=10,LDRSHP_PRGRM_IND__c='Y',LDRSHP_RPT_SLS_ZONE_CD__c='XZ1',LDRSHP_TAR_IND__c='Y',
                                            LDRSHP_TITL_DMTD_IND__c='Y',LDRSHP_TITL_LVL_NBR__c = this.titles[0].LDRSHP_TITL_LVL_NR__c,
                                            LDRSHP_TITL_PROMTD_IND__c='Y',LDRSHP_TITL_STUS_CD__c='STS',LOA_1_YR_PLUS_IND__c='1',LOA_NR__c=15,MLPLN_CD__c=this.mplans[0].MLPLN_CD__c,
                                            MRKT_ACCT_KEY__c=this.market.Market_Id__c+acctNbr,MRKT_ID__c=this.market.Market_Id__c,MRKT_SLS_ORG_KEY__c=null,
                                            MRKT_TOP_SLR_LANG_KEY__c=this.sellerStatus[0].LCL_TOP_SLR_LVL_KEY__c,ORD_PLCMT_MTHD_DESC_TXT__c='Online',
                                            PATD_CERTFCTN_IND__c='Y',PATD_CERTFCTN_LVL_A_IND__c='Y',PATD_CERTFCTN_LVL_D_IND__c='Y',
                                            PATD_CERTFCTN_LVL_DESC_TXT__c='Y',PATD_CERTFCTN_LVL_P_IND__c='Y',PATD_CERTFCTN_LVL_T_IND__c='Y',
                                            QLFD_LDRSHP_TITL_IND__c='Y',REP_ADDR_STR_2_TXT__c='Address 2',REP_ADDR_STR_3_TXT__c='Address 3',
                                            REP_ADDR_STR_4_TXT__c='Address 4',REP_APPT_DT__c=System.today(),
                                            REP_CNTRY_CD__c='US',REP_LANG_CD__c='en_US',REP_OMS_STUS_CD__c='R',
                                            RMOV_FROM_GENLGY_IND__c='N',SLS_ZONE_CD__c='XZ1',TAR_CMPGN_CNT__c=10,
                                            TERR_IND__c='Y',UPLN_ACCT_NR__c='56789',OwnerId=ownerId
                                          );
            insert this.testContact;
        }
        return this.testContact;
    }   
    public List<My_Business__c> createMyBusinessData(String mktIdKey,String ownerId){
        if(this.myBusData == null){
            this.myBusData = new List<My_Business__c>();
        }
        My_Business__c rec = new My_Business__c(MRKT_ACCT_KEY__c=mktIdKey,
                                                AWRD_SLS_AMT__c=100.00,
                                                PC_AWRD_SLS_AMT__c=80.000,
                                                SPPY_AWRD_SLS_AMT__c=100.00,
                                                MY_BUS_MRKT_TAG_4_TXT__c='Some text',
                                                CUST_CNT__c=100,
                                                ORD_UND_MIN_IND__c='Y',
                                                CurrencyISOCode='USD',
                                                OwnerId=ownerId,
                                                MRKT_CD__c=this.market.Market_Id__c
                                                );
        myBusData.add(rec);
        insert myBusData;
        return myBusData;                                               
    }

    public List<My_Business__c> createMyBusinessDataWithOwner(String mktIdKey){
        if(this.myBusData == null){
            this.myBusData = new List<My_Business__c>();
        }
        My_Business__c rec = new My_Business__c(MRKT_ACCT_KEY__c=mktIdKey,
                                                AWRD_SLS_AMT__c=100.00,
                                                PC_AWRD_SLS_AMT__c=80.000,
                                                SPPY_AWRD_SLS_AMT__c=100.00,
                                                MY_BUS_MRKT_TAG_4_TXT__c='Some text',
                                                CUST_CNT__c=100,
                                                ORD_UND_MIN_IND__c='Y',
                                                CurrencyISOCode='USD',
                                                OWNER_ACCT_KEY__c = UserInfo.getUserId()
                                                );
        myBusData.add(rec);
        insert myBusData;
        return myBusData;                                               
    }

    public List<Genealogy__c> createDownlineData(String uplineAcctNbr,Integer recCount,String ownerId){
        this.myBusData = new List<My_Business__c>();
        this.geneData = new List<Genealogy__c>();
        My_Business__c rec;
        Genealogy__c gene;
        Contact downline;
        List<Contact> contacts = new List<Contact>();
        createMarket();
        createAccount();
        createLeaderTitles();
        createSellerStatus();
        rec = new My_Business__c(MRKT_ACCT_KEY__c=uplineAcctNbr,
                                            AWRD_SLS_AMT__c=100.00,
                                            NET_SLS_AMT__c=-100.00,
                                            PC_AWRD_SLS_AMT__c=80.000,
                                            SPPY_AWRD_SLS_AMT__c=100.00,
                                            MY_BUS_MRKT_TAG_4_TXT__c='Some text',
                                            CUST_CNT__c=100,
                                            ORD_UND_MIN_IND__c='Y',
                                            CurrencyISOCode='USD',
                                            OwnerId=ownerId
                                            );
        myBusData.add(rec);
        
        this.testContact= new Contact(  AccountId=this.testAcct.Id,ACCT_NR__c=uplineAcctNbr,DETL_CNTCT_MRKT_TAG_1_AMT__c=10.80,
                                        Email='test@avon.com',FirstName='Test',LastName='User',HomePhone='9999999999',
                                        LDRSHP_TITL_LVL_NBR__c = this.titles[0].LDRSHP_TITL_LVL_NR__c,
                                        LDRSHP_TITL_STUS_CD__c='STS',MLPLN_CD__c='M1',
                                        MRKT_ACCT_KEY__c=this.market.Market_Id__c+uplineAcctNbr,
                                        MRKT_ID__c=this.market.Market_Id__c,MRKT_SLS_ORG_KEY__c=null,
                                        MRKT_TOP_SLR_LANG_KEY__c=this.sellerStatus[0].LCL_TOP_SLR_LVL_KEY__c,
                                        REP_APPT_DT__c=System.today(),
                                        REP_CNTRY_CD__c='US',REP_LANG_CD__c='en_US',REP_OMS_STUS_CD__c='1',
                                        SLS_ZONE_CD__c='XZ1',TAR_CMPGN_CNT__c=10,
                                        TERR_IND__c='Y',UPLN_ACCT_NR__c=null,
                                        OwnerId=ownerId
                                      );
        contacts.add(this.testContact);
        createLdrSmryData(uplineAcctNbr,ownerId);
        Integer titlIdx = 0;
        for(Integer i=0;i<recCount;i++){
            titlIdx=i;
            if(titlIdx >5){
                titlIdx=1;
            }
            rec = new My_Business__c(   MRKT_ACCT_KEY__c=uplineAcctNbr+i,
                                        AWRD_SLS_AMT__c=(i==1?10.00:(i==2?99.0:100.00)),
                                        NET_SLS_AMT__c=-100.00,
                                        PC_AWRD_SLS_AMT__c=80.000,
                                        SPPY_AWRD_SLS_AMT__c=100.00,
                                        MY_BUS_MRKT_TAG_4_TXT__c='Some text',
                                        CUST_CNT__c=100,
                                        ORD_UND_MIN_IND__c='Y',
                                        MIN_PRSNL_SLS_REQD_AMT__c=20,
                                        CurrencyISOCode='USD',
                                        OwnerId=ownerId
                                    );
                
            downline = new Contact( AccountId=this.testAcct.Id,ACCT_NR__c=uplineAcctNbr+i,ACHVMT_MRKT_LDRSHP_TITL_LANG_C__c='',AVON_LOA_1_6_IND__c='Y',
                                    AVON_LOA_1_YR_PLUS_IND__c='Y',AVON_LOA_7_1_YR_IND__c='Y',CMPGN_OF_UDATE_NR__c=1.0,DETL_CNTCT_MRKT_TAG_1_AMT__c=10.80,
                                    DETL_CNTCT_MRKT_TAG_2_NR__c=145,DETL_CNTCT_MRKT_TAG_3_PCT__c=10.5,DETL_CNTCT_MRKT_TAG_4_TXT__c='Some Text',
                                    Email='test@avon.com'+i,FirstName=uplineAcctNbr+i+'Test',LastName=uplineAcctNbr+i+'Last'+i,HomePhone='9999999999',INACTV_CMPGN_CNT__c=5,
                                    LDRSHP_CTT_IND__c='Y',LDRSHP_LOA_1_6_IND__c='Y',LDRSHP_LOA_1_YR_PLUS_IND__c='Y',LDRSHP_LOA_7_1_YR_IND__c='Y',
                                    LDRSHP_LOA_NR__c=10,LDRSHP_PRGRM_IND__c='Y',LDRSHP_RPT_SLS_ZONE_CD__c='XZ1',LDRSHP_TAR_IND__c='Y',
                                    LDRSHP_TITL_DMTD_IND__c='Y',LDRSHP_TITL_LVL_NBR__c = this.titles[titlIdx].LDRSHP_TITL_LVL_NR__c,
                                    LDRSHP_TITL_PROMTD_IND__c='Y',LDRSHP_TITL_STUS_CD__c='STS',LOA_1_YR_PLUS_IND__c='1',LOA_NR__c=15,MLPLN_CD__c='M'+i,
                                    MRKT_ACCT_KEY__c=this.market.Market_Id__c+uplineAcctNbr+i,MRKT_ID__c=this.market.Market_Id__c,MRKT_SLS_ORG_KEY__c=null,
                                    MRKT_TOP_SLR_LANG_KEY__c=this.sellerStatus[0].LCL_TOP_SLR_LVL_KEY__c,ORD_PLCMT_MTHD_DESC_TXT__c='Online',
                                    PATD_CERTFCTN_IND__c='Y',PATD_CERTFCTN_LVL_A_IND__c='Y',PATD_CERTFCTN_LVL_D_IND__c='Y',
                                    PATD_CERTFCTN_LVL_DESC_TXT__c='Y',PATD_CERTFCTN_LVL_P_IND__c='Y',PATD_CERTFCTN_LVL_T_IND__c='Y',
                                    QLFD_LDRSHP_TITL_IND__c='Y',REP_ADDR_STR_2_TXT__c='Address 2',REP_ADDR_STR_3_TXT__c='Address 3',
                                    REP_ADDR_STR_4_TXT__c='Address 4',REP_APPT_DT__c=System.today(),
                                    REP_CNTRY_CD__c='US',REP_LANG_CD__c='en_US',REP_OMS_STUS_CD__c='1',
                                    RMOV_FROM_GENLGY_IND__c='N',SLS_ZONE_CD__c='XZ1',TAR_CMPGN_CNT__c=10,
                                    TERR_IND__c='Y',UPLN_ACCT_NR__c=this.market.Market_Id__c+uplineAcctNbr,
                                    BirthDate=System.today().addDays(i),
                                    OwnerId=ownerId
                                  );
            contacts.add(downline);                                             
            myBusData.add(rec);
        }
        downline = new Contact( AccountId=this.testAcct.Id,ACCT_NR__c=uplineAcctNbr+'X',ACHVMT_MRKT_LDRSHP_TITL_LANG_C__c='',AVON_LOA_1_6_IND__c='Y',
                                AVON_LOA_1_YR_PLUS_IND__c='Y',AVON_LOA_7_1_YR_IND__c='Y',CMPGN_OF_UDATE_NR__c=1.0,DETL_CNTCT_MRKT_TAG_1_AMT__c=10.80,
                                DETL_CNTCT_MRKT_TAG_2_NR__c=145,DETL_CNTCT_MRKT_TAG_3_PCT__c=10.5,DETL_CNTCT_MRKT_TAG_4_TXT__c='Some Text',
                                Email='test@avon.comX',FirstName='Test',LastName='UserX',HomePhone='9999999999',INACTV_CMPGN_CNT__c=5,
                                LDRSHP_CTT_IND__c='Y',LDRSHP_LOA_1_6_IND__c='Y',LDRSHP_LOA_1_YR_PLUS_IND__c='Y',LDRSHP_LOA_7_1_YR_IND__c='Y',
                                LDRSHP_LOA_NR__c=10,LDRSHP_PRGRM_IND__c='Y',LDRSHP_RPT_SLS_ZONE_CD__c='XZ1',LDRSHP_TAR_IND__c='Y',
                                LDRSHP_TITL_DMTD_IND__c='Y',LDRSHP_TITL_LVL_NBR__c = this.titles[0].LDRSHP_TITL_LVL_NR__c,
                                LDRSHP_TITL_PROMTD_IND__c='Y',LDRSHP_TITL_STUS_CD__c='STS',LOA_1_YR_PLUS_IND__c='1',LOA_NR__c=15,MLPLN_CD__c='M1',
                                MRKT_ACCT_KEY__c=this.market.Market_Id__c+uplineAcctNbr+'X',MRKT_ID__c=this.market.Market_Id__c,MRKT_SLS_ORG_KEY__c=null,
                                MRKT_TOP_SLR_LANG_KEY__c=this.sellerStatus[0].LCL_TOP_SLR_LVL_KEY__c,ORD_PLCMT_MTHD_DESC_TXT__c='Online',
                                PATD_CERTFCTN_IND__c='Y',PATD_CERTFCTN_LVL_A_IND__c='Y',PATD_CERTFCTN_LVL_D_IND__c='Y',
                                PATD_CERTFCTN_LVL_DESC_TXT__c='Y',PATD_CERTFCTN_LVL_P_IND__c='Y',PATD_CERTFCTN_LVL_T_IND__c='Y',
                                QLFD_LDRSHP_TITL_IND__c='Y',REP_ADDR_STR_2_TXT__c='Address 2',REP_ADDR_STR_3_TXT__c='Address 3',
                                REP_ADDR_STR_4_TXT__c='Address 4',REP_APPT_DT__c=System.today(),
                                REP_CNTRY_CD__c='US',REP_LANG_CD__c='en_US',REP_OMS_STUS_CD__c='1',
                                RMOV_FROM_GENLGY_IND__c='N',SLS_ZONE_CD__c='XZ1',TAR_CMPGN_CNT__c=10,
                                TERR_IND__c='Y',UPLN_ACCT_NR__c=this.market.Market_Id__c+uplineAcctNbr,BirthDate=System.today().addDays(1),
                                OwnerId=ownerId
                              );
        contacts.add(downline);
        System.debug('>>>>>>>>>>>>>>> 1st Gen Contacts:'+contacts);
        System.debug('>>>>>>>>>>>>>>> 1st Gen myBusData:'+myBusData);
        
        insert contacts;
        insert myBusData;
        //System.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+contacts);
        
        gene = new Genealogy__c(Representative__c=testContact.Id,
                                Personal_Sales__c=myBusData[0].Id,
                                ACCT_NR__c=uplineAcctNbr,DWNLN_GENRTN_LVL_CNT__c=4,LDRSHP_TITL_LVL_NR__c=Integer.valueOf(this.titles[0].LDRSHP_TITL_LVL_NR__c),
                                MRKT_ACCT_KEY__c=this.market.Market_Id__c+uplineAcctNbr,
                                MRKT_ID__c=this.market.Market_Id__c,SLS_ZONE_CD__c='XZ1',STRT_OF_CMPGN_IND__c='N',
                                UPLN_GENRTN_1_ACCT_NR__c=null,UPLN_GENRTN_1_FULL_NM__c=null,
                                UPLN_GENRTN_1_PHON_NR__c=null,OwnerId=ownerId);
        geneData.add(gene);
        for(Integer i=0;i<recCount;i++){
            gene = new Genealogy__c(Representative__c=contacts[i].Id,
                                    Personal_Sales__c=myBusData[i].Id,
                                    ACCT_NR__c=uplineAcctNbr+i,DWNLN_GENRTN_LVL_CNT__c=i,LDRSHP_TITL_LVL_NR__c=Integer.valueOf(this.titles[0].LDRSHP_TITL_LVL_NR__c),
                                    MRKT_ACCT_KEY__c=this.market.Market_Id__c+uplineAcctNbr+i,
                                    MRKT_ID__c=this.market.Market_Id__c,SLS_ZONE_CD__c='XZ1',STRT_OF_CMPGN_IND__c='N',
                                    UPLN_GENRTN_1_ACCT_NR__c=uplineAcctNbr,UPLN_GENRTN_1_FULL_NM__c=uplineAcctNbr+' Name',
                                    UPLN_GENRTN_1_PHON_NR__c=uplineAcctNbr,OwnerId=ownerId);
            gene.Personal_Sales__r = myBusData[i];
            geneData.add(gene);
        }
        gene = new Genealogy__c(Representative__c=downline.Id,
                                Personal_Sales__c=null,
                                ACCT_NR__c=uplineAcctNbr+'X',DWNLN_GENRTN_LVL_CNT__c=2,LDRSHP_TITL_LVL_NR__c=Integer.valueOf(this.titles[0].LDRSHP_TITL_LVL_NR__c),
                                MRKT_ACCT_KEY__c=this.market.Market_Id__c+uplineAcctNbr+'X',
                                MRKT_ID__c=this.market.Market_Id__c,SLS_ZONE_CD__c='XZ1',STRT_OF_CMPGN_IND__c='N',
                                UPLN_GENRTN_1_ACCT_NR__c=this.market.Market_Id__c+uplineAcctNbr,UPLN_GENRTN_1_FULL_NM__c=uplineAcctNbr+' Name',
                                UPLN_GENRTN_1_PHON_NR__c=uplineAcctNbr,OwnerId=ownerId);
    
        
        geneData.add(gene);
        upsert geneData MRKT_ACCT_KEY__c;
        System.debug('############################ 1st Gen Genedata##############################');
    for(Genealogy__c gene1: geneData){
      System.debug('Gene.MRKT_ACCT_KEY__c='+gene1.MRKT_ACCT_KEY__c+',Gene.Personal_sales__r='+gene1.Personal_Sales__r+',gene.Group_sales__r='+gene1.Group_Sales__r);  
    }        
        return geneData;                                
    }

    public List<Genealogy__c> create2ndGenDownlineData(String upline1AcctNbr,String upline2AcctNbr,Integer recCount){
        this.myBusData = new List<My_Business__c>();
        this.geneData = new List<Genealogy__c>();
        My_Business__c rec;
        Genealogy__c gene;
        Contact downline;
        List<Contact> contacts = new List<Contact>();
        createMarket();
        createAccount();
        createLeaderTitles();
        createSellerStatus();
        for(Integer i=0;i<recCount;i++){
            rec = new My_Business__c(   MRKT_ACCT_KEY__c=this.market.Market_Id__c+upline2AcctNbr+i,
                                        AWRD_SLS_AMT__c=10.00,
                                        PC_AWRD_SLS_AMT__c=80.000,
                                        SPPY_AWRD_SLS_AMT__c=100.00,
                                        MY_BUS_MRKT_TAG_4_TXT__c='Some text',
                                        CUST_CNT__c=100,
                                        ORD_UND_MIN_IND__c='Y',
                                        MIN_PRSNL_SLS_REQD_AMT__c=20,
                                        CurrencyISOCode='USD'
                                    );
            downline = new Contact( AccountId=this.testAcct.Id,ACCT_NR__c=upline2AcctNbr+i,ACHVMT_MRKT_LDRSHP_TITL_LANG_C__c='',AVON_LOA_1_6_IND__c='Y',
                                    AVON_LOA_1_YR_PLUS_IND__c='Y',AVON_LOA_7_1_YR_IND__c='Y',CMPGN_OF_UDATE_NR__c=1.0,DETL_CNTCT_MRKT_TAG_1_AMT__c=10.80,
                                    DETL_CNTCT_MRKT_TAG_2_NR__c=145,DETL_CNTCT_MRKT_TAG_3_PCT__c=10.5,DETL_CNTCT_MRKT_TAG_4_TXT__c='Some Text',
                                    Email='test@avon.com'+i,FirstName=upline2AcctNbr+i+'Test',LastName=upline2AcctNbr+i+'Last'+i,HomePhone='9999999999',INACTV_CMPGN_CNT__c=5,
                                    LDRSHP_CTT_IND__c='Y',LDRSHP_LOA_1_6_IND__c='Y',LDRSHP_LOA_1_YR_PLUS_IND__c='Y',LDRSHP_LOA_7_1_YR_IND__c='Y',
                                    LDRSHP_LOA_NR__c=10,LDRSHP_PRGRM_IND__c='Y',LDRSHP_RPT_SLS_ZONE_CD__c='XZ1',LDRSHP_TAR_IND__c='Y',
                                    LDRSHP_TITL_DMTD_IND__c='Y',LDRSHP_TITL_LVL_NBR__c = this.titles[0].LDRSHP_TITL_LVL_NR__c,
                                    LDRSHP_TITL_PROMTD_IND__c='Y',LDRSHP_TITL_STUS_CD__c='STS',LOA_1_YR_PLUS_IND__c='1',LOA_NR__c=15,MLPLN_CD__c='M'+i,
                                    MRKT_ACCT_KEY__c=this.market.Market_Id__c+upline2AcctNbr+i,MRKT_ID__c=this.market.Market_Id__c,MRKT_SLS_ORG_KEY__c=null,
                                    MRKT_TOP_SLR_LANG_KEY__c=this.sellerStatus[0].LCL_TOP_SLR_LVL_KEY__c,ORD_PLCMT_MTHD_DESC_TXT__c='Online',
                                    PATD_CERTFCTN_IND__c='Y',PATD_CERTFCTN_LVL_A_IND__c='Y',PATD_CERTFCTN_LVL_D_IND__c='Y',
                                    PATD_CERTFCTN_LVL_DESC_TXT__c='Y',PATD_CERTFCTN_LVL_P_IND__c='Y',PATD_CERTFCTN_LVL_T_IND__c='Y',
                                    QLFD_LDRSHP_TITL_IND__c='Y',REP_ADDR_STR_2_TXT__c='Address 2',REP_ADDR_STR_3_TXT__c='Address 3',
                                    REP_ADDR_STR_4_TXT__c='Address 4',REP_APPT_DT__c=System.today(),
                                    REP_CNTRY_CD__c='US',REP_LANG_CD__c='en_US',REP_OMS_STUS_CD__c='R',
                                    RMOV_FROM_GENLGY_IND__c='N',SLS_ZONE_CD__c='XZ1',TAR_CMPGN_CNT__c=10,
                                    TERR_IND__c='Y',UPLN_ACCT_NR__c=this.market.Market_Id__c+upline2AcctNbr,
                                    BirthDate=System.today().addDays(i)
                                  );
            contacts.add(downline);                                             
            myBusData.add(rec);
        }
        System.debug('>>>>>>>>>>>>>>> 2nd Gen Contacts:'+contacts);
        System.debug('>>>>>>>>>>>>>>> 2nd Gen myBusData:'+myBusData);
        insert contacts;
        insert myBusData;
        //System.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+contacts);
        
        for(Integer i=0;i<recCount;i++){
            gene = new Genealogy__c(Representative__c=contacts[i].Id,
                                    Personal_Sales__c=myBusData[i].Id,
                                    ACCT_NR__c=upline2AcctNbr+i,DWNLN_GENRTN_LVL_CNT__c=i,LDRSHP_TITL_LVL_NR__c=Integer.valueOf(this.titles[0].LDRSHP_TITL_LVL_NR__c),
                                    MRKT_ACCT_KEY__c=this.market.Market_Id__c+upline2AcctNbr+i,
                                    MRKT_ID__c=this.market.Market_Id__c,SLS_ZONE_CD__c='XZ1',STRT_OF_CMPGN_IND__c='N',
                                    UPLN_GENRTN_1_ACCT_NR__c=upline2AcctNbr,UPLN_GENRTN_1_FULL_NM__c=upline2AcctNbr+' Name',
                                    UPLN_GENRTN_1_PHON_NR__c=upline2AcctNbr,
                                    UPLN_GENRTN_2_ACCT_NR__c=upline1AcctNbr,UPLN_GENRTN_2_FULL_NM__c=upline1AcctNbr+' Name',
                                    UPLN_GENRTN_2_PHON_NR__c=upline1AcctNbr);
            geneData.add(gene);
            System.debug('>>>>>>>>>>>>>>>> 2nd Gen gene['+i+'].MRKT_ACCT_KEY__c='+gene.MRKT_ACCT_KEY__c);
        }
        System.debug('>>>>>>>>>>>>>>>>>>>>>> 2nd Gen GeneData:'+geneData);
        upsert geneData MRKT_ACCT_KEY__c;
        /*List<Genealogy__c> temp = [Select MRKT_ACCT_KEY__c,  LDRSHP_TITL_LVL_NR__c, Id,  DWNLN_GENRTN_LVL_CNT__c, ACCT_NR__c,  
                                            Personal_Sales__r.ActionItem_ORD_HOLD_AMT__c,  Personal_Sales__r.ActionItem_ORD_UND_MIN__c, 
                                             Personal_Sales__r.ActionItem_ORD_DEFAULT__c,  Personal_Sales__r.ActionItem_AWRD_SLS_MIN__c,  
                                             Personal_Sales__r.ActionItem_NET_SLS_AMT__c,  Personal_Sales__r.ActionItem_PAST_DUE_AMT__c,
                                               Personal_Sales__r.ActionItem_ORD_ABV_MIN__c,  ActionItem_ORD_NOT_SUBMITTED__c,  
                                               Personal_Sales__c,Group_Sales__c,  Personal_Sales__r.AWRD_SLS_AMT__c, 
                                                Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c,  Representative__r.Name,  
                                                Representative__r.LDRSHP_TITL_LVL_NBR__c,  Representative__r.MRKT_TOP_SLR_LANG_KEY__c,  
                                                Representative__r.Phone 
                                    From  Genealogy__c 
                                    Where  (UPLN_GENRTN_1_ACCT_NR__c='XXU123456' OR    
                                            UPLN_GENRTN_3_ACCT_NR__c='XXU123456' OR   
                                            UPLN_GENRTN_2_ACCT_NR__c='XXU123456') 
                                    and     Representative__r.MLPLN_CD__c in ('M0','M1','M1')];*/
        //System.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%'+temp); 
        
        return geneData;                                
    }

    public List<Leader_Downline_Summary__c> createLdrSmryData(String mktIdKey,String ownerId){
        ldrData = new List<Leader_Downline_Summary__c>();
        Leader_Downline_Summary__c rec = new Leader_Downline_Summary__c(
                                                MRKT_ACCT_KEY__c=mktIdKey,
                                                GENRTN_1_GRP_AWRD_SLS_AMT__c=100.00,
                                                PC_GRP_AWRD_SLS_AMT__c=80.0,
                                                SPPY_GRP_AWRD_SLS_AMT__c=123.00,
                                                CC_MRKT_TAG_2_PRFRMNC_TXT__c='Some Text',
                                                TITL_1_WO_PATD_CNT__c=15,
                                                CurrencyISOCode='USD',
                                                OwnerId=ownerId
                                                );
        ldrData.add(rec);
        insert ldrData;
        return ldrData;                                             
    }

    public List<Leader_Downline_Summary__c> createLdrSmryDataWithOwner(String mktIdKey){
        ldrData = new List<Leader_Downline_Summary__c>();
        Leader_Downline_Summary__c rec = new Leader_Downline_Summary__c(
                                                MRKT_ACCT_KEY__c=mktIdKey,
                                                GENRTN_1_GRP_AWRD_SLS_AMT__c=100.00,
                                                PC_GRP_AWRD_SLS_AMT__c=80.0,
                                                SPPY_GRP_AWRD_SLS_AMT__c=123.00,
                                                CC_MRKT_TAG_2_PRFRMNC_TXT__c='Some Text',
                                                TITL_1_WO_PATD_CNT__c=15,
                                                CurrencyISOCode='USD',
                                                OWNER_ACCT_KEY__c = UserInfo.getUserId()
                                                );
        ldrData.add(rec);
        insert ldrData;
        return ldrData;                                             
    }

    public List<MyBusiness_Row_Config__c>  createMyBusinessConfig(){
        createMarket();
        myBusCfg = new List<MyBusiness_Row_Config__c>();
        MyBusiness_Row_Config__c rec = new MyBusiness_Row_Config__c(Market__c=this.market.Id,
                                                                    Current_Campaign_Fld__c='AWRD_SLS_AMT__c',
                                                                    Data_Type__c='Currency',
                                                                    Is_Market_Tag__c=false,
                                                                    Next_Campaign_Fld__c='AWRD_SLS_AMT__c',
                                                                    Prior_Campaign_Fld__c='PC_AWRD_SLS_AMT__c',
                                                                    Row_Type__c='Award Sales',
                                                                    Same_Time_Last_Year_Fld__c='SPPY_AWRD_SLS_AMT__c'
                                                                    );
        myBusCfg.add(rec);
        rec = new MyBusiness_Row_Config__c( Market__c=this.market.Id,
                                            Current_Campaign_Fld__c='AWRD_SLS_AMT__c',
                                            Data_Type__c='Currency',
                                            Is_Market_Tag__c=false,
                                            Next_Campaign_Fld__c='AWRD_SLS_AMT__c',
                                            Prior_Campaign_Fld__c='PC_AWRD_SLS_AMT__c',
                                            Row_Type__c='Net Sales',
                                            Same_Time_Last_Year_Fld__c='SPPY_AWRD_SLS_AMT__c'
                                          );        
        myBusCfg.add(rec);
        rec = new MyBusiness_Row_Config__c( Market__c=this.market.Id,
                                            Current_Campaign_Fld__c='CUST_CNT__c',
                                            Data_Type__c='Number',
                                            Is_Market_Tag__c=false,
                                            Next_Campaign_Fld__c='CUST_CNT__c',
                                            Prior_Campaign_Fld__c='CUST_CNT__c',
                                            Row_Type__c='Orders Submitted',
                                            Same_Time_Last_Year_Fld__c='CUST_CNT__c'
                                          );        
        myBusCfg.add(rec);

        rec = new MyBusiness_Row_Config__c( Market__c=this.market.Id,
                                            Current_Campaign_Fld__c='MY_BUS_MRKT_TAG_4_TXT__c',
                                            Data_Type__c='Text',
                                            Is_Market_Tag__c=true,
                                            Next_Campaign_Fld__c='MY_BUS_MRKT_TAG_4_TXT__c',
                                            Prior_Campaign_Fld__c='MY_BUS_MRKT_TAG_4_TXT__c',
                                            Row_Type__c='Market Tag 1',
                                            Same_Time_Last_Year_Fld__c='MY_BUS_MRKT_TAG_4_TXT__c'
                                          );        
        myBusCfg.add(rec);
        insert myBusCfg;
        return myBusCfg;    
    }

    public List<Ldr_Downline_Perf_Row_Config__c> createLdrPerfConfig(){
        createMarket();
        createLeaderTitles();
        dwnPerfCfg = new List<Ldr_Downline_Perf_Row_Config__c>();
        Ldr_Downline_Perf_Row_Config__c cfg;
        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_1stGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_2ndGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_3rdGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Data_Type__c='Currency',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Prior_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Row_Type__c='Group Award Sales',
                                                    Same_Time_Last_Year_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c'
                                                 );
        dwnPerfCfg.add(cfg);
        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_1stGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_2ndGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_3rdGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Prior_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Row_Type__c='Orders Under Minimum',
                                                    Same_Time_Last_Year_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c'
                                                 );
        dwnPerfCfg.add(cfg);

        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_1stGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_2ndGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_3rdGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Prior_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Row_Type__c='Orders Not Submitted',
                                                    Same_Time_Last_Year_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c'
                                                 );
        dwnPerfCfg.add(cfg);

        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_1stGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_2ndGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_3rdGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Prior_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Row_Type__c='Orders Achieving Minimum',
                                                    Same_Time_Last_Year_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c'
                                                 );
        dwnPerfCfg.add(cfg);
        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_1stGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_2ndGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_3rdGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Prior_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Row_Type__c='Orders on Hold',
                                                    Same_Time_Last_Year_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c'
                                                 );
        dwnPerfCfg.add(cfg);

        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                    Current_Campaign_Fld_1stGen__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                    Current_Campaign_Fld_2ndGen__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                    Current_Campaign_Fld_3rdGen__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                    Data_Type__c='Text',
                                                    Is_Market_Tag__c=true,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                    Prior_Campaign_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                    Row_Type__c='Market Tag 1',
                                                    Same_Time_Last_Year_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c'
                                                 );
        dwnPerfCfg.add(cfg);
        
        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_1stGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_2ndGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Current_Campaign_Fld_3rdGen__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Prior_Campaign_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                    Row_Type__c='Orders Not Submitted',
                                                    Same_Time_Last_Year_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c'
                                                 );
        dwnPerfCfg.add(cfg);
        
        insert dwnPerfCfg;
        return dwnPerfCfg;                      
    }

    public List<Ldr_Downline_Perf_Row_Config__c> createLdrPerfConfigEmpty(){
        createMarket();
        createLeaderTitles();
        dwnPerfCfg = new List<Ldr_Downline_Perf_Row_Config__c>();
        Ldr_Downline_Perf_Row_Config__c cfg;
        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c=null,
                                                    Current_Campaign_Fld_1stGen__c=null,
                                                    Current_Campaign_Fld_2ndGen__c=null,
                                                    Current_Campaign_Fld_3rdGen__c=null,
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c=null,
                                                    Prior_Campaign_Fld__c=null,
                                                    Row_Type__c='Orders Under Minimum',
                                                    Same_Time_Last_Year_Fld__c=null
                                                 );
        dwnPerfCfg.add(cfg);

        cfg = new Ldr_Downline_Perf_Row_Config__c ( Current_Campaign_Fld__c=null,
                                                    Current_Campaign_Fld_1stGen__c=null,
                                                    Current_Campaign_Fld_2ndGen__c=null,
                                                    Current_Campaign_Fld_3rdGen__c=null,
                                                    Data_Type__c='Number',
                                                    Is_Market_Tag__c=false,
                                                    Market__c=this.market.Id,
                                                    Next_Campaign_Fld__c=null,
                                                    Prior_Campaign_Fld__c=null,
                                                    Row_Type__c='Orders Not Submitted',
                                                    Same_Time_Last_Year_Fld__c=null
                                                 );
        dwnPerfCfg.add(cfg);
        
        insert dwnPerfCfg;
        return dwnPerfCfg;                      
    }

    public List<Downline_Analysis_Config__c> createLdrAnalysisConfig(){
        createMarket();
        createLeaderTitles();
        this.ldrAnlCfg = new List<Downline_Analysis_Config__c>();
        Downline_Analysis_Config__c cfg;
        cfg = new Downline_Analysis_Config__c(  Block__c='Order Status',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Currency',
                                                Is_Market_Tag__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Orders Not Submitted',Section__c='Orders');
        ldrAnlCfg.add(cfg);     
        cfg = new Downline_Analysis_Config__c(  Block__c='Order Status',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Currency',
                                                Is_Market_Tag__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Orders Under Minimum',Section__c='Orders');
        ldrAnlCfg.add(cfg);     
        cfg = new Downline_Analysis_Config__c(  Block__c='Orders-Market Tags',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=true,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Market Tag 1',Section__c='Orders');
        ldrAnlCfg.add(cfg);     

        cfg = new Downline_Analysis_Config__c(  Block__c='Orders-Market Tags',Col1_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',Col2_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',
                                                Col3_Fld__c='CC_MRKT_TAG_2_PRFRMNC_TXT__c',Data_Type__c='Text',
                                                Is_Market_Tag__c=true,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Market Tag 2',Section__c='Orders');
        ldrAnlCfg.add(cfg);     
        
        cfg = new Downline_Analysis_Config__c(  Block__c='Award Sales',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Total Award Sales',Section__c='Sales');
        ldrAnlCfg.add(cfg);     

        cfg = new Downline_Analysis_Config__c(  Block__c='Award Sales',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Net Sales',Section__c='Sales');
        ldrAnlCfg.add(cfg);     

        cfg = new Downline_Analysis_Config__c(  Block__c='Additions',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Title Level 1',Section__c='Current Business');
        ldrAnlCfg.add(cfg);     

        cfg = new Downline_Analysis_Config__c(  Block__c='Additions',Col1_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Col2_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Col3_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Title Level 2',Section__c='Current Business');
        ldrAnlCfg.add(cfg);     
        
        insert ldrAnlCfg;
        return ldrAnlCfg;
    }
    public List<Current_Performance_Config__c> createCurrPerfConfig(){
        createMarket();
        createLeaderTitles();
        Current_Performance_Config__c cfg;
        currPerfCfg = new List<Current_Performance_Config__c>();
        cfg = new Current_Performance_Config__c(
                                                Current_Perf_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Data_Type__c='Currency',
                                                Is_Market_Tag__c=false,
                                                Market__c=this.market.Id,
                                                Next_Level_Fld__c='GENRTN_1_MIN_ORD_AMT__c',
                                                Row_Type__c='Group Qualifiers'
                                                );
        currPerfCfg.add(cfg);

        cfg = new Current_Performance_Config__c(
                                                Current_Perf_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Data_Type__c='Number',
                                                Is_Market_Tag__c=false,
                                                Market__c=this.market.Id,
                                                Next_Level_Fld__c='GENRTN_1_MIN_ORD_AMT__c',
                                                Row_Type__c='1st Level Titled'
                                                );
        currPerfCfg.add(cfg);
        cfg = new Current_Performance_Config__c(
                                                Current_Perf_Fld__c='GENRTN_1_GRP_AWRD_SLS_AMT__c',
                                                Data_Type__c='Number',
                                                Is_Market_Tag__c=true,
                                                Market__c=this.market.Id,
                                                Next_Level_Fld__c='GENRTN_1_MIN_ORD_AMT__c',
                                                Row_Type__c='1st Level Titled'
                                                );
        currPerfCfg.add(cfg);
        
        insert currPerfCfg;
        return currPerfCfg;
    }
    
    public List<Market_Action_Items__c> createMarketActionItems(){
        createMarket();
        createMailPlans();
        this.market.Mail_Plan_Enabled__c=true;
        this.market.Action_Item_Mail_Plans__c=15;
        update this.market;
        createActionItems();
        mkActItems = new List<Market_Action_Items__c>();
        Market_Action_Items__c actItem ;
        for(Integer i=0;i<this.actItems.size();i++){
            actItem = new Market_Action_Items__c(Action_Item__c=this.actItems[i].Id,Campaign_Stage__c=10,Default__c=false,
                                                 Market__c=this.market.Id,Priority__c=''+i,Report__c=null,Threshold__c=5);
            mkActItems.add(actItem);
        }
        insert mkActItems;  
        return mkActItems;
    }
    
    public List<MailPlan_Order_Oppty__c> createMailPlans(){
        createMarket();
        MailPlan_Order_Oppty__c mplan;
        this.mplans= new List<MailPlan_Order_Oppty__c>();
        Date currDate = System.today();
        currDate = currDate.addDays(1);
        Date nextCDate= currDate.addDays(10);
        for(Integer i=0;i<5;i++){
            mplan = new MailPlan_Order_Oppty__c(CMPGN_NR__c='1',CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c=(i+1),CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c=(i+1),
                                                CURRNT_NEXT_CMPGN_PRFX_CD__c='C',MLPLN_CD__c='M'+i,MLPLN_CLOSD_IND__c='N',
                                                MLPLN_END_DT__c=currDate.addDays(1+10),Market__c=this.market.Id,
                                                NEXT_MLPLN_TO_CLOS_CD__c='M'+(i+1),SLS_ZONE_CD__c='XZ1');
            mplans.add(mplan);  
            mplan = new MailPlan_Order_Oppty__c(CMPGN_NR__c='2',CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c=(i+10),CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c=(i+10),
                                                CURRNT_NEXT_CMPGN_PRFX_CD__c='N',MLPLN_CD__c='M'+i,MLPLN_CLOSD_IND__c='N',
                                                MLPLN_END_DT__c=nextCDate.addDays(i+10),Market__c=this.market.Id,
                                                NEXT_MLPLN_TO_CLOS_CD__c='M'+(i+1),SLS_ZONE_CD__c='XZ1');   
            mplans.add(mplan);  
        }
        insert mplans;
        return mplans;
    }   
    public User createLeaderUser(String acctNbr){
        createMarket();
        this.leaderUser = createUser(acctNbr,'XZ1','Avon Leader');
        return leaderUser;      
    }

    public User createMarketAdminUser(String acctNbr){
        createMarket();
        User usr = createUser(acctNbr,'XZ1','Avon Market Administrator');
        return usr;     
    }

    public User createZoneUser(String acctNbr){
        createMarket();
        this.zoneUser = createUser(acctNbr+'Z1','XZ1','Avon Zone Manager');
        return zoneUser;        
    }

    public User createDivUser(String acctNbr){
        createMarket();
        this.divUser = createUser(acctNbr+'D1','XZ1','Avon Division Manager');
        return divUser;     
    }

    public User createUser(String acctNbr,String zoneNbr,String prfName){
        createMarket();
        Profile sysAdm = [select Id,Name from Profile where Name=:prfName];
        User tempUsr = new User(
             Username=acctNbr+'@avonpoc.com',
             Title=prfName,
             TimeZoneSidKey='America/New_York',
             ProfileId=sysAdm.Id,
             LocaleSidKey='en_US',
             Last_Name__c=prfName,
             First_Name__c='Avon Test',
             Email=acctNbr+'@avonpoc.com',
             Alias='test',
             EmailEncodingKey='ISO-8859-1',
             LanguageLocaleKey='en_US',
             IsActive=true, 
            ACCT_NR__c=acctNbr,
            DFALT_DIV_NM__c='D1',
            DFALT_ZONE_CD__c=(prfName=='Avon Division Manager'?null:zoneNbr),
            MAX_EMAIL_LIMIT__c=10,
            MLPLN_CD__c='1',
            MRKT_ID__c=this.market.Market_Id__c,
            MRKT_ID_ACCT_NR_KEY__c=this.market.Market_Id__c+acctNbr,
            MRKT_TAG_1_HDR_TXT__c='Some data',
            USER_CNTRY_CD__c='US',
            Welcome_Message__c=true,
            GI3_Email__c=acctNbr+'@avonpoc.com'

        );
        insert tempUsr;
        Group grp = [select Id,Name from Group where Name='System Admin Group'];
        GroupMember mbr = new GroupMember(GroupId=grp.Id,UserOrGroupId=tempUsr.Id);
        insert mbr;
        return tempUsr;     
    }
    
    public void createMarketTags(List<String> subjAreas){
        createMarket();
        mktTags = new List<Market_Tag_Label__c>();
        for(String area: subjAreas){
            mktTags.add(new Market_Tag_Label__c(Language__c='en_US',Market__c=this.market.Id,
                                             Subject_Area__c=area,Tag_Label__c='Market Tag 1',
                                             Tag_Name__c='Market Tag 1'));
            mktTags.add(new Market_Tag_Label__c(Language__c='en_US',Market__c=this.market.Id,
                                             Subject_Area__c=area,Tag_Label__c='Market Tag 2',
                                             Tag_Name__c='Market Tag 2'));
        }
        insert mktTags;
    }   
    
    public List<User_Sales_Org_Hierarchy__c> createUsrSlsOrgHrchy(User usr){
        createMarket();
        List<User_Sales_Org_Hierarchy__c> orgHierList = new List<User_Sales_Org_Hierarchy__c>();
        User_Sales_Org_Hierarchy__c orgHrarchy 
                = new User_Sales_Org_Hierarchy__c(  ACCT_NR__c=usr.ACCT_NR__c,Market__c=this.market.Id,MRKT_ID__c=this.market.Market_Id__c,
                                                    SLS_ORG_CD__c='XZ1',SLS_ORG_LVL_CD__c='Z');
        orgHierList.add(orgHrarchy);
        insert orgHierList;

        return orgHierList;
    }

    public List<User_Sales_Org_Hierarchy__c> createUsrSlsOrgHrchy(User usr,String orgCd,String orgLvl){
        createMarket();
        List<User_Sales_Org_Hierarchy__c> orgHierList = new List<User_Sales_Org_Hierarchy__c>();
        User_Sales_Org_Hierarchy__c orgHrarchy 
                = new User_Sales_Org_Hierarchy__c(  ACCT_NR__c=usr.ACCT_NR__c,Market__c=this.market.Id,MRKT_ID__c=this.market.Market_Id__c,
                                                    SLS_ORG_CD__c=orgCd,SLS_ORG_LVL_CD__c=orgLvl);
        orgHierList.add(orgHrarchy);
        insert orgHierList;

        return orgHierList;
    }
    
    public List<Sales_Organization__c> createSalesOrgs(){
        createMarket();
        slsOrgs = new List<Sales_Organization__c>();
        Sales_Organization__c org;
        org = new Sales_Organization__c(Market__c=this.market.Id,MRKT_ID__c=this.market.Market_Id__c,
                                        SLS_DIV_MGR_EMAIL_TXT__c='divmgr@avon.com',SLS_DIV_MGR_FULL_NM__c='Division Manager',
                                        SLS_DIV_MGR_PHON_NR__c='1234567',SLS_DIV_NM__c='D1',SLS_ORG_CD__c='XZ1',
                                        SLS_ORG_LVL_NR__c='Z',SLS_REGN_MGR_EMAIL_TXT__c='regmgr@email.com',SLS_REGN_MGR_FULL_NM__c='Region Manager',
                                        SLS_REGN_NM__c='R1',SLS_ZONE_CD__c='XZ1',SLS_ZONE_MGR_EMAIL_TXT__c='zmgr@avon.com',
                                        SLS_ZONE_MGR_FULL_NM__c='Zone Manager',SLS_ZONE_MGR_PHON_NR__c='123456788');
        slsOrgs.add(org);

        org = new Sales_Organization__c(Market__c=this.market.Id,MRKT_ID__c=this.market.Market_Id__c,
                                        SLS_DIV_MGR_EMAIL_TXT__c='divmgr@avon.com',SLS_DIV_MGR_FULL_NM__c='Division Manager',
                                        SLS_DIV_MGR_PHON_NR__c='1234567',SLS_DIV_NM__c='D1',SLS_ORG_CD__c='D1',
                                        SLS_ORG_LVL_NR__c='D',SLS_REGN_MGR_EMAIL_TXT__c='regmgr@email.com',SLS_REGN_MGR_FULL_NM__c='Region Manager',
                                        SLS_REGN_NM__c='R1',SLS_ZONE_CD__c='',SLS_ZONE_MGR_EMAIL_TXT__c='zmgr@avon.com',
                                        SLS_ZONE_MGR_FULL_NM__c='',SLS_ZONE_MGR_PHON_NR__c='');
        slsOrgs.add(org);
        System.debug('>>>>>>>> TestDataHelper: SALES ORG DATA:'+slsOrgs);
        insert slsOrgs;
        return slsOrgs;
    }
    
    public EmailTemplate createEmailTemplate(){
        Folder fld = [select Id,Name from Folder where Name='Dummy Folder DO NOT DELETE'];
        EmailTemplate template = new EmailTemplate( FolderId=fld.Id,Name='test',body='test',description='test',
                                                    DeveloperName='test',htmlvalue='<html></html>',
                                                    IsActive=true,
                                                    Subject='Test',TemplateType='Custom');
        insert template;
        return template;
    }
    public List<Sales_Org_Activity__c> createMktActivity(User userRec,String profile,String ownerId){
        slsOrgActvty = new List<Sales_Org_Activity__c>();
        Sales_Org_Activity__c rec;
        if(profile=='Avon Zone Manager'){
            rec = new Sales_Org_Activity__c(MRKT_ID__c=this.market.Market_Id__c,
                                              MRKT_ID_ZONE_CD_KEY__c=userRec.MRKT_ID__c+'Z'+userRec.DFALT_ZONE_CD__c,
                                              AVG_ORD_AMT__c=10.0,LDRSHP_NET_SLS_AMT__c=10,TRAD_NET_SLS_AMT__c=10,
                                              PC_LDRSHP_NET_SLS_AMT__c=10,PC_TRAD_NET_SLS_AMT__c=10,LDRSHP_ORD_CNT__c=10,
                                              TRAD_ORD_CNT__c=10,PC_LDRSHP_ORD_CNT__c=10,PC_TRAD_ORD_CNT__c=10,
                                              LDRSHP_STF_CNT__c=10,TRAD_STF_CNT__c=10,PC_LDRSHP_STF_CNT__c=10,
                                              PC_TRAD_STF_CNT__c=10,
                                            LDRSHP_AVG_ORD_AMT__c=10,
                                            LDRSHP_APPT_CNT__c=10,
                                            PLAN_ALL_ADDN_AMT__c=10,OwnerId=ownerId
                                              );
        }
        if(profile=='Avon Division Manager'){
            rec = new Sales_Org_Activity__c(MRKT_ID__c=this.market.Market_Id__c,
                                                              MRKT_ID_ZONE_CD_KEY__c=userRec.MRKT_ID__c+'D'+userRec.DFALT_DIV_NM__c,
                                                              AVG_ORD_AMT__c=10.0,
                                              PC_TRAD_STF_CNT__c=10,
                                            LDRSHP_AVG_ORD_AMT__c=10,
                                            LDRSHP_NET_SLS_AMT__c=10,
                                            LDRSHP_APPT_CNT__c=10,
                                            PLAN_ALL_ADDN_AMT__c=10,OwnerId=ownerId
                                              );
        }
        slsOrgActvty.add(rec);
        insert slsOrgActvty;
        system.debug('>>>>>>>>>>>>>>>>>>>>>'+slsOrgActvty);
        return slsOrgActvty;
        
    }

    public List<Sales_Org_Leadership__c> createSlsLdrActivity(User userRec,String profile,String ownerId){
        slsOrgLdrshp = new List<Sales_Org_Leadership__c>();
        slsOrgLdrMkt = new List<Sales_Org_Ldrship_MktTags__c>();
        Sales_Org_Leadership__c rec;
        Sales_Org_Ldrship_MktTags__c recmkt; 
        if(profile=='Avon Zone Manager'){
            rec = new Sales_Org_Leadership__c(MRKT_ID__c=this.market.Market_Id__c,
                                                              MRKT_ID_ZONE_CD_KEY__c=userRec.MRKT_ID__c+'Z'+userRec.DFALT_ZONE_CD__c,
                                                              AVG_ORD_AMT__c=10.0,
                                                        TITL_1_NO_ORD_CNT__c=10,
                                                        UQ_TITL_1_HOLD_ORD_CNT__c=10,
                                                        LDRSHP_PEND_ORD_CNT__c=10,OwnerId=ownerId);
                                                              
                                                              
            recmkt = new Sales_Org_Ldrship_MktTags__c(  MRKT_ID__c=this.market.Market_Id__c,
                                                        MRKT_ID_ZONE_CD_KEY__c=userRec.MRKT_ID__c+'Z'+userRec.DFALT_ZONE_CD__c,
                                                        UQ_TITL_1_MRKT_TAG_1_AMT__c=10.0,
                                                        UQ_TITL_1_MRKT_TAG_2_TXT__c='Test',OwnerId=ownerId
                                                        );      
        }
        if(profile=='Avon Division Manager'){
            rec = new Sales_Org_Leadership__c(MRKT_ID__c=this.market.Market_Id__c,
                                                              MRKT_ID_ZONE_CD_KEY__c=userRec.MRKT_ID__c+'D'+userRec.DFALT_DIV_NM__c,
                                                              AVG_ORD_AMT__c=10.0,
                                                        TITL_1_NO_ORD_CNT__c=10,
                                                        UQ_TITL_1_HOLD_ORD_CNT__c=10,
                                                        LDRSHP_PEND_ORD_CNT__c=10,OwnerId=ownerId);
            recmkt = new Sales_Org_Ldrship_MktTags__c(  MRKT_ID__c=this.market.Market_Id__c,
                                                        MRKT_ID_ZONE_CD_KEY__c=userRec.MRKT_ID__c+'D'+userRec.DFALT_DIV_NM__c,
                                                        UQ_TITL_1_MRKT_TAG_1_AMT__c=10.0,
                                                        UQ_TITL_1_MRKT_TAG_2_TXT__c='Test',OwnerId=ownerId);
        }
        slsOrgLdrshp.add(rec);
        slsOrgLdrMkt.add(recMkt);
        insert slsOrgLdrshp;
        insert slsOrgLdrMkt;
        return slsOrgLdrshp;
        
    }
    /*
    
    */
    //Zishan Change Added Override_Label__c=false To Leader Activity Config SOQL 07/23/09
    public List<Leader_Activity_Config__c> createLdrActvtyConfig(){
        Leader_Activity_Config__c cfg;
        createMarket();
        ldrActvty = new List<Leader_Activity_Config__c>();
        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Currency',Is_Market_Tag__c=false,Override_Label__c=false,Market__c=this.market.Id,
        Next_Campaign_Fld__c='AVG_ORD_AMT__c',Non_Leader_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
        Row_Type__c='Award Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c',Title_Lvl_1_Fld__c='AVG_ORD_AMT__c',Title_Lvl_2_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_3_Fld__c='AVG_ORD_AMT__c',Title_Lvl_4_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_5_Fld__c='AVG_ORD_AMT__c',Title_Lvl_UQ_Fld__c='AVG_ORD_AMT__c');
        ldrActvty.add(cfg); 

        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c=null,Data_Type__c='Currency',Is_Market_Tag__c=false,Override_Label__c=false,Market__c=this.market.Id,
        Next_Campaign_Fld__c='AVG_ORD_AMT__c',Non_Leader_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
        Row_Type__c='Award Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c',Title_Lvl_1_Fld__c='AVG_ORD_AMT__c',Title_Lvl_2_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_3_Fld__c='AVG_ORD_AMT__c',Title_Lvl_4_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_5_Fld__c='AVG_ORD_AMT__c',Title_Lvl_UQ_Fld__c='AVG_ORD_AMT__c');
        ldrActvty.add(cfg); 

        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c=null,Data_Type__c='Number',Is_Market_Tag__c=false,Override_Label__c=false,Market__c=this.market.Id,
        Next_Campaign_Fld__c='AVG_ORD_AMT__c',Non_Leader_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
        Row_Type__c='Award Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c',Title_Lvl_1_Fld__c='AVG_ORD_AMT__c',Title_Lvl_2_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_3_Fld__c='AVG_ORD_AMT__c',Title_Lvl_4_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_5_Fld__c='AVG_ORD_AMT__c',Title_Lvl_UQ_Fld__c='AVG_ORD_AMT__c');
        ldrActvty.add(cfg); 

        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Currency',Is_Market_Tag__c=false,Override_Label__c=false,Market__c=this.market.Id,
        Next_Campaign_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
        Row_Type__c='Net Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c');
        ldrActvty.add(cfg); 
        
        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',Is_Market_Tag__c=false,Override_Label__c=false,Market__c=this.market.Id,
        Next_Campaign_Fld__c='AVG_ORD_AMT__c',Non_Leader_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
        Row_Type__c='Net Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c',Title_Lvl_1_Fld__c='AVG_ORD_AMT__c',Title_Lvl_2_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_3_Fld__c='AVG_ORD_AMT__c',Title_Lvl_4_Fld__c='AVG_ORD_AMT__c',
        Title_Lvl_5_Fld__c='AVG_ORD_AMT__c',Title_Lvl_UQ_Fld__c='AVG_ORD_AMT__c');
        ldrActvty.add(cfg); 
        
        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',Is_Market_Tag__c=false,Override_Label__c=false,Market__c=this.market.Id,
        Next_Campaign_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
        Row_Type__c='Net Sales1',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c');
        ldrActvty.add(cfg); 
        
        cfg = new Leader_Activity_Config__c(Current_Campaign_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Data_Type__c='Text',Is_Market_Tag__c=true,Market__c=this.market.Id,
        Next_Campaign_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Non_Leader_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Plan_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',
        Prior_Campaign_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Row_Type__c='Market Tag 1',SPPY_Campaign_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',
        Title_Lvl_1_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Title_Lvl_2_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',
        Title_Lvl_3_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Title_Lvl_4_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',
        Title_Lvl_5_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Title_Lvl_UQ_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c');
        ldrActvty.add(cfg); 
        insert ldrActvty;
        return ldrActvty;
    }
    public List<Market_Activity_Config__c> createMktConfig(){
        Market_Activity_Config__c cfg;
        createMarket();
        mktActvty = new List<Market_Activity_Config__c>();
        cfg = new Market_Activity_Config__c(Data_Type__c='Currency',Is_Market_Tag__c=false,
                                        Leadership_Fld__c='LDRSHP_AVG_ORD_AMT__c',Market__c=this.market.Id,Next_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         NonLeadership_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         Row_Type__c='Award Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c');
        mktActvty.add(cfg); 
        cfg = new Market_Activity_Config__c(Current_Campaign_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Currency',Is_Market_Tag__c=false,
                                        Market__c=this.market.Id,Next_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         Row_Type__c='Paid Sales',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c');
        mktActvty.add(cfg); 
        cfg = new Market_Activity_Config__c(Current_Campaign_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',Is_Market_Tag__c=false,
                                        Leadership_Fld__c='AVG_ORD_AMT__c',Market__c=this.market.Id,Next_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         NonLeadership_Fld__c='AVG_ORD_AMT__c',Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         Row_Type__c='Orders Submitted',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c');
        mktActvty.add(cfg); 
        cfg = new Market_Activity_Config__c(Data_Type__c='Number',Is_Market_Tag__c=false,
                                        Market__c=this.market.Id,Next_Campaign_Fld__c='AVG_ORD_AMT__c',
                                        Plan_Fld__c='AVG_ORD_AMT__c',Prior_Campaign_Fld__c='AVG_ORD_AMT__c',
                                         Row_Type__c='Orders not Submitted',SPPY_Campaign_Fld__c='AVG_ORD_AMT__c');
        mktActvty.add(cfg); 

        cfg = new Market_Activity_Config__c(Current_Campaign_Fld__c='PLAN_MRKT_TAG_3_TXT__c',Data_Type__c='Text',Is_Market_Tag__c=true,
                                        Leadership_Fld__c='PLAN_MRKT_TAG_3_TXT__c',Market__c=this.market.Id,Next_Campaign_Fld__c='PLAN_MRKT_TAG_3_TXT__c',
                                         NonLeadership_Fld__c='PLAN_MRKT_TAG_3_TXT__c',Plan_Fld__c='PLAN_MRKT_TAG_3_TXT__c',
                                         Prior_Campaign_Fld__c='PLAN_MRKT_TAG_3_TXT__c',
                                         Row_Type__c='Market Tag 1',SPPY_Campaign_Fld__c='PLAN_MRKT_TAG_3_TXT__c');
        mktActvty.add(cfg); 

        cfg = new Market_Activity_Config__c(Current_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c',Data_Type__c='Currency',Is_Market_Tag__c=true,
                                        Leadership_Fld__c='PLAN_MRKT_TAG_1_AMT__c',Market__c=this.market.Id,Next_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c',
                                         NonLeadership_Fld__c='PLAN_MRKT_TAG_1_AMT__c',Plan_Fld__c='PLAN_MRKT_TAG_1_AMT__c',
                                         Prior_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c',
                                         Row_Type__c='Market Tag 2',SPPY_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c');
        mktActvty.add(cfg); 

        cfg = new Market_Activity_Config__c(Current_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c',Data_Type__c='Number',Is_Market_Tag__c=true,
                                        Leadership_Fld__c='PLAN_MRKT_TAG_1_AMT__c',Market__c=this.market.Id,Next_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c',
                                         NonLeadership_Fld__c='PLAN_MRKT_TAG_1_AMT__c',Plan_Fld__c='PLAN_MRKT_TAG_1_AMT__c',
                                         Prior_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c',
                                         Row_Type__c='Market Tag 3',SPPY_Campaign_Fld__c='PLAN_MRKT_TAG_1_AMT__c');
        mktActvty.add(cfg); 


        insert mktActvty;
        return mktActvty;                                               
    }
    //Zishan Change Added Override_Label__c=false, 07/23/09 to MarketAnalysisConfig SOQL
    public List<Market_Analysis_Config__c> createMktAnalysisConfig(){
        createMarket();
        createLeaderTitles();
        this.mktAnlCfg = new List<Market_Analysis_Config__c>();
        Market_Analysis_Config__c cfg;
        cfg = new Market_Analysis_Config__c(    Block__c='Order Status',Col1_Fld__c='AVG_ORD_AMT__c',Col2_Fld__c='AVG_ORD_AMT__c',
                                                Col3_Fld__c='AVG_ORD_AMT__c',Col4_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Currency',
                                                Is_Market_Tag__c=false,Override_Label__c=false,Is_Title_Tag__c=false,Display_Totals__c=true,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Orders Not Submitted',Section__c='Orders');
        mktAnlCfg.add(cfg);     
        cfg = new Market_Analysis_Config__c(    Block__c='Order Status',Col1_Fld__c='AVG_ORD_AMT__c',Col2_Fld__c='AVG_ORD_AMT__c',
                                                Col3_Fld__c='AVG_ORD_AMT__c',Col4_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Currency',
                                                Is_Market_Tag__c=false,Override_Label__c=false,Is_Title_Tag__c=false,Display_Totals__c=true,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Orders Under Minimum',Section__c='Orders');
        mktAnlCfg.add(cfg);     
        cfg = new Market_Analysis_Config__c(    Block__c='Orders-Market Tags',Col1_Fld__c='UQ_TITL_1_MRKT_TAG_1_AMT__c',Col2_Fld__c='UQ_TITL_1_MRKT_TAG_1_AMT__c',
                                                Col3_Fld__c='UQ_TITL_1_MRKT_TAG_1_AMT__c',Col4_Fld__c='UQ_TITL_1_MRKT_TAG_1_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=true,Override_Label__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Market Tag 1',Section__c='Orders');
        mktAnlCfg.add(cfg);     

        cfg = new Market_Analysis_Config__c(    Block__c='Orders-Market Tags',Col1_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Col2_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',
                                                Col3_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Col4_Fld__c='UQ_TITL_1_MRKT_TAG_2_TXT__c',Data_Type__c='Text',
                                                Is_Market_Tag__c=true,Override_Label__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Market Tag 2',Section__c='Orders');
        mktAnlCfg.add(cfg);     
        
        cfg = new Market_Analysis_Config__c(    Block__c='Award Sales',Col1_Fld__c='AVG_ORD_AMT__c',Col2_Fld__c='AVG_ORD_AMT__c',
                                                Col3_Fld__c='AVG_ORD_AMT__c',Col4_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Override_Label__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Total Award Sales',Section__c='Sales');
        mktAnlCfg.add(cfg);     

        cfg = new Market_Analysis_Config__c(    Block__c='Award Sales',Col1_Fld__c='AVG_ORD_AMT__c',Col2_Fld__c='AVG_ORD_AMT__c',
                                                Col3_Fld__c='AVG_ORD_AMT__c',Col4_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Override_Label__c=false,Is_Title_Tag__c=false,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Net Sales',Section__c='Sales');
        mktAnlCfg.add(cfg);     

        cfg = new Market_Analysis_Config__c(    Block__c='Additions',Col1_Fld__c='AVG_ORD_AMT__c',Col2_Fld__c='AVG_ORD_AMT__c',
                                                Col3_Fld__c='AVG_ORD_AMT__c',Col4_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Override_Label__c=false,Is_Title_Tag__c=true,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Title Level 1',Section__c='Current Business');
        mktAnlCfg.add(cfg);     

        cfg = new Market_Analysis_Config__c(    Block__c='Additions',Col1_Fld__c='AVG_ORD_AMT__c',Col2_Fld__c='AVG_ORD_AMT__c',
                                                Col3_Fld__c='AVG_ORD_AMT__c',Col4_Fld__c='AVG_ORD_AMT__c',Data_Type__c='Number',
                                                Is_Market_Tag__c=false,Override_Label__c=false,Is_Title_Tag__c=true,
                                                Market__c=this.market.Id,Report__c=null,Row_Type__c='Title Level 2',Section__c='Current Business');
        mktAnlCfg.add(cfg);     
        
        insert mktAnlCfg;
        return mktAnlCfg;
    }
    
    public List<Report_Config__c> createReportConfig(){
        createMarket();
        List<Report_Config__c> rptCfg = new List<Report_Config__c>();
        Report_Config__c cfg;
        cfg = new Report_Config__c( Name='Test Report',Market__c=this.market.id,
                                    Report_Type__c='Test1',Order_Criteria__c='Personal_Sales__r.AWRD_SLS_AMT__c>0',
                                    Report_Id__c='R01',Applicable_To__c='Avon Leader;Avon Zone Manager;Avon Division Manager',
                                    Columns_To_Display__c='Representative__r.LOA_NR__c'+'\n'+'Personal_Sales__r.BAL_DUE_AMT__c'
                                    );
        rptCfg.add(cfg);
        cfg = new Report_Config__c( Name='Test Report',Market__c=this.market.id,
                                    Report_Type__c='Test2',Rep_Criteria__c='Representative__r.LOA_NR__c !=null',
                                    Report_Id__c='R02',Applicable_To__c='Avon Leader;Avon Zone Manager;Avon Division Manager',
                                    Columns_To_Display__c='Representative__r.LOA_NR__c'+'\n'+'Personal_Sales__r.BAL_DUE_AMT__c');
        rptCfg.add(cfg);
        cfg = new Report_Config__c( Name='Test Report',Market__c=this.market.id,
                                    Report_Type__c='Test3',Ldr_Smry_Criteria__c='Group_Sales__r.TOTAL_TAR_CNT__c',
                                    Report_Id__c='R03',Applicable_To__c='Avon Leader;Avon Zone Manager;Avon Division Manager',
                                    Columns_To_Display__c='Representative__r.LOA_NR__c'+'\n'+'Personal_Sales__r.BAL_DUE_AMT__c');
        rptCfg.add(cfg);
        cfg = new Report_Config__c( Name='Test Report',Market__c=this.market.id,
                                    Report_Type__c='Orders_below_Minimum',Ldr_Smry_Criteria__c='',
                                    Report_Id__c='R04',Applicable_To__c='Avon Leader;Avon Zone Manager;Avon Division Manager',
                                    Columns_To_Display__c='Representative__r.LOA_NR__c'+'\n'+'Personal_Sales__r.BAL_DUE_AMT__c');
        rptCfg.add(cfg);

        cfg = new Report_Config__c( Name='Test Report',Market__c=this.market.id,
                                    Report_Type__c='Orders_at_Minimum',Ldr_Smry_Criteria__c='',
                                    Report_Id__c='R05',Applicable_To__c='Avon Leader;Avon Zone Manager;Avon Division Manager',
                                    Columns_To_Display__c='Representative__r.LOA_NR__c'+'\n'+'Personal_Sales__r.BAL_DUE_AMT__c',
                                    Default_Sort__c='Representative__r.LOA_NR__c');
        rptCfg.add(cfg);
        insert rptCfg;
        
        return rptCfg;
    }
    
    public List<Market_Document__c> createMarketDocument(){
        createMarket();
        Folder f = [select Name,Id from Folder where Name='Dummy Doc Folder DO NOT DELETE'];
        System.Debug('folder' + f.id);     
        //New Document
        List<Document> docList = new List<Document>();
        List<Market_Document__c> mktDocList = new List<Market_Document__c>();
        Document d = new document();        
        d.Type='jpg';
        d.Name='Add_now ';
        d.FolderId = f.Id; 
        d.DeveloperName='Add_Now ';
        d.Description=' yeah yeah';
        d.ContentType='image/pjpeg ';
        docList.add(d);
        
        insert docList;
        
        Market_Document__c mktDoc = new Market_Document__c( Market__c=this.market.Id,Type__c='Test',
                                                            Language__c='en_US',Document_Id__c=docList[0].Id);
        mktDocList.add(mktDoc);
        insert mktDocList;  
        System.debug('>>>>>>>>>>>>>>>> mktDocList='+mktDocList);                                                
        return mktDocList; 

    }
    
    public Task createMarketTask(){
        createMarket();
        User mktUser = createMarketAdminUser('MXX');
        Task t = new Task(  OwnerId=mktUser.Id,Subject='Test',
                            ActivityDate=System.today(),
                            Priority='Normal',Status='Not Started',
                            WhatId=this.market.Id);
        insert t;
        return t;   
    }

    public Task createTaskForUser(User usr){
        Task t = new Task(  OwnerId=usr.Id,Subject='Test',
                            ActivityDate=System.today(),
                            Priority='Normal',Status='Not Started');
        insert t;
        return t;   
    }

    public static testmethod void testTestDataHelper(){
        TestDataHelper helper = new TestDataHelper();
        helper.createMarket();
        helper.createActionItems();
        helper.createLeaderTitles();
        helper.createSellerStatus();
        helper.createAccount();
        helper.createContact('123123',UserInfo.getUserId());
        helper.createMyBusinessData('12123',UserInfo.getUserId());
        helper.createDownlineData('11123',1,UserInfo.getUserId());
        helper.createLdrSmryData('123',UserInfo.getUserId());
        helper.createMyBusinessConfig();
        helper.createLdrPerfConfig();
        helper.createLdrPerfConfigEmpty();
        helper.createLdrAnalysisConfig();
        helper.createCurrPerfConfig();
        helper.createMarketActionItems();
        helper.createMailPlans();
        helper.createLeaderUser('L123');
        User usr = helper.createZoneUser('Z123');
        helper.createDivUser('D123');
        helper.createUser('123','XZ1','Avon Leader');
        helper.createMarketTags(new String[]{'Subj1','Subj2'});
        helper.createUsrSlsOrgHrchy(helper.createLeaderUser('LL12345'));
        helper.createUsrSlsOrgHrchy(helper.createLeaderUser('LLL1234567'),'XZ1','Z');
        helper.createSalesOrgs();
        helper.createEmailTemplate();
        helper.create2ndGenDownlineData('1234','A1234',2);
        User mktUsr = helper.createMarketAdminUser('M1');
        Task tsk = helper.createTaskForUser(mktUsr);
        helper.createMktActivity(usr, 'Avon Zone Manager',UserInfo.getUserId());
        helper.createMktActivity(usr, 'Avon Division Manager',UserInfo.getUserId());
        helper.createSlsLdrActivity(usr,'Avon Zone Manager',UserInfo.getUserId());
        helper.createSlsLdrActivity(usr,'Avon Division Manager',UserInfo.getUserId());
        helper.createLdrActvtyConfig();

        helper.createMktConfig();
        helper.createMktAnalysisConfig();
        helper.createReportConfig();
        helper.createMarketDocument();
        helper.createMarketTask();
        //helper.createMyBusinessDataWithOwner('M123');
        //helper.createLdrSmryDataWithOwner('L123');
    }
}
			                            	