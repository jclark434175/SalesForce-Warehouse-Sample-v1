public class SalesOrgActivityController {
    public List<SalesOrgActivityRowWrapper> activityRows {get; set;}
    public Market__c market {get; set;}
    private Map<String,String> mktTags = new Map<String,String>();
    public Sales_Org_Activity__c currRec {get; private set;}
    public User currUsr {get; private set;}
    public PageReference init(){
        currUsr = [select   Id,DFALT_ZONE_CD__c,DFALT_DIV_NM__c,MRKT_ID__c
                        from    User
                        where   Id=:UserInfo.getUserId()];
        Profile usrProfile = [  select  Id,Name
                                from    Profile
                                where   Id=:UserInfo.getProfileId()
                            ];
        String key;             
        if(usrProfile.Name == 'Avon Zone Manager'){
            key = currUsr.MRKT_ID__c+'Z'+currUsr.DFALT_ZONE_CD__c;
          }else if(usrProfile.Name == 'Avon Division Manager'){
            if(currUsr.DFALT_ZONE_CD__c==null){
                key = currUsr.MRKT_ID__c+'D'+currUsr.DFALT_DIV_NM__c;
            }else{
                key = currUsr.MRKT_ID__c+'Z'+currUsr.DFALT_ZONE_CD__c;
            }
            
        }
        System.debug('>>>>>>>>>>>>>>>> key='+key);
        this.currRec =
                    [select 
                            TRAD_STF_CNT__c,PC_PD_SLS_AMT__c,
                            TRAD_RTURN_CNT__c,PC_PD_LDRSHP_ERNGS_AMT__c,
                            TRAD_RNSTMT_CNT__c,PC_PAST_DUE_AMT__c,
                            TRAD_RMVL_CNT__c,PC_OUT_ZONE_STF_CNT__c,
                            TRAD_PENDNG_ORD_CNT__c,PC_OUT_ZONE_FRST_ORD_CNT__c,
                            TRAD_PD_SLS_AMT__c,PC_ORD_UND_MIN_AMT__c,
                            TRAD_PAST_DUE_AMT__c,PC_ORD_CNT__c,
                            TRAD_OUT_ZONE_STF_CNT__c,PC_NO_ORD_CNT__c,
                            TRAD_OUT_ZONE_FRST_ORD_CNT__c,PC_NET_SLS_AMT__c,
                            TRAD_ORD_CNT__c,PC_MRKT_TAG_6_PCT__c,
                            TRAD_NO_ORD_CNT__c,PC_MRKT_TAG_5_TXT__c,
                            TRAD_NET_SLS_AMT__c,PC_MRKT_TAG_4_TXT__c,
                            TRAD_MRKT_TAG_6_PCT__c,PC_MRKT_TAG_3_TXT__c,
                            TRAD_MRKT_TAG_5_TXT__c,PC_MRKT_TAG_2_AMT__c,
                            TRAD_MRKT_TAG_4_TXT__c,PC_MRKT_TAG_1_AMT__c,
                            TRAD_MRKT_TAG_3_TXT__c,PC_LDRSHP_STF_CNT__c,
                            TRAD_MRKT_TAG_2_AMT__c,PC_LDRSHP_ORD_UND_MIN_AMT__c,
                            TRAD_MRKT_TAG_1_AMT__c,PC_LDRSHP_ORD_CNT__c,
                            TRAD_IN_ZONE_STF_CNT__c,PC_LDRSHP_NET_SLS_AMT__c,
                            TRAD_IN_ZONE_FRST_ORD_CNT__c,PC_IN_ZONE_STF_CNT__c,
                            TRAD_HOLD_ORD_CNT__c,PC_IN_ZONE_FRST_ORD_CNT__c,
                            TRAD_BAL_DUE_AMT__c,PC_HOLD_ORD_CNT__c,
                            TRAD_AWRD_SLS_AMT__c,PC_BAL_DUE_AMT__c,
                            TRAD_AVG_PER_ORD_CUST_AMT__c,PC_AWRD_SLS_AMT__c,
                            TRAD_AVG_ORD_AMT__c,PC_AVG_PER_ORD_CUST_AMT__c,
                            TRAD_AVG_CUST_PER_ORD_CNT__c,PC_AVG_ORD_AMT__c,
                            TRAD_APPT_CNT__c,PC_AVG_CUST_PER_ORD_CNT__c,
                            TRAD_ACTVTY_PCT__c,PC_APPT_CNT__c,
                            SystemModstamp,PC_ACTVTY_PCT__c,
                            SPPY_TRAD_ORD_UND_MIN_AMT__c,PAST_DUE_AMT_PLAN__c,
                            SPPY_STF_CNT__c,OwnerId,
                            SPPY_RTURN_AMT__c,OPERTNL_CMPGN_NR__c,
                            SPPY_RNSTMT_CNT__c,Name,
                            SPPY_RMVL_CNT__c,NET_SLS_PLAN_AMT__c,
                            SPPY_PENDNG_ORD_CNT__c,NC_STF_CNT__c,
                            SPPY_PD_SLS_AMT__c,NC_RTURN_AMT__c,
                            SPPY_PD_LDRSHP_ERNGS_AMT__c,NC_RNSTMT_CNT__c,
                            SPPY_PAST_DUE_AMT__c,NC_RMVL_CNT__c,
                            SPPY_OUT_ZONE_STF_CNT__c,NC_PENDNG_ORD_CNT__c,
                            SPPY_OUT_ZONE_FRST_ORD_CNT__c,NC_PD_SLS_AMT__c,
                            SPPY_ORD_UND_MIN_AMT__c,NC_PAST_DUE_AMT__c,
                            SPPY_ORD_CNT__c,NC_OUT_ZONE_STF_CNT__c,
                            SPPY_NO_ORD_CNT__c,NC_OUT_ZONE_FRST_ORD_CNT__c,
                            SPPY_NET_SLS_AMT__c,NC_ORD_UND_MIN_AMT__c,
                            SPPY_MRKT_TAG_6_PCT__c,NC_ORD_CNT__c,
                            SPPY_MRKT_TAG_5_TXT__c,NC_NO_ORD_CNT__c,
                            SPPY_MRKT_TAG_4_TXT__c,NC_NET_SLS_AMT__c,
                            SPPY_MRKT_TAG_3_TXT__c,NC_MRKT_TAG_6_PCT__c,
                            SPPY_MRKT_TAG_2_AMT__c,NC_MRKT_TAG_5_TXT__c,
                            SPPY_MRKT_TAG_1_AMT__c,NC_MRKT_TAG_4_TXT__c,
                            SPPY_IN_ZONE_STF_CNT__c,NC_MRKT_TAG_3_TXT__c,
                            SPPY_IN_ZONE_FRST_ORD_CNT__c,NC_MRKT_TAG_2_AMT__c,
                            SPPY_HOLD_ORD_CNT__c,NC_MRKT_TAG_1_AMT__c,
                            SPPY_BAL_DUE_AMT__c,NC_IN_ZONE_STF_CNT__c,
                            SPPY_AWRD_SLS_AMT__c,NC_IN_ZONE_FRST_ORD_CNT__c,
                            SPPY_AVG_PER_ORD_CUST_AMT__c,NC_HOLD_ORD_CNT__c,
                            SPPY_AVG_ORD_AMT__c,NC_AWRD_SLS_AMT__c,
                            SPPY_AVG_CUST_PER_ORD_CNT__c,NC_AVG_PER_ORD_CUST_AMT__c,
                            SPPY_APPT_CNT__c,NC_AVG_CUST_PER_ORD_CNT__c,
                            SPPY_ACTVTY_PCT__c,NC_AVG_AVG_ORD_AMT__c,
                            SLS_ORG_NM__c,NC_APPT_CNT__c,
                            SLS_ORG_LVL_NR__c,NC_ACTVTY_PCT__c,
                            SLS_ORG_CD__c,MRKT_TAG_2_PLAN_AMT__c,
                            PLAN_TRAD_NET_SLS_AMT__c,MRKT_ID__c,
                            PLAN_STF_CNT__c,MRKT_ID_ZONE_CD_KEY__c,
                            PLAN_RTURN_AMT__c,LastModifiedDate,
                            PLAN_RNSTMT_CNT__c,LastModifiedById,
                            PLAN_RMVL_CNT__c,LDRSHP_STF_CNT__c,
                            PLAN_PD_SLS_AMT__c,LDRSHP_RTURN_CNT__c,
                            PLAN_PD_LDRSHP_ERNGS_AMT__c,LDRSHP_RNSTMT_CNT__c,
                            PLAN_OUT_ZONE_STF_CNT__c,LDRSHP_RMVL_CNT__c,
                            PLAN_OUT_ZONE_FRST_ORD_CNT__c,LDRSHP_PENDNG_ORD_CNT__c,
                            PLAN_ORD_UND_MIN_AMT__c,LDRSHP_PD_SLS_AMT__c,
                            PLAN_ORD_CNT__c,LDRSHP_PAST_DUE_AMT__c,
                            PLAN_NO_ORD_CNT__c,LDRSHP_OUT_ZONE_STF_CNT__c,
                            PLAN_MRKT_TAG_6_PCT__c,LDRSHP_OUT_ZONE_FRST_ORD_CNT__c,
                            PLAN_MRKT_TAG_5_TXT__c,LDRSHP_ORD_CNT__c,
                            PLAN_MRKT_TAG_4_TXT__c,LDRSHP_NO_ORD_CNT__c,
                            PLAN_MRKT_TAG_3_TXT__c,LDRSHP_NET_SLS_AMT__c,
                            PLAN_MRKT_TAG_1_AMT__c,LDRSHP_MRKT_TAG_6_PCT__c,
                            PLAN_LDRSHP_NET_SLS_AMT__c,LDRSHP_MRKT_TAG_5_TXT__c,
                            PLAN_IN_ZONE_STF_CNT__c,LDRSHP_MRKT_TAG_4_TXT__c,
                            PLAN_IN_ZONE_FRST_ORD_CNT__c,LDRSHP_MRKT_TAG_3_TXT__c,
                            PLAN_HOLD_ORD_CNT__c,LDRSHP_MRKT_TAG_2_AMT__c,
                            PLAN_AWRD_SLS_AMT__c,LDRSHP_MRKT_TAG_1_AMT__c,
                            PLAN_AVG_PER_ORD_CUST_AMT__c,LDRSHP_IN_ZONE_STF_CNT__c,
                            PLAN_AVG_ORD_AMT__c,LDRSHP_IN_ZONE_FRST_ORD_CNT__c,
                            PLAN_AVG_CUST_PER_ORD_CNT__c,LDRSHP_HOLD_ORD_CNT__c,
                            PLAN_APPT_CNT__c,LDRSHP_BAL_DUE_AMT__c,
                            PLAN_ALL_ADDN_AMT__c,LDRSHP_AWRD_SLS_AMT__c,
                            PLAN_ACTVTY_PCT__c,LDRSHP_AVG_PER_ORD_CUST_AMT__c,
                            PENDNG_ORD_CNT__c,LDRSHP_AVG_ORD_AMT__c,
                            PC_TRAD_STF_CNT__c,LDRSHP_AVG_CUST_PER_ORD_CNT__c,
                            PC_TRAD_ORD_CNT__c,LDRSHP_APPT_CNT__c,
                            PC_TRAD_NET_SLS_AMT__c,LDRSHP_ACTVTY_PCT__c,
                            PC_STF_CNT__c,CUST_CNT__c,
                            PC_RTURN_AMT__c,AVG_PER_ORD_CUST_AMT__c,
                            PC_RNSTMT_CNT__c,AVG_ORD_AMT__c,
                            PC_RMVL_CNT__c,AVG_CUST_CNT__c,
                            PC_PENDNG_ORD_CNT__c,ACTVTY_PCT__c,
                            CC_PD_LDRSHP_ERNGS_AMT__c,
                            CC_ACTVTY_PCT__c,CC_AVG_ORD_CNT__c,
                            CurrencyIsoCode 
                    from    Sales_Org_Activity__c
                    where   MRKT_ID_ZONE_CD_KEY__c =:key
                    ];

            this.market = [ select Name,Mkt_Actvty_CC_Enabled__c,
                                    Mkt_Actvty_PC_Enabled__c,
                                    Mkt_Actvty_NC_Enabled__c,
                                    Mkt_Actvty_SPPY_Enabled__c,
                                    Mkt_Actvty_Plan_Enabled__c,
                                    Mkt_Actvty_Ldr_Enabled__c,
                                    Mkt_Actvty_Non_Ldr_Enabled__c
                            from    Market__c
                            where   Market_Id__c = :currRec.MRKT_ID__c
                            ];
            List<Market_Activity_Config__c> configList = [Select    Market__c,SPPY_Campaign_Fld__c, Row_Type__c, 
                                                                    Prior_Campaign_Fld__c, Next_Campaign_Fld__c, 
                                                                    Is_Market_Tag__c, Data_Type__c,Current_Campaign_Fld__c,
                                                                    Leadership_Fld__c,NonLeadership_Fld__c,
                                                                    Plan_Fld__c, Reverse_Trending_Arrows__c
                                                            From    Market_Activity_Config__c 
                                                            where   Market__r.Market_Id__c=:currRec.MRKT_ID__c
                                                            order by CreatedDate];
            List<String> mktTagSubjAreas = new List<String>();

            mktTagSubjAreas.add('Zone-Market Activity');
            MarketTagUtils mktTags = new MarketTagUtils();
            mktTags.initialize(mktTagSubjAreas);
            Sales_Activity_Row__c currRow;
            SObject sObj = currRec;
            activityRows = new List<SalesOrgActivityRowWrapper>();
            Boolean oddRow=true;
            for(Market_Activity_Config__c cfg: configList){
                currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
                currRow.Data_Type__c = cfg.Data_Type__c;
                currRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
                if(!cfg.Is_Market_Tag__c){
                    currRow.Row_Label__c = cfg.Row_Type__c;
                }else{
                    currRow.Row_Label__c = mktTags.getLabel('Zone-Market Activity',cfg.Row_Type__c);
                }
                
                if(cfg.Data_Type__c == 'Currency'){
                    if(cfg.Leadership_Fld__c!=null) currRow.Ldr_AMT__c = getFieldValue(cfg.Leadership_Fld__c,currRec);
                    if(cfg.Next_Campaign_Fld__c!=null) currRow.NC_AMT__c = getFieldValue(cfg.Next_Campaign_Fld__c,currRec);
                    if(cfg.NonLeadership_Fld__c!=null) currRow.NonLdr_AMT__c = getFieldValue(cfg.NonLeadership_Fld__c,currRec);
                    if(cfg.Plan_Fld__c!=null) currRow.Plan_AMT__c = getFieldValue(cfg.Plan_Fld__c,currRec);
                    if(cfg.Prior_Campaign_Fld__c!=null) currRow.PC_AMT__c = getFieldValue(cfg.Prior_Campaign_Fld__c,currRec);
                    if(cfg.SPPY_Campaign_Fld__c!=null) currRow.SPPY_AMT__c = getFieldValue(cfg.SPPY_Campaign_Fld__c,currRec);
                    if(cfg.Current_Campaign_Fld__c==null){
                        currRow.CC_AMT__c = (currRow.Ldr_AMT__c!=null?currRow.Ldr_AMT__c:0.0) +(currRow.NonLdr_AMT__c!=null?currRow.NonLdr_AMT__c:0.0);
                    }else{
                        currRow.CC_AMT__c = getFieldValue(cfg.Current_Campaign_Fld__c,currRec);
                    } 
                }
                else if(cfg.Data_Type__c == 'Number'){
                    if(cfg.Leadership_Fld__c!=null) currRow.Ldr_CNT__c = getFieldValue(cfg.Leadership_Fld__c,currRec);
                    if(cfg.Next_Campaign_Fld__c!=null) currRow.NC_CNT__c = getFieldValue(cfg.Next_Campaign_Fld__c,currRec);
                    if(cfg.NonLeadership_Fld__c!=null) currRow.NonLdr_CNT__c = getFieldValue(cfg.NonLeadership_Fld__c,currRec);
                    if(cfg.Plan_Fld__c!=null) currRow.Plan_CNT__c = getFieldValue(cfg.Plan_Fld__c,currRec);
                    if(cfg.Prior_Campaign_Fld__c!=null) currRow.PC_CNT__c = getFieldValue(cfg.Prior_Campaign_Fld__c,currRec);
                    if(cfg.SPPY_Campaign_Fld__c!=null) currRow.SPPY_CNT__c = getFieldValue(cfg.SPPY_Campaign_Fld__c,currRec);
                    currRow.CC_CNT__c = (currRow.Ldr_CNT__c!=null?currRow.Ldr_CNT__c:0) +(currRow.NonLdr_CNT__c!=null?currRow.NonLdr_CNT__c:0); 
                    if(cfg.Current_Campaign_Fld__c==null){
                        currRow.CC_CNT__c = (currRow.Ldr_CNT__c!=null?currRow.Ldr_CNT__c:0.0) +(currRow.NonLdr_CNT__c!=null?currRow.NonLdr_CNT__c:0.0);
                    }else{
                        currRow.CC_CNT__c = getFieldValue(cfg.Current_Campaign_Fld__c,currRec);
                    } 
                }else{
                    if(cfg.Current_Campaign_Fld__c!=null) currRow.CC_TXT__c = (String)sObj.get(cfg.Current_Campaign_Fld__c);
                    if(cfg.Leadership_Fld__c!=null) currRow.Ldr_TXT__c = (String)sObj.get(cfg.Leadership_Fld__c);
                    if(cfg.Next_Campaign_Fld__c!=null) currRow.NC_TXT__c = (String)sObj.get(cfg.Next_Campaign_Fld__c);
                    if(cfg.NonLeadership_Fld__c!=null) currRow.NonLdr_TXT__c = (String)sObj.get(cfg.NonLeadership_Fld__c);
                    if(cfg.Plan_Fld__c!=null) currRow.Plan_TXT__c = (String)sObj.get(cfg.Plan_Fld__c);
                    if(cfg.Prior_Campaign_Fld__c!=null) currRow.PC_TXT__c = (String)sObj.get(cfg.Prior_Campaign_Fld__c);
                    if(cfg.SPPY_Campaign_Fld__c!=null) currRow.SPPY_TXT__c = (String)sObj.get(cfg.SPPY_Campaign_Fld__c);
                }
                /*Zishan Added 8/20/09 and Commented out old code
                this.activityRows.add(new SalesOrgActivityRowWrapper(currRow));*/
                this.activityRows.add(new SalesOrgActivityRowWrapper(currRow,cfg.Reverse_Trending_Arrows__c));
                oddRow = !oddRow;
                
            }
                    
        return null;    
    }
    
    public Integer getEnabledColCount(){
        Integer colCount = 1;
        try{
            if(this.market.Mkt_Actvty_SPPY_Enabled__c){
                colCount+=2;
            }   
            if(this.market.Mkt_Actvty_PC_Enabled__c){
                colCount+=2;
            }   
            if(this.market.Mkt_Actvty_NC_Enabled__c){
                colCount+=1;
            }   
            if(this.market.Mkt_Actvty_CC_Enabled__c){
                colCount+=1;
            }
            if(this.market.Mkt_Actvty_Plan_Enabled__c){
                colCount+=1;
            }           
            if(this.market.Mkt_Actvty_Ldr_Enabled__c){
                colCount+=2;
            }
            if(this.market.Mkt_Actvty_Non_Ldr_Enabled__c){
                colCount+=2;
            }
        }catch(Exception ex){
            //ErrorHandler.handleError('MyBusiness', ex);
            return -1;
        }   
        return colCount;    
    }

    private Decimal getFieldValue(String colFlds,Sales_Org_Activity__c currRec){
        Decimal totVal = null;
        //System.debug('>>>>>>>>>>>>>>> colFlds'+colFlds);
        String tempFld;
        for(String fldName: colFlds.split('\n')){
            tempFld = fldName.trim();
            if(currRec.get(tempFld)!=null){
                if(totVal==null){
                    totVal = 0.0;   
                }
                totVal += (Decimal)currRec.get(tempFld);
            }
        }
        return totVal;
    }
    
    public static testmethod void testSlsOrgActivity(){
        SalesOrgActivityController ctlr = new SalesOrgActivityController();
        String mktIdKey = 'TEST123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createZoneUser('123456');
        List<Sales_Org_Activity__c> data;
        List<Market_Activity_Config__c> rowCfg; 
        data= testData.createMktActivity(testUsr,'Avon Zone Manager',testUsr.Id);   
        rowCfg= testData.createMktConfig(); 
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.getEnabledColCount()==12);
        }
        testUsr = testData.createDivUser('D123456');
        //rowCfg = testData.createMktConfig();
        data = testData.createMktActivity(testUsr,'Avon Division Manager',testUsr.Id);
        System.debug('>>>>>>>>>>>>>>>>>>>>>> Division User:'+testUsr.Id);
        System.debug('>>>>>>>>>>>>>>>>>>>>>> DIV Data:'+data);  
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.getEnabledColCount()==12);
            testUsr.DFALT_ZONE_CD__c=null;
            update testUsr;
            ctlr.init();
            System.assert(ctlr.getEnabledColCount()==12);
        }
        
    }
}
			                            	