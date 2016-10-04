public class ZoneDivEarnOpptyController {
    public Sales_Activity_Row__c ordNotSub {get; set;}
    public Sales_Activity_Row__c ordOnHold {get; set;}
    public Sales_Activity_Row__c ordPending {get; set;}
    public Sales_Activity_Row__c totalOppty {get; private set;}
    public Sales_Activity_Row__c avgOrderAmt {get; private set;}
    public Sales_Activity_Row__c earnOppty {get; private set;}
    
    public List<MyBusinessRowWrapper> myPerfRows {get; set;}
    public Sales_Org_Activity__c currRec {get; private set;}
    public Sales_Org_Leadership__c ldrshipInfo {get; private set;}
    public Sales_Org_Ldrship_MktTags__c ldrshipInfoMktTags {get; private set;}
        
    public Market__c market {get; private set;}
    //private static Map<String,String> EARN_OPPTY_MAPPING;
    private static List<Market_Activity_Config__c> KEY_INFO_1_MAPPING = new List<Market_Activity_Config__c>();
    private static List<Market_Analysis_Config__c> KEY_INFO_2_MAPPING = new List<Market_Analysis_Config__c>();
    private MarketTagUtils mktTags;
    private MarketLeaderTitleUtils ldrTitlUtils ;
    public List<SalesOrgActivityRowWrapper> activityRows {get; set;}
    public List<SalesOrgActivityRowWrapper> keyInfoRows {get; set;}
    
    
    static{
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Award Sales - Leaders',
                                                            Data_Type__c='Currency',
                                                            Current_Campaign_Fld__c='LDRSHP_AWRD_SLS_AMT__c',
                                                            Is_Market_Tag__c=false));
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Award Sales - Non-Leaders',
                                                            Data_Type__c='Currency',
                                                            Current_Campaign_Fld__c='TRAD_AWRD_SLS_AMT__c',
                                                            Is_Market_Tag__c=false));
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Award Sales - Total',
                                                            Data_Type__c='Currency',
                                                            Current_Campaign_Fld__c='LDRSHP_AWRD_SLS_AMT__c'+'\n'+'TRAD_AWRD_SLS_AMT__c',
                                                            Is_Market_Tag__c=false));
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Average Order - Total',
                                                            Data_Type__c='Currency',
                                                            Current_Campaign_Fld__c='AVG_ORD_AMT__c',
                                                            Is_Market_Tag__c=false));
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Customers Served - Total',
                                                                Data_Type__c='Number',
                                                                Current_Campaign_Fld__c='CUST_CNT__c'));
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Average Customer Served - Total',
                                                            Data_Type__c='Number',
                                                            Current_Campaign_Fld__c='AVG_CUST_CNT__c',
                                                            Is_Market_Tag__c=false));
        KEY_INFO_1_MAPPING.add(new Market_Activity_Config__c(Row_Type__c='Average Customer Purchase - Total',
                                                                Data_Type__c='Currency',
                                                                Current_Campaign_Fld__c='AVG_PER_ORD_CUST_AMT__c',
                                                            Is_Market_Tag__c=false));
        KEY_INFO_2_MAPPING.add(new Market_Analysis_Config__c(Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                             Row_Type__c='UQ',Data_Type__c='Number',
                                                             Col1_Fld__c='IN_ZONE_UQ_TITL_1_STF_CNT__c'+'\n' +'OUT_ZONE_UQ_TITL_1_STF_CNT__c'));
        KEY_INFO_2_MAPPING.add(new Market_Analysis_Config__c(Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                             Row_Type__c='0',Data_Type__c='Number',
                                                             Col1_Fld__c='IN_ZONE_TITL_1_STF_CNT__c'+'\n' +'OUT_ZONE_TITL_1_STF_CNT__c'));
        KEY_INFO_2_MAPPING.add(new Market_Analysis_Config__c(Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                             Row_Type__c='1',Data_Type__c='Number',
                                                             Col1_Fld__c='IN_ZONE_TITL_2_STF_CNT__c'+'\n' +'OUT_ZONE_TITL_2_STF_CNT__c'));
        KEY_INFO_2_MAPPING.add(new Market_Analysis_Config__c(Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                             Row_Type__c='2',Data_Type__c='Number',
                                                             Col1_Fld__c='IN_ZONE_TITL_3_STF_CNT__c'+'\n' +'OUT_ZONE_TITL_3_STF_CNT__c'));
        KEY_INFO_2_MAPPING.add(new Market_Analysis_Config__c(Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                             Row_Type__c='3',Data_Type__c='Number',
                                                             Col1_Fld__c='IN_ZONE_TITL_4_STF_CNT__c'+'\n' +'OUT_ZONE_TITL_4_STF_CNT__c'));
        KEY_INFO_2_MAPPING.add(new Market_Analysis_Config__c(Is_Market_Tag__c=false,Is_Title_Tag__c=true,
                                                             Row_Type__c='4',Data_Type__c='Number',
                                                             Col1_Fld__c='IN_ZONE_TITL_5_STF_CNT__c'+'\n' +'OUT_ZONE_TITL_5_STF_CNT__c'));

    }
    public PageReference init(){
        User currUsr = [select  Id,DFALT_ZONE_CD__c,DFALT_DIV_NM__c,
                                MRKT_ID__c,LanguageLocaleKey
                        from    User
                        where   Id=:UserInfo.getUserId()];
        Profile usrProfile = [  select  Id,Name
                                from    Profile
                                where   Id=:UserInfo.getProfileId()
                            ];
       String key; 
        this.market = [      Select  Mkt_Actvty_Plan_Enabled__c
                From   Market__c  
                where  Market_Id__c =:currUsr.MRKT_ID__c];     
           
        if(usrProfile.Name == 'Avon Zone Manager'){
            key = currUsr.MRKT_ID__c+'Z'+currUsr.DFALT_ZONE_CD__c;
        }else if(usrProfile.Name == 'Avon Division Manager'){
            if(currUsr.DFALT_ZONE_CD__c==null){
                key = currUsr.MRKT_ID__c+'D'+currUsr.DFALT_DIV_NM__c;
            }else{
                key = currUsr.MRKT_ID__c+'Z'+currUsr.DFALT_ZONE_CD__c;
            }
            
        }

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
                            CurrencyIsoCode,CC_AVG_ORD_CNT__c 
                    from    Sales_Org_Activity__c
                    where   MRKT_ID_ZONE_CD_KEY__c =:key
                                        
                    ];

        this.ldrshipInfo = [ Select
                            ZONE_MGR_STF_CNT__c,TITL_4_BAD_DEBT_AMT__c,TITL_1_BRTHDY_CNT__c,PC_LDRSHP_WK3_MULT_ORD__c,LDRSHP_RTURN_CNT__c,
                            ZONE_MGR_STF_CHNG_PCT__c,TITL_4_AWRD_SLS_AMT__c,TITL_1_BAL_DUE_AMT__c,PC_LDRSHP_WK2_MULT_ORD__c,LDRSHP_PEND_ORD_CNT__c,
                            ZONE_MGR_RNSTMT_CNT__c,TITL_4_AVG_ORD_AMT__c,TITL_1_BAD_DEBT_AMT__c,PC_LDRSHP_WK1_MULT_ORD__c,LDRSHP_INVCD_ORD_CNT__c,
                            ZONE_MGR_RMOVL_CNT__c,TITL_4_APPT_CNT__c,TITL_1_AWRD_SLS_AMT__c,PC_LDRSHP_UPLN_CNT__c,LDRSHP_DEMO_ITEM_CNT__c,
                            ZONE_MGR_APPT_CNT__c,TITL_4_ANNIV_CNT__c,TITL_1_AVG_ORD_AMT__c,PC_LDRSHP_UND_MIN_CNT__c,LDRSHP_CUST_CNT__c,
                            UQ_TITL_1_WO_TOP_SLR_TITL_CNT__c,TITL_4_ACTVTY_PCT__c,TITL_1_APPT_CNT__c,PC_LDRSHP_TITL_PROMTD_CNT__c,LDRSHP_BRCHR_CNT__c,
                            UQ_TITL_1_WO_PATD_CNT__c,TITL_4_ABV_MIN_CNT__c,TITL_1_ANNIV_CNT__c,PC_LDRSHP_TITL_DMTD_CNT__c,IsDeleted,
                            UQ_TITL_1_UPLN_CNT__c,TITL_3_WO_TOP_SLR_TITL_CNT__c,TITL_1_ACTVTY_PCT__c,PC_LDRSHP_SLS_AIDS_CNT__c,Id,
                            UQ_TITL_1_UND_MIN_CNT__c,TITL_3_WO_PATD_CNT__c,TITL_1_ABV_MIN_CNT__c,PC_LDRSHP_RTURN_CNT__c,IN_ZONE_UQ_TITL_1_STF_CNT__c,
                            UQ_TITL_1_TOP_SLR_CNT__c,TITL_3_UPLN_CNT__c,SystemModstamp,PC_LDRSHP_RTURN_AMT__c,IN_ZONE_TITL_5_STF_CNT__c,
                            UQ_TITL_1_TITL_PROMTD_CNT__c,TITL_3_UND_MIN_CNT__c,SPPY_OUT_ZONE_LDRSHP_STF_CNT__c,PC_LDRSHP_RNSTMT_CNT__c,IN_ZONE_TITL_4_STF_CNT__c,
                            UQ_TITL_1_TITL_DMTD_CNT__c,TITL_3_TOP_SLR_CNT__c,SPPY_LDRSHP_UPLN_CNT__c,PC_LDRSHP_RMOVL_CNT__c,IN_ZONE_TITL_3_STF_CNT__c,
                            UQ_TITL_1_STF_CNT__c,TITL_3_TITL_PROMTD_CNT__c,SPPY_LDRSHP_UND_MIN_CNT__c,PC_LDRSHP_PEND_ORD_CNT__c,IN_ZONE_TITL_2_STF_CNT__c,
                            UQ_TITL_1_STF_CHNG_PCT__c,TITL_3_TITL_DMTD_CNT__c,SPPY_LDRSHP_TITL_PROMTD_CNT__c,PC_LDRSHP_PAST_DUE_AMT__c,IN_ZONE_TITL_1_STF_CNT__c,
                            UQ_TITL_1_RTURN_AMT__c,TITL_3_STF_CNT__c,SPPY_LDRSHP_TITL_DMTD_CNT__c,PC_LDRSHP_OUT_ZONE_STF_CNT__c,IN_ZONE_DWNLN_NON_LDR_STF_CNT__c,
                            UQ_TITL_1_RNSTMT_CNT__c,TITL_3_STF_CHNG_PCT__c,SPPY_LDRSHP_RTURN_AMT__c,PC_LDRSHP_ORD_CNT__c,INACTV_3_CMPGN_UQ_TITL_1_CNT__c,
                            UQ_TITL_1_RMOVL_CNT__c,TITL_3_RTURN_AMT__c,SPPY_LDRSHP_RNSTMT_CNT__c,PC_LDRSHP_ORD_AVG_CUST_CNT__c,INACTV_3_CMPGN_TITL_5_CNT__c,
                            UQ_TITL_1_PTNTL_ERNGS_AMT__c,TITL_3_RNSTMT_CNT__c,SPPY_LDRSHP_RMOVL_CNT__c,PC_LDRSHP_NO_ORD_CNT__c,INACTV_3_CMPGN_TITL_4_CNT__c,
                            UQ_TITL_1_PEND_ORD_CNT__c,TITL_3_RMOVL_CNT__c,SPPY_LDRSHP_PTNTL_ERNGS_AMT__c,PC_LDRSHP_NET_SLS_AMT__c,INACTV_3_CMPGN_TITL_3_CNT__c,
                            UQ_TITL_1_PATD_CNT__c,TITL_3_PTNTL_ERNGS_AMT__c,SPPY_LDRSHP_PAST_DUE_AMT__c,PC_LDRSHP_MULT_ORD_CNT__c,INACTV_3_CMPGN_TITL_2_CNT__c,
                            UQ_TITL_1_PAST_DUE_AMT__c,TITL_3_PEND_ORD_CNT__c,SPPY_LDRSHP_ORD_AVG_CUST_CNT__c,PC_LDRSHP_INVCD_ORD_CNT__c,INACTV_3_CMPGN_TITL_1_CNT__c,
                            UQ_TITL_1_ORD_CNT__c,TITL_3_PATD_CNT__c,SPPY_LDRSHP_NO_ORD_CNT__c,PC_LDRSHP_HOLD_ORD_CNT__c,INACTV_3_CMPGN_NON_LDRSHP_CNT__c,
                            UQ_TITL_1_ORD_AVG_CUST_CNT__c,TITL_3_PAST_DUE_AMT__c,SPPY_LDRSHP_NET_SLS_AMT__c,PC_LDRSHP_FRST_ORD_CNT__c,INACTV_3_CMPGN_DWNLN_NON_LDR_C__c,
                            UQ_TITL_1_NO_ORD_CNT__c,TITL_3_ORD_CNT__c,SPPY_LDRSHP_MULT_ORD_CNT__c,PC_LDRSHP_ERNGS_AMT__c,INACTV_2_CMPGN_UQ_TITL_1_CNT__c,
                            UQ_TITL_1_NET_SLS_AMT__c,TITL_3_ORD_AVG_CUST_CNT__c,SPPY_LDRSHP_HOLD_ORD_CNT__c,PC_LDRSHP_DEMO_ITEM_CNT__c,INACTV_2_CMPGN_TITL_5_CNT__c,
                            UQ_TITL_1_MULT_ORD_CNT__c,TITL_3_NO_ORD_CNT__c,SPPY_LDRSHP_FRST_ORD_CNT__c,PC_LDRSHP_CUST_CNT__c,INACTV_2_CMPGN_TITL_4_CNT__c,
                            UQ_TITL_1_HOLD_ORD_CNT__c,TITL_3_NET_SLS_AMT__c,SPPY_LDRSHP_ERNGS_AMT__c,PC_LDRSHP_BRCHR_CNT__c,INACTV_2_CMPGN_TITL_3_CNT__c,
                            UQ_TITL_1_GRP_PD_SLS_AMT__c,TITL_3_MULT_ORD_CNT__c,SPPY_LDRSHP_AWRD_SLS_AMT__c,PC_LDRSHP_AWRD_SLS_AMT__c,INACTV_2_CMPGN_TITL_2_CNT__c,
                            UQ_TITL_1_GRP_ABV_QLFR_CNT__c,TITL_3_HOLD_ORD_CNT__c,SPPY_LDRSHP_AVG_ORD_AMT__c,PC_LDRSHP_AVG_ORD_AMT__c,INACTV_2_CMPGN_TITL_1_CNT__c,
                            UQ_TITL_1_FRST_ORD_CNT__c,TITL_3_GRP_PD_SLS_AMT__c,SPPY_LDRSHP_APPT_CNT__c,PC_LDRSHP_APPT_CNT__c,INACTV_2_CMPGN_NON_LDRSHP_CNT__c,
                            UQ_TITL_1_BRTHDY_CNT__c,TITL_3_GRP_ABV_QLFR_CNT__c,SPPY_LDRSHP_ABV_MIN_CNT__c,PC_LDRSHP_ABV_MIN_CNT__c,INACTV_2_CMPGN_DWNLN_NON_LDR_C__c,
                            UQ_TITL_1_BAL_DUE_AMT__c,TITL_3_FRST_ORD_CNT__c,SPPY_IN_ZONE_LDRSHP_STF_CNT__c,PC_IN_ZONE_LDRSHP_STF_CNT__c,INACTV_1_CMPGN_UQ_TITL_1_CNT__c,
                            UQ_TITL_1_BAD_DEBT_AMT__c,TITL_3_BRTHDY_CNT__c,SPPY_GRP_PD_SLS_AMT__c,PC_GRP_PD_SLS_AMT__c,INACTV_1_CMPGN_TITL_5_CNT__c,
                            UQ_TITL_1_AWRD_SLS_AMT__c,TITL_3_BAL_DUE_AMT__c,SPPY_ACTVTY_PCT__c,PC_DWNLN_NON_LDR_AWRD_SLS_AMT__c,INACTV_1_CMPGN_TITL_4_CNT__c,
                            UQ_TITL_1_AVG_ORD_AMT__c,TITL_3_BAD_DEBT_AMT__c,SLS_ORG_NM__c,PC_BLW_MIN_LDRSHP_AWRD_SLS_AMT__c,INACTV_1_CMPGN_TITL_3_CNT__c,
                            UQ_TITL_1_APPT_CNT__c,TITL_3_AWRD_SLS_AMT__c,SLS_ORG_LVL_NR__c,PC_AVG_MULT_ORD_AMT__c,INACTV_1_CMPGN_TITL_2_CNT__c,
                            UQ_TITL_1_ANNIV_CNT__c,TITL_3_AVG_ORD_AMT__c,SLS_ORG_CD__c,PC_ACTVTY_PCT__c,INACTV_1_CMPGN_TITL_1_CNT__c,
                            UQ_TITL_1_ACTVTY_PCT__c,TITL_3_APPT_CNT__c,PREV_CMPGN_AVG_CUST_CNT__c,OwnerId,INACTV_1_CMPGN_NON_LDRSHP_CNT__c,
                            UQ_TITL_1_ABV_MIN_CNT__c,TITL_3_ANNIV_CNT__c,PLAN_OUT_ZONE_LDRSHP_STF_CNT__c,OUT_ZONE_UQ_TITL_1_STF_CNT__c,INACTV_1_CMPGN_DWNLN_NON_LDR_C__c,
                            TITL_5_WO_TOP_SLR_TITL_CNT__c,TITL_3_ACTVTY_PCT__c,PLAN_NON_LDRSHP_NET_SLS_AMT__c,OUT_ZONE_TITL_5_STF_CNT__c,DWNLN_NON_LDR_WO_TOP_SLR_CNT__c,
                            TITL_5_WO_PATD_CNT__c,TITL_3_ABV_MIN_CNT__c,PLAN_LDRSHP_UPLN_CNT__c,OUT_ZONE_TITL_4_STF_CNT__c,DWNLN_NON_LDR_UND_MIN_CNT__c,
                            TITL_5_UPLN_CNT__c,TITL_2_WO_TOP_SLR_TITL_CNT__c,PLAN_LDRSHP_UND_MIN_AMT__c,OUT_ZONE_TITL_3_STF_CNT__c,DWNLN_NON_LDR_TOP_SLR_CNT__c,
                            TITL_5_UND_MIN_CNT__c,TITL_2_WO_PATD_CNT__c,PLAN_LDRSHP_TITL_PROMTD_CNT__c,OUT_ZONE_TITL_2_STF_CNT__c,DWNLN_NON_LDR_RTURN_AMT__c,
                            TITL_5_TOP_SLR_CNT__c,TITL_2_UPLN_CNT__c,PLAN_LDRSHP_TITL_DMTD_CNT__c,OUT_ZONE_TITL_1_STF_CNT__c,DWNLN_NON_LDR_RNSTMT_CNT__c,
                            TITL_5_TITL_PROMTD_CNT__c,TITL_2_UND_MIN_CNT__c,PLAN_LDRSHP_RTURN_AMT__c,OUT_ZONE_DWNLN_NON_LDR_STF_CNT__c,DWNLN_NON_LDR_RMOVL_CNT__c,
                            TITL_5_TITL_DMTD_CNT__c,TITL_2_TOP_SLR_CNT__c,PLAN_LDRSHP_RNSTMT_CNT__c,OPERTNL_CMPGN_NR__c,DWNLN_NON_LDR_PAST_DUE_AMT__c,
                            TITL_5_STF_CNT__c,TITL_2_TITL_PROMTD_CNT__c,PLAN_LDRSHP_RMOVL_CNT__c,Name,DWNLN_NON_LDR_ORD_CNT__c,
                            TITL_5_STF_CHNG_PCT__c,TITL_2_TITL_DMTD_CNT__c,PLAN_LDRSHP_PTNTL_ERNGS_AMT__c,NON_LDRSHP_WO_TOP_SLR_CNT__c,DWNLN_NON_LDR_NO_ORD_CNT__c,
                            TITL_5_RTURN_AMT__c,TITL_2_STF_CNT__c,PLAN_LDRSHP_PAST_DUE_AMT__c,NON_LDRSHP_WK3_MULT_ORD_CNT__c,DWNLN_NON_LDR_NET_SLS_AMT__c,
                            TITL_5_RNSTMT_CNT__c,TITL_2_STF_CHNG_PCT__c,PLAN_LDRSHP_ORD_AVG_CUST_CNT__c,NON_LDRSHP_WK2_MULT_ORD_CNT__c,DWNLN_NON_LDR_MULT_ORD_CNT__c,
                            TITL_5_RMOVL_CNT__c,TITL_2_RTURN_AMT__c,PLAN_LDRSHP_NO_ORD_CNT__c,NON_LDRSHP_WK1_MULT_ORD_CNT__c,DWNLN_NON_LDR_HOLD_ORD_CNT__c,
                            TITL_5_PTNTL_ERNGS_AMT__c,TITL_2_RNSTMT_CNT__c,PLAN_LDRSHP_NET_SLS_AMT__c,NON_LDRSHP_UND_MIN_CNT__c,DWNLN_NON_LDR_GRP_PD_SLS_AMT__c,
                            TITL_5_PEND_ORD_CNT__c,TITL_2_RMOVL_CNT__c,PLAN_LDRSHP_MULT_ORD_CNT__c,NON_LDRSHP_TOP_SLR_CNT__c,DWNLN_NON_LDR_FRST_ORD_CNT__c,
                            TITL_5_PATD_CNT__c,TITL_2_PTNTL_ERNGS_AMT__c,PLAN_LDRSHP_HOLD_ORD_CNT__c,NON_LDRSHP_STF_CNT__c,DWNLN_NON_LDR_BAL_DUE_AMT__c,
                            TITL_5_PAST_DUE_AMT__c,TITL_2_PEND_ORD_CNT__c,PLAN_LDRSHP_GRP_PD_SLS_AMT__c,NON_LDRSHP_RTURN_CNT__c,DWNLN_NON_LDR_BAD_DEBT_AMT__c,
                            TITL_5_ORD_CNT__c,TITL_2_PATD_CNT__c,PLAN_LDRSHP_FRST_ORD_CNT__c,NON_LDRSHP_PEND_ORD_CNT__c,DWNLN_NON_LDR_AWRD_SLS_AMT__c,
                            TITL_5_ORD_AVG_CUST_CNT__c,TITL_2_PAST_DUE_AMT__c,PLAN_LDRSHP_ERNGS_AMT__c,NON_LDRSHP_PAST_DUE_AMT__c,DWNLN_NON_LDR_AVG_CUST_CNT__c,
                            TITL_5_NO_ORD_CNT__c,TITL_2_ORD_CNT__c,PLAN_LDRSHP_AWRD_SLS_AMT__c,NON_LDRSHP_ORD_CNT__c,DWNLN_NON_LDR_APPT_CNT__c,
                            TITL_5_NET_SLS_AMT__c,TITL_2_ORD_AVG_CUST_CNT__c,PLAN_LDRSHP_AVG_ORD_AMT__c,NON_LDRSHP_NO_ORD_CNT__c,DWNLN_NON_LDR_ACTVTY_PCT__c,
                            TITL_5_MULT_ORD_CNT__c,TITL_2_NO_ORD_CNT__c,PLAN_LDRSHP_APPT_CNT__c,NON_LDRSHP_NET_SLS_AMT__c,DWNLN_NON_LDR_ABV_MIN_CNT__c,
                            TITL_5_HOLD_ORD_CNT__c,TITL_2_NET_SLS_AMT__c,PLAN_LDRSHP_ACTVTY_PCT__c,NON_LDRSHP_MULT_ORD_CNT__c,CurrencyIsoCode,
                            TITL_5_GRP_PD_SLS_AMT__c,TITL_2_MULT_ORD_CNT__c,PLAN_LDRSHP_ABV_MIN_CNT__c,NON_LDRSHP_HOLD_ORD_CNT__c,CreatedDate,
                            TITL_5_GRP_ABV_QLFR_CNT__c,TITL_2_HOLD_ORD_CNT__c,PLAN_IN_ZONE_LDRSHP_STF_CNT__c,NON_LDRSHP_CUST_CNT__c,CreatedById,
                            TITL_5_FRST_ORD_CNT__c,TITL_2_GRP_PD_SLS_AMT__c,PLAN_AVG_ORD_AMT__c,NON_LDRSHP_BRTHDY_CNT__c,BLW_MIN_LDRSHP_AWRD_SLS_AMT__c,
                            TITL_5_BRTHDY_CNT__c,TITL_2_GRP_ABV_QLFR_CNT__c,PC_ZONE_MGR_STF_CNT__c,NON_LDRSHP_BAL_DUE_AMT__c,AVG_ORD_AMT__c,
                            TITL_5_BAL_DUE_AMT__c,TITL_2_FRST_ORD_CNT__c,PC_UQ_TITL_1_TAR_CNT__c,NON_LDRSHP_BAD_DEBT_AMT__c,AVG_MULT_ORD_AMT__c,
                            TITL_5_BAD_DEBT_AMT__c,TITL_2_BRTHDY_CNT__c,PC_UQ_TITL_1_ERNGS_AMT__c,NON_LDRSHP_AWRD_SLS_AMT__c,AVG_CUST_CNT__c,
                            TITL_5_AWRD_SLS_AMT__c,TITL_2_BAL_DUE_AMT__c,PC_UQ_TITL_1_CTT_CNT__c,NON_LDRSHP_ANNIV_CNT__c,ACTVTY_PCT__c,
                            TITL_5_AVG_ORD_AMT__c,TITL_2_BAD_DEBT_AMT__c,PC_UQ_TITL_1_AWRD_SLS_AMT__c,NON_LDRSHP_ABV_MIN_CNT__c,
                            TITL_5_APPT_CNT__c,TITL_2_AWRD_SLS_AMT__c,PC_TITL_5_TAR_CNT__c,NC_OUT_ZONE_LDRSHP_STF_CNT__c,
                            TITL_5_ANNIV_CNT__c,TITL_2_AVG_ORD_AMT__c,PC_TITL_5_ERNGS_AMT__c,NC_LDRSHP_UPLN_CNT__c,
                            TITL_5_ACTVTY_PCT__c,TITL_2_APPT_CNT__c,PC_TITL_5_CTT_CNT__c,NC_LDRSHP_UND_MIN_CNT__c,
                            TITL_5_ABV_MIN_CNT__c,TITL_2_ANNIV_CNT__c,PC_TITL_5_AWRD_SLS_AMT__c,NC_LDRSHP_TITL_PROMTD_CNT__c,
                            TITL_4_WO_TOP_SLR_TITL_CNT__c,TITL_2_ACTVTY_PCT__c,PC_TITL_4_TAR_CNT__c,NC_LDRSHP_TITL_DMTD_CNT__c,
                            TITL_4_WO_PATD_CNT__c,TITL_2_ABV_MIN_CNT__c,PC_TITL_4_ERNGS_AMT__c,NC_LDRSHP_RTURN_AMT__c,
                            TITL_4_UPLN_CNT__c,TITL_1_WO_TOP_SLR_TITL_CNT__c,PC_TITL_4_CTT_CNT__c,NC_LDRSHP_RNSTMT_CNT__c,
                            TITL_4_UND_MIN_CNT__c,TITL_1_WO_PATD_CNT__c,PC_TITL_4_AWRD_SLS_AMT__c,NC_LDRSHP_RMOVL_CNT__c,
                            TITL_4_TOP_SLR_CNT__c,TITL_1_UPLN_CNT__c,PC_TITL_3_TAR_CNT__c,NC_LDRSHP_PAST_DUE_AMT__c,
                            TITL_4_TITL_PROMTD_CNT__c,TITL_1_UND_MIN_CNT__c,PC_TITL_3_ERNGS_AMT__c,NC_LDRSHP_ORD_AVG_CUST_CNT__c,
                            TITL_4_TITL_DMTD_CNT__c,TITL_1_TOP_SLR_CNT__c,PC_TITL_3_CTT_CNT__c,NC_LDRSHP_NO_ORD_CNT__c,
                            TITL_4_STF_CNT__c,TITL_1_TITL_PROMTD_CNT__c,PC_TITL_3_AWRD_SLS_AMT__c,NC_LDRSHP_NET_SLS_AMT__c,
                            TITL_4_STF_CHNG_PCT__c,TITL_1_TITL_DMTD_CNT__c,PC_TITL_2_TAR_CNT__c,NC_LDRSHP_MULT_ORD_CNT__c,
                            TITL_4_RTURN_AMT__c,TITL_1_STF_CNT__c,PC_TITL_2_ERNGS_AMT__c,NC_LDRSHP_HOLD_ORD_CNT__c,
                            TITL_4_RNSTMT_CNT__c,TITL_1_STF_CHNG_PCT__c,PC_TITL_2_CTT_CNT__c,NC_LDRSHP_FRST_ORD_CNT__c,
                            TITL_4_RMOVL_CNT__c,TITL_1_RTURN_AMT__c,PC_TITL_2_AWRD_SLS_AMT__c,NC_LDRSHP_AWRD_SLS_AMT__c,
                            TITL_4_PTNTL_ERNGS_AMT__c,TITL_1_RNSTMT_CNT__c,PC_TITL_1_TAR_CNT__c,NC_LDRSHP_AVG_ORD_AMT__c,
                            TITL_4_PEND_ORD_CNT__c,TITL_1_RMOVL_CNT__c,PC_TITL_1_ERNGS_AMT__c,NC_LDRSHP_APPT_CNT__c,
                            TITL_4_PATD_CNT__c,TITL_1_PTNTL_ERNGS_AMT__c,PC_TITL_1_CTT_CNT__c,NC_LDRSHP_ABV_MIN_CNT__c,
                            TITL_4_PAST_DUE_AMT__c,TITL_1_PEND_ORD_CNT__c,PC_TITL_1_AWRD_SLS_AMT__c,NC_IN_ZONE_LDRSHP_STF_CNT__c,
                            TITL_4_ORD_CNT__c,TITL_1_PATD_CNT__c,PC_NON_LDRSHP_WK3_MULT_ORD_CNT__c,NC_GRP_PD_SLS_AMT__c,
                            TITL_4_ORD_AVG_CUST_CNT__c,TITL_1_PAST_DUE_AMT__c,PC_NON_LDRSHP_WK2_MULT_ORD_CNT__c,NC_ACTVTY_PCT__c,
                            TITL_4_NO_ORD_CNT__c,TITL_1_ORD_CNT__c,PC_NON_LDRSHP_WK1_MULT_ORD_CNT__c,MRKT_ID__c,
                            TITL_4_NET_SLS_AMT__c,TITL_1_ORD_AVG_CUST_CNT__c,PC_NON_LDRSHP_RTURN_CNT__c,MRKT_ID_ZONE_CD_KEY__c,
                            TITL_4_MULT_ORD_CNT__c,TITL_1_NO_ORD_CNT__c,PC_NON_LDRSHP_PENDNG_ORD_CNT__c,LastModifiedDate,
                            TITL_4_HOLD_ORD_CNT__c,TITL_1_NET_SLS_AMT__c,PC_NON_LDRSHP_ORD_CNT__c,LastModifiedById,
                            TITL_4_GRP_PD_SLS_AMT__c,TITL_1_MULT_ORD_CNT__c,PC_NON_LDRSHP_NO_ORD_CNT__c,LRDSHP_WK4_MULT_ORD_CNT__c,
                            TITL_4_GRP_ABV_QLFR_CNT__c,TITL_1_HOLD_ORD_CNT__c,PC_NON_LDRSHP_MULT_ORD_CNT__c,LDRSHP_WK3_MULT_ORD_CNT__c,
                            TITL_4_FRST_ORD_CNT__c,TITL_1_GRP_PD_SLS_AMT__c,PC_NON_LDRSHP_HOLD_ORD_CNT__c,LDRSHP_WK2_MULT_ORD_CNT__c,
                            TITL_4_BRTHDY_CNT__c,TITL_1_GRP_ABV_QLFR_CNT__c,PC_NON_LDRSHP_AWRD_SLS_AMT__c,LDRSHP_WK1_MULT_ORD_CNT__c,
                            TITL_4_BAL_DUE_AMT__c,TITL_1_FRST_ORD_CNT__c,PC_LDRSHP_WK4_MULT_ORD_CNT__c,LDRSHP_SLS_AIDS_CNT__c,
                            PC_NON_LDRSHP_PEND_ORD_CNT__c,CC_EMPTY_FLD__c
                    From    Sales_Org_Leadership__c s
                    where   MRKT_ID_ZONE_CD_KEY__c =:key
                                        
                    ];
                    
            this.ldrshipInfoMktTags = [
                Select 
                        UQ_TITL_1_MRKT_TAG_4_PCT__c,
                        UQ_TITL_1_MRKT_TAG_3_TXT__c,
                        UQ_TITL_1_MRKT_TAG_2_TXT__c,
                        UQ_TITL_1_MRKT_TAG_1_AMT__c,
                        TITL_5_MRKT_TAG_4_PCT__c,
                        TITL_5_MRKT_TAG_2_TXT__c,
                        TITL_5_MRKT_TAG_1_AMT__c,
                        TITL_4_MRKT_TAG_4_PCT__c,
                        TITL_4_MRKT_TAG_2_TXT__c,
                        TITL_4_MRKT_TAG_1_AMT__c,
                        TITL_3_MRKT_TAG_4_PCT__c,
                        TITL_3_MRKT_TAG_2_TXT__c,
                        TITL_3_MRKT_TAG_1_AMT__c,
                        TITL_2_MRKT_TAG_4_PCT__c,
                        TITL_2_MRKT_TAG_2_TXT__c,
                        TITL_2_MRKT_TAG_1_AMT__c,
                        TITL_1_MRKT_TAG_4_PCT__c,
                        TITL_1_MRKT_TAG_2_TXT__c,
                        TITL_1_MRKT_TAG_1_AMT__c,
                        SystemModstamp,
                        SPPY_LDRSHP_MRKT_TAG_4_PCT__c,
                        SPPY_LDRSHP_MRKT_TAG_3_TXT__c,
                        SPPY_LDRSHP_MRKT_TAG_2_TXT__c,
                        SPPY_LDRSHP_MRKT_TAG_1_AMT__c,
                        SLS_ORG_NM__c,
                        SLS_ORG_LVL_NR__c,
                        SLS_ORG_CD__c,
                        SLS_MRKT_TAG_4_TXT__c,
                        SLS_MRKT_TAG_3_PCT__c,
                        SLS_MRKT_TAG_2_NR__c,
                        SLS_MRKT_TAG_1_AMT__c,
                        PLAN_LDRSHP_MRKT_TAG_4_PCT__c,
                        PLAN_LDRSHP_MRKT_TAG_3_TXT__c,
                        PLAN_LDRSHP_MRKT_TAG_2_TXT__c,
                        PLAN_LDRSHP_MRKT_TAG_1_AMT__c,
                        PC_SLS_MRKT_TAG_4_TXT__c,
                        PC_SLS_MRKT_TAG_3_PCT__c,
                        PC_SLS_MRKT_TAG_2_NR__c,
                        PC_SLS_MRKT_TAG_1_AMT__c,
                        PC_ORD_MRKT_TAG_4_TXT__c,
                        PC_ORD_MRKT_TAG_3_PCT__c,
                        PC_ORD_MRKT_TAG_2_NR__c,
                        PC_ORD_MRKT_TAG_1_AMT__c,
                        PC_LDRSHP_MRKT_TAG_4_PCT__c,
                        PC_LDRSHP_MRKT_TAG_3_TXT__c,
                        PC_LDRSHP_MRKT_TAG_2_TXT__c,
                        PC_LDRSHP_MRKT_TAG_1_AMT__c,
                        PC_BUS_MRKT_TAG_4_TXT__c,
                        PC_BUS_MRKT_TAG_3_PCT__c,
                        PC_BUS_MRKT_TAG_2_NR__c,
                        PC_BUS_MRKT_TAG_1_AMT__c,
                        OwnerId,
                        ORD_MRKT_TAG_4_TXT__c,
                        ORD_MRKT_TAG_3_PCT__c,
                        ORD_MRKT_TAG_2_NR__c,
                        ORD_MRKT_TAG_1_AMT__c,
                        OPERTNL_CMPGN_NR__c,
                        Name,
                        NC_LDRSHP_MRKT_TAG_4_PCT__c,
                        NC_LDRSHP_MRKT_TAG_3_TXT__c,
                        NC_LDRSHP_MRKT_TAG_2_TXT__c,
                        NC_LDRSHP_MRKT_TAG_1_AMT__c,
                        MRKT_ID__c,
                        MRKT_ID_ZONE_CD_KEY__c,
                        LastModifiedDate,
                        LastModifiedById,
                        LDRSHP_TITL_5_MRKT_TAG_3_TXT__c,
                        LDRSHP_TITL_4_MRKT_TAG_3_TXT__c,
                        LDRSHP_TITL_3_MRKT_TAG_3_TXT__c,
                        LDRSHP_TITL_2_MRKT_TAG_3_TXT__c,
                        LDRSHP_TITL_1_MRKT_TAG_3_TXT__c,
                        LDRSHP_MRKT_TAG_3_TXT__c,
                        LDRSHP_MRKT_TAG_2_TXT__c,
                        IsDeleted,
                        Id,
                        DWNLN_NON_LDR_MRKT_TAG_4_PCT__c,
                        DWNLN_NON_LDR_MRKT_TAG_3_TXT__c,
                        DWNLN_NON_LDR_MRKT_TAG_2_TXT__c,
                        DWNLN_NON_LDR_MRKT_TAG_1_AMT__c,
                        CurrencyIsoCode,
                        CreatedDate,
                        CreatedById,
                        BUS_MRKT_TAG_4_TXT__c,
                        BUS_MRKT_TAG_3_PCT__c,
                        BUS_MRKT_TAG_2_NR__c,
                        BUS_MRKT_TAG_1_AMT__c 
                From    Sales_Org_Ldrship_MktTags__c    
                where   MRKT_ID_ZONE_CD_KEY__c =:key
            ];
                    
                                    
        List<String> mktTagSubjAreas = new List<String>();
        
        mktTagSubjAreas.add('Zone-Market Activity');
        mktTagSubjAreas.add('Zone-Ldr Activity');
        mktTags = new MarketTagUtils();
        mktTags.initialize(mktTagSubjAreas);
        
        this.ldrTitlUtils = new MarketLeaderTitleUtils();
        this.ldrTitlUtils.initialize(currUsr);
        
        Sales_Activity_Row__c currRow;
        SObject sObj = currRec;
        Boolean oddRow=true;
        this.ordNotSub = new Sales_Activity_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode,LDR_CNT__c=0.0,NonLdr_CNT__c=0.0);
        ordNotSub.LDR_CNT__c = getFieldValue(this.currRec,'LDRSHP_NO_ORD_CNT__c');
        ordNotSub.NonLdr_CNT__c = getFieldValue(this.currRec,'TRAD_NO_ORD_CNT__c');
        ordNotSub.CC_CNT__c = ordNotSub.LDR_CNT__C+ ordNotSub.NonLdr_CNT__c;
        
        this.ordOnHold = new Sales_Activity_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode,LDR_CNT__c=0.0,NonLdr_CNT__c=0.0); 
        this.ordOnHold.LDR_CNT__c  = getFieldValue(this.ldrshipInfo,'UQ_TITL_1_HOLD_ORD_CNT__c')+
                                    getFieldValue(this.ldrshipInfo,'TITL_1_HOLD_ORD_CNT__c')+
                                    getFieldValue(this.ldrshipInfo,'TITL_2_HOLD_ORD_CNT__c')+
                                    getFieldValue(this.ldrshipInfo,'TITL_3_HOLD_ORD_CNT__c')+
                                    getFieldValue(this.ldrshipInfo,'TITL_4_HOLD_ORD_CNT__c')+
                                    getFieldValue(this.ldrshipInfo,'TITL_5_HOLD_ORD_CNT__c');                           
        this.ordOnHold.NonLdr_CNT__c = getFieldValue(this.ldrshipInfo,'DWNLN_NON_LDR_HOLD_ORD_CNT__c');
        ordOnHold.CC_CNT__c = ordOnHold.LDR_CNT__C+ ordOnHold.NonLdr_CNT__c;

        this.ordPending = new Sales_Activity_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode,LDR_CNT__c=0.0,NonLdr_CNT__c=0.0); 
        this.ordPending.LDR_CNT__c = getFieldValue(this.ldrshipInfo,'LDRSHP_PEND_ORD_CNT__c');
        this.ordPending.NonLdr_CNT__c = getFieldValue(this.ldrshipInfo,'NON_LDRSHP_PEND_ORD_CNT__c');
        ordPending.CC_CNT__c = ordPending.LDR_CNT__C + ordPending.NonLdr_CNT__c;

        this.avgOrderAmt = new Sales_Activity_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode,LDR_AMT__c=0.0,NonLdr_AMT__c=0.0); 
        this.avgOrderAmt.LDR_AMT__c = getFieldValue(this.currRec,'LDRSHP_AVG_ORD_AMT__c');
        this.avgOrderAmt.NonLdr_AMT__c = getFieldValue(this.currRec,'TRAD_AVG_ORD_AMT__c');
        avgOrderAmt.CC_AMT__c = getFieldValue(this.currRec,'CC_AVG_ORD_CNT__c');
        

        this.totalOppty = new Sales_Activity_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode,LDR_CNT__c=0.0,NonLdr_CNT__c=0.0); 
        this.totalOppty.LDR_CNT__c  =   this.ordNotSub.LDR_CNT__c + 
                                        this.ordOnHold.LDR_CNT__c+
                                        this.ordPending.LDR_CNT__c;
        
        this.totalOppty.NonLdr_CNT__c=  this.ordNotSub.NonLdr_CNT__c + 
                                        this.ordOnHold.NonLdr_CNT__c+
                                        this.ordPending.NonLdr_CNT__c;

        
        totalOppty.CC_CNT__c = totalOppty.LDR_CNT__C + totalOppty.NonLdr_CNT__c;
        

        this.earnOppty = new Sales_Activity_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode,LDR_AMT__c=0.0,NonLdr_AMT__c=0.0);
        this.earnOppty.LDR_AMT__c = this.totalOppty.LDR_CNT__C * this.avgOrderAmt.LDR_AMT__c; 
        this.earnOppty.NonLdr_AMT__c = this.totalOppty.NonLdr_CNT__C * this.avgOrderAmt.NonLdr_AMT__c; 
        earnOppty.CC_AMT__c = earnOppty.LDR_AMT__C + earnOppty.NonLdr_AMT__c;
        List<Market_Activity_Config__c> configList = [Select    Market__c,SPPY_Campaign_Fld__c, Row_Type__c, 
                                                                Prior_Campaign_Fld__c, Next_Campaign_Fld__c, 
                                                                Is_Market_Tag__c, Data_Type__c,Current_Campaign_Fld__c,
                                                                Leadership_Fld__c,NonLeadership_Fld__c,
                                                                Plan_Fld__c
                                                        From    Market_Activity_Config__c 
                                                        where   Market__r.Market_Id__c=:currUsr.MRKT_ID__c
                                                        and     Is_Market_Tag__c=true];


        activityRows = new List<SalesOrgActivityRowWrapper>();
        oddRow = true;
        currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
        currRow.Data_Type__c = 'Currency';
        currRow.Is_Market_Tag__c = false;
        currRow.Row_Label__c = 'Net Sales';
        currRow.Ldr_AMT__c = getFieldValue(currRec,'LDRSHP_NET_SLS_AMT__c');
        currRow.NonLdr_AMT__c = getFieldValue(currRec,'TRAD_NET_SLS_AMT__c');
        currRow.Plan_AMT__c = getFieldValue(currRec,'NET_SLS_PLAN_AMT__c');
        currRow.CC_AMT__c = (currRow.Ldr_AMT__c!=null?currRow.Ldr_AMT__c:0.0) +(currRow.NonLdr_AMT__c!=null?currRow.NonLdr_AMT__c:0.0);
        currRow.PC_AMT__c = (currRow.Plan_AMT__c-currRow.CC_AMT__c);
        activityRows.add(new SalesOrgActivityRowWrapper(currRow,false)); 

        oddRow = !oddRow;
        currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
        currRow.Data_Type__c = 'Currency';
        currRow.Is_Market_Tag__c = false;
        currRow.Row_Label__c = 'Additions';
        currRow.Ldr_AMT__c = getFieldValue(currRec,'LDRSHP_APPT_CNT__c'+'\n'+'LDRSHP_RNSTMT_CNT__c');
        currRow.NonLdr_AMT__c = getFieldValue(currRec,'TRAD_APPT_CNT__c'+'\n'+'TRAD_RNSTMT_CNT__c');
        currRow.Plan_AMT__c = getFieldValue(currRec,'PLAN_APPT_CNT__c');
        currRow.CC_AMT__c = (currRow.Ldr_AMT__c!=null?currRow.Ldr_AMT__c:0.0) +(currRow.NonLdr_AMT__c!=null?currRow.NonLdr_AMT__c:0.0);
        currRow.PC_AMT__c = (currRow.Plan_AMT__c-currRow.CC_AMT__c );
        activityRows.add(new SalesOrgActivityRowWrapper(currRow,false)); 
                                                        
        oddRow = !oddRow;
        currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
        currRow.Data_Type__c = 'Currency';
        currRow.Is_Market_Tag__c = false;
        currRow.Row_Label__c = 'Average Order';
        currRow.Plan_AMT__c = getFieldValue(currRec,'PLAN_AVG_ORD_AMT__c');
        currRow.CC_AMT__c = getFieldValue(currRec,'AVG_ORD_AMT__c');
        currRow.PC_AMT__c = (currRow.Plan_AMT__c-currRow.CC_AMT__c);
        activityRows.add(new SalesOrgActivityRowWrapper(currRow,false)); 

        for(Market_Activity_Config__c cfg: configList){
            currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
            currRow.Data_Type__c = cfg.Data_Type__c;
            currRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
            currRow.Row_Label__c = mktTags.getLabel('Zone-Market Activity',cfg.Row_Type__c);
            if(cfg.Data_Type__c == 'Currency'){
                if(cfg.Leadership_Fld__c!=null) currRow.Ldr_AMT__c = getFieldValue(currRec,cfg.Leadership_Fld__c);
                if(cfg.NonLeadership_Fld__c!=null) currRow.NonLdr_AMT__c = getFieldValue(currRec,cfg.NonLeadership_Fld__c);
                if(cfg.Plan_Fld__c!=null) currRow.Plan_AMT__c = getFieldValue(currRec,cfg.Plan_Fld__c);
                currRow.CC_AMT__c = (currRow.Ldr_AMT__c!=null?currRow.Ldr_AMT__c:0.0) +(currRow.NonLdr_AMT__c!=null?currRow.NonLdr_AMT__c:0.0);
                currRow.PC_AMT__c = (currRow.Plan_AMT__c-currRow.CC_AMT__C); 
            }
            else if(cfg.Data_Type__c == 'Number'){
                if(cfg.Leadership_Fld__c!=null) currRow.Ldr_CNT__c = getFieldValue(currRec,cfg.Leadership_Fld__c);
                if(cfg.NonLeadership_Fld__c!=null) currRow.NonLdr_CNT__c = getFieldValue(currRec,cfg.NonLeadership_Fld__c);
                if(cfg.Plan_Fld__c!=null) currRow.Plan_CNT__c = getFieldValue(currRec,cfg.Plan_Fld__c);
                currRow.CC_CNT__c = (currRow.Ldr_CNT__c!=null?currRow.Ldr_CNT__c:0) +(currRow.NonLdr_CNT__c!=null?currRow.NonLdr_CNT__c:0); 
                currRow.PC_CNT__c = (currRow.Plan_CNT__c-currRow.CC_CNT__C ); 
            }else{
                if(cfg.Current_Campaign_Fld__c!=null) currRow.CC_TXT__c = (String)sObj.get(cfg.Current_Campaign_Fld__c);
                if(cfg.Plan_Fld__c!=null) currRow.Plan_TXT__c = (String)sObj.get(cfg.Plan_Fld__c);
            }
            
            this.activityRows.add(new SalesOrgActivityRowWrapper(currRow,false));
            oddRow = !oddRow;
            
        }
        populateKeyInformation();
        return null;
                                
    }
    
    private void populateKeyInformation(){
        keyInfoRows = new List<SalesOrgActivityRowWrapper>();
        String tempKey;
        Boolean oddRow = true;
        Sales_Activity_Row__c currRow;
        for(Market_Activity_Config__c cfg:KEY_INFO_1_MAPPING ){
            currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow);
            currRow.Data_Type__c = cfg.Data_Type__c;
            currRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
            /*if(cfg.Is_Market_Tag__c){
                currRow.Row_Label__c = mktTags.getLabel('Zone-Market Activity',cfg.Row_Type__c);
            }else{
            */
                currRow.Row_Label__c=cfg.Row_Type__c;
            //}
            if(cfg.Data_Type__c == 'Currency'){
                currRow.CC_AMT__c = getFieldValue(this.currRec,cfg.Current_Campaign_Fld__c); 
            }
            else if(cfg.Data_Type__c == 'Number'){
                currRow.CC_CNT__c = getFieldValue(this.currRec,cfg.Current_Campaign_Fld__c); 
            }/*else{
                currRow.CC_TXT__c = (String)this.currRec.get(cfg.Current_Campaign_Fld__c); 
            }*/
            
            this.keyInfoRows.add(new SalesOrgActivityRowWrapper(currRow,false));
            oddRow = !oddRow;
            
        }

        for(Market_Analysis_Config__c cfg:KEY_INFO_2_MAPPING ){
            currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow);
            currRow.Data_Type__c = cfg.Data_Type__c;
            currRow.Is_Market_Tag__c = cfg.Is_Title_Tag__c;
            if(cfg.Is_Title_Tag__c){
                currRow.Row_Label__c = ldrTitlUtils.getLeaderTitle(cfg.Row_Type__c);
            }/*else{
                currRow.Row_Label__c=cfg.Row_Type__c;
            }
            if(cfg.Data_Type__c == 'Currency'){
                currRow.CC_AMT__c = getFieldValue(this.ldrshipInfo,cfg.Col1_Fld__c); 
            }
            else 
            */if(cfg.Data_Type__c == 'Number'){
                currRow.CC_CNT__c = getFieldValue(this.ldrshipInfo,cfg.Col1_Fld__c); 
            }
            /*else{
                currRow.CC_TXT__c = (String)this.currRec.get(cfg.Col1_Fld__c); 
            }*/
            
            this.keyInfoRows.add(new SalesOrgActivityRowWrapper(currRow,false));
            oddRow = !oddRow;
            
        }

    }
    private Decimal getFieldValue(Sobject currRec,String fldName){
        Decimal totVal = 0.0;
        for(String fld:fldName.split('\n')){
            totVal+=(currRec.get(fld)!=null?(Decimal)currRec.get(fld):0.0);
        }
        return totVal;
    }
    
    public static testmethod void testSlsOrgActivity(){
        ZoneDivEarnOpptyController ctlr = new ZoneDivEarnOpptyController();
        String mktIdKey = '123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createZoneUser('123456');
        List<Sales_Org_Activity__c> data = testData.createMktActivity(testUsr,'Avon Zone Manager',testUsr.Id);  
        List<Sales_Org_Leadership__c> ldrData = testData.createSlsLdrActivity(testUsr,'Avon Zone Manager',testUsr.Id);
        List<Market_Activity_Config__c> rowCfg = testData.createMktConfig();    
        
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.activityRows.size()==6);
            system.debug('>>>>>>>>>>>>>>>>earnOppty:'+ctlr.earnOppty);
            System.assert(ctlr.earnOppty.Ldr_Amt__c==200.0);
            System.assert(ctlr.earnOppty.CC_Amt__c==200.0);
            System.assert(ctlr.earnOppty.NonLdr_Amt__c==0.0);
            
            System.assert(ctlr.keyInfoRows.size()==13);
        }
        
        testUsr = testData.createDivUser('D123456');
        data = testData.createMktActivity(testUsr,'Avon Division Manager',testUsr.Id);  
        ldrData = testData.createSlsLdrActivity(testUsr,'Avon Division Manager',testUsr.Id);
        //rowCfg = testData.createMktConfig();
        System.runAs(testUsr){
            ctlr.init();
            system.debug('>>>>>>>>>>>>>>>>earnOppty:'+ctlr.earnOppty);
            System.assert(ctlr.activityRows.size()==6);
            System.assert(ctlr.earnOppty.Ldr_Amt__c==200.0);
            System.assert(ctlr.earnOppty.CC_Amt__c==200.0);
            System.assert(ctlr.earnOppty.NonLdr_Amt__c==0.0);
            
            /*testUsr.DFALT_ZONE_CD__c=Null;
            update testUsr;
            ctlr.init();
            System.assert(ctlr.activityRows.size()==6);
            System.assert(ctlr.earnOppty.Ldr_Amt__c==300.0);
            System.assert(ctlr.earnOppty.CC_Amt__c==300.0);
            System.assert(ctlr.earnOppty.NonLdr_Amt__c==0.0);
            */
                    
        }
        
    }
    
}
			                            	