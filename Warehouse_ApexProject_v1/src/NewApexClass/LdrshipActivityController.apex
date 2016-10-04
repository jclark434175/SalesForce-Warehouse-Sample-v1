public class LdrshipActivityController {
    public List<SalesOrgActivityRowWrapper> activityRows {get; set;}
    public Market__c market {get; set;}
    private Map<String,String> mktTags = new Map<String,String>();
    public Sales_Org_Leadership__c currRec {get; private set;}
    private Sales_Org_Ldrship_MktTags__c currRecMktTags;
    public User currUsr {get; private set;}
    
    MarketLeaderTitleUtils ldrTitlUtils;
    public PageReference init(){
        currUsr = [select   Id,DFALT_ZONE_CD__c,DFALT_DIV_NM__c,MRKT_ID__c,
                                LanguageLocaleKey
                        from    User
                        where   Id=:UserInfo.getUserId()];
        Profile usrProfile = [  select  Id,Name
                                from    Profile
                                where   Id=:UserInfo.getProfileId()
                            ];
        this.ldrTitlUtils = new MarketLeaderTitleUtils();
        this.ldrTitlUtils.initialize(currUsr);
                            
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
        
        //String key = currUsr.DFALT_ZONE_CD__c;
        this.currRec = [ Select
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
                    
                    this.currRecMktTags = [
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

            this.market = [ select  Name,
                                    Ldr_Actvty_CC_Enabled__c,
                                    Ldr_Actvty_NC_Enabled__c,
                                    Ldr_Actvty_PC_Enabled__c,
                                    Ldr_Actvty_Plan_Enabled__c,
                                    Ldr_Actvty_SPPY_Enabled__c,
                                    Ldr_Actvty_NonLdr_Enabled__c,
                                    Ldr_Actvty_Titl_Lvl_1_Enabled__c,
                                    Ldr_Actvty_Titl_Lvl_2_Enabled__c,
                                    Ldr_Actvty_Titl_Lvl_3_Enabled__c,
                                    Ldr_Actvty_Titl_Lvl_4_Enabled__c,
                                    Ldr_Actvty_Titl_Lvl_5_Enabled__c,
                                    Ldr_Actvty_Titl_Lvl_UQ_Enabled__c
                            from    Market__c
                            where   Market_Id__c = :currRec.MRKT_ID__c
                            ];
            List<Leader_Activity_Config__c> configList = [Select    Market__c,SPPY_Campaign_Fld__c, Row_Type__c, 
                                                                    Prior_Campaign_Fld__c, Next_Campaign_Fld__c, 
                                                                    Is_Market_Tag__c, Data_Type__c,Current_Campaign_Fld__c,
                                                                    Non_Leader_Fld__c,Plan_Fld__c,
                                                                    Title_Lvl_1_Fld__c,Title_Lvl_2_Fld__c,
                                                                    Title_Lvl_3_Fld__c,Title_Lvl_4_Fld__c,
                                                                    Title_Lvl_5_Fld__c,Title_Lvl_UQ_Fld__c,
                                                                    Override_Label__c,
                                                                    Reverse_Trending_Arrows__c
                                                            From    Leader_Activity_Config__c 
                                                            where   Market__r.Market_Id__c=:currRec.MRKT_ID__c
                                                            order by CreatedDate];
            List<String> mktTagSubjAreas = new List<String>();
            
            mktTagSubjAreas.add('Zone-Ldr Activity');
            MarketTagUtils mktTags = new MarketTagUtils();
            mktTags.initialize(mktTagSubjAreas);
            Sales_Activity_Row__c currRow;
            SObject sObj = currRec;
            activityRows = new List<SalesOrgActivityRowWrapper>();
            Boolean oddRow=true;
            SObject objToUse;
            for(Leader_Activity_Config__c cfg: configList){
                currRow = new Sales_Activity_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
                currRow.Data_Type__c = cfg.Data_Type__c;
                currRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
                //Added by Zishan 07/22/09 Override_Label__c
                currRow.Override_Label__c = cfg.Override_Label__c;

                if(!cfg.Is_Market_Tag__c){
                    currRow.Row_Label__c = cfg.Row_Type__c;
                    objToUse = this.currRec;
                }else{
                    currRow.Row_Label__c = mktTags.getLabel('Zone-Ldr Activity',cfg.Row_Type__c);
                    objToUse = this.currRecMktTags;
                }
                //Added by Zishan 07/22/09
                if(!cfg.Override_Label__c){
                    currRow.Row_Label__c = cfg.Row_Type__c;
                    
                }else{
                    currRow.Row_Label__c = mktTags.getLabel('Zone-Ldr Activity',cfg.Row_Type__c);
                }
    
                //System.debug('>>>>>>>>>>Ldr Activity Cfg:'+cfg);
                if(cfg.Data_Type__c == 'Currency'){
                    if(cfg.Next_Campaign_Fld__c!=null) currRow.NC_AMT__c = getFieldValue(cfg.Next_Campaign_Fld__c,objToUse);
                    if(cfg.Non_Leader_Fld__c!=null) currRow.NonLdr_AMT__c = getFieldValue(cfg.Non_Leader_Fld__c,objToUse);
                    if(cfg.Plan_Fld__c!=null) currRow.Plan_AMT__c = getFieldValue(cfg.Plan_Fld__c,objToUse);
                    if(cfg.Prior_Campaign_Fld__c!=null) currRow.PC_AMT__c = getFieldValue(cfg.Prior_Campaign_Fld__c,objToUse);
                    if(cfg.SPPY_Campaign_Fld__c!=null) currRow.SPPY_AMT__c = getFieldValue(cfg.SPPY_Campaign_Fld__c,objToUse);
                    if(cfg.Title_Lvl_UQ_Fld__c!=null) currRow.LdtTitleUQ_AMT__c= getFieldValue(cfg.Title_Lvl_UQ_Fld__c,objToUse);
                    if(cfg.Title_Lvl_1_Fld__c!=null) currRow.LdtTitle1_AMT__c= getFieldValue(cfg.Title_Lvl_1_Fld__c,objToUse);
                    if(cfg.Title_Lvl_2_Fld__c!=null) currRow.LdtTitle2_AMT__c= getFieldValue(cfg.Title_Lvl_2_Fld__c,objToUse);
                    if(cfg.Title_Lvl_3_Fld__c!=null) currRow.LdtTitle3_AMT__c= getFieldValue(cfg.Title_Lvl_3_Fld__c,objToUse);
                    if(cfg.Title_Lvl_4_Fld__c!=null) currRow.LdtTitle4_AMT__c= getFieldValue(cfg.Title_Lvl_4_Fld__c,objToUse);
                    if(cfg.Title_Lvl_5_Fld__c!=null) currRow.LdtTitle5_AMT__c= getFieldValue(cfg.Title_Lvl_5_Fld__c,objToUse);
                    if(cfg.Current_Campaign_Fld__c!=null){
                        currRow.CC_AMT__c= getFieldValue(cfg.Current_Campaign_Fld__c,objToUse);
                    }else{
                        currRow.CC_AMT__c =0.0;
                        currRow.CC_AMT__c += (currRow.NonLdr_Amt__c!=null?currRow.NonLdr_Amt__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitleUQ_AMT__c!=null?currRow.LdtTitleUQ_AMT__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitle1_AMT__c!=null?currRow.LdtTitle1_AMT__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitle2_AMT__c!=null?currRow.LdtTitle2_AMT__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitle3_AMT__c!=null?currRow.LdtTitle3_AMT__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitle4_AMT__c!=null?currRow.LdtTitle4_AMT__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitle5_AMT__c!=null?currRow.LdtTitle5_AMT__c:0.0);
                        currRow.CC_Amt__c +=(currRow.LdtTitleUQ_AMT__c!=null?currRow.LdtTitleUQ_AMT__c:0.0);
                    }                    
                }
                else if(cfg.Data_Type__c == 'Number'){
                    if(cfg.Next_Campaign_Fld__c!=null) currRow.NC_CNT__c = getFieldValue(cfg.Next_Campaign_Fld__c,objToUse);
                    if(cfg.Non_Leader_Fld__c!=null) currRow.NonLdr_CNT__c = getFieldValue(cfg.Non_Leader_Fld__c,objToUse);
                    if(cfg.Plan_Fld__c!=null) currRow.Plan_CNT__c = getFieldValue(cfg.Plan_Fld__c,objToUse);
                    if(cfg.Prior_Campaign_Fld__c!=null) currRow.PC_CNT__c = getFieldValue(cfg.Prior_Campaign_Fld__c,objToUse);
                    if(cfg.SPPY_Campaign_Fld__c!=null) currRow.SPPY_CNT__c = getFieldValue(cfg.SPPY_Campaign_Fld__c,objToUse);

                    if(cfg.Title_Lvl_1_Fld__c!=null) currRow.LdtTitle1_CNT__c= getFieldValue(cfg.Title_Lvl_1_Fld__c,objToUse);
                    if(cfg.Title_Lvl_2_Fld__c!=null) currRow.LdtTitle2_CNT__c= getFieldValue(cfg.Title_Lvl_2_Fld__c,objToUse);
                    if(cfg.Title_Lvl_3_Fld__c!=null) currRow.LdtTitle3_CNT__c= getFieldValue(cfg.Title_Lvl_3_Fld__c,objToUse);
                    if(cfg.Title_Lvl_4_Fld__c!=null) currRow.LdtTitle4_CNT__c= getFieldValue(cfg.Title_Lvl_4_Fld__c,objToUse);
                    if(cfg.Title_Lvl_5_Fld__c!=null) currRow.LdtTitle5_CNT__c= getFieldValue(cfg.Title_Lvl_5_Fld__c,objToUse);
                    if(cfg.Title_Lvl_UQ_Fld__c!=null) currRow.LdtTitleUQ_CNT__c= getFieldValue(cfg.Title_Lvl_UQ_Fld__c,objToUse);

                    if(cfg.Current_Campaign_Fld__c!=null){
                        currRow.CC_Cnt__c= getFieldValue(cfg.Current_Campaign_Fld__c,objToUse);
                    }else{
                        currRow.CC_Cnt__c =0.0;
                        currRow.CC_Cnt__c += (currRow.NonLdr_Cnt__c!=null?currRow.NonLdr_Cnt__c:0.0);
                        currRow.CC_Cnt__c +=(currRow.LdtTitle1_CNT__c!=null?currRow.LdtTitle1_CNT__c:0.0);
                        currRow.CC_Cnt__c +=(currRow.LdtTitle2_CNT__c!=null?currRow.LdtTitle2_CNT__c:0.0);
                        currRow.CC_Cnt__c +=(currRow.LdtTitle3_CNT__c!=null?currRow.LdtTitle3_CNT__c:0.0);
                        currRow.CC_Cnt__c +=(currRow.LdtTitle4_CNT__c!=null?currRow.LdtTitle4_CNT__c:0.0);
                        currRow.CC_Cnt__c +=(currRow.LdtTitle5_CNT__c!=null?currRow.LdtTitle5_CNT__c:0.0);
                        currRow.CC_Cnt__c +=(currRow.LdtTitleUQ_CNT__c!=null?currRow.LdtTitleUQ_CNT__c:0.0);
                    }                    
                }else{
                    if(cfg.Current_Campaign_Fld__c!=null) currRow.CC_TXT__c = (String)objToUse.get(cfg.Current_Campaign_Fld__c);
                    if(cfg.Next_Campaign_Fld__c!=null) currRow.NC_TXT__c = (String)objToUse.get(cfg.Next_Campaign_Fld__c);
                    if(cfg.Non_Leader_Fld__c!=null) currRow.NonLdr_TXT__c = (String)objToUse.get(cfg.Non_Leader_Fld__c);
                    if(cfg.Plan_Fld__c!=null) currRow.Plan_TXT__c = (String)objToUse.get(cfg.Plan_Fld__c);
                    if(cfg.Prior_Campaign_Fld__c!=null) currRow.PC_TXT__c = (String)objToUse.get(cfg.Prior_Campaign_Fld__c);
                    if(cfg.SPPY_Campaign_Fld__c!=null) currRow.SPPY_TXT__c = (String)objToUse.get(cfg.SPPY_Campaign_Fld__c);
                    if(cfg.Title_Lvl_1_Fld__c!=null) currRow.LdtTitle1_TXT__c= (String)objToUse.get(cfg.Title_Lvl_1_Fld__c);
                    if(cfg.Title_Lvl_2_Fld__c!=null) currRow.LdtTitle2_TXT__c= (String)objToUse.get(cfg.Title_Lvl_2_Fld__c);
                    if(cfg.Title_Lvl_3_Fld__c!=null) currRow.LdtTitle3_TXT__c= (String)objToUse.get(cfg.Title_Lvl_3_Fld__c);
                    if(cfg.Title_Lvl_4_Fld__c!=null) currRow.LdtTitle4_TXT__c= (String)objToUse.get(cfg.Title_Lvl_4_Fld__c);
                    if(cfg.Title_Lvl_5_Fld__c!=null) currRow.LdtTitle5_TXT__c= (String)objToUse.get(cfg.Title_Lvl_5_Fld__c);
                    if(cfg.Title_Lvl_UQ_Fld__c!=null) currRow.LdtTitleUQ_TXT__c= (String)objToUse.get(cfg.Title_Lvl_UQ_Fld__c);
                    
                }
                /*Zishan added 8/20/09 and comment out old code
                this.activityRows.add(new SalesOrgActivityRowWrapper(currRow,false));*/
                this.activityRows.add(new SalesOrgActivityRowWrapper(currRow,false,cfg.Reverse_Trending_Arrows__c));

                oddRow = !oddRow;
                
            }
                    
        return null;    
    }
    
    public Integer getEnabledColCount(){
        Integer colCount = 1;
        try{
            if(this.market.Ldr_Actvty_SPPY_Enabled__c){
                colCount+=2;
            }   
            if(this.market.Ldr_Actvty_PC_Enabled__c){
                colCount+=2;
            }   
            if(this.market.Ldr_Actvty_NC_Enabled__c){
                colCount+=1;
            }   
            if(this.market.Ldr_Actvty_CC_Enabled__c){
                colCount+=1;
            }
            if(this.market.Ldr_Actvty_Plan_Enabled__c){
                colCount+=1;
            }           
            if(this.market.Ldr_Actvty_NonLdr_Enabled__c){
                colCount+=1;
            }
            if(this.market.Ldr_Actvty_Titl_Lvl_1_Enabled__c){colCount+=1;}
            if(this.market.Ldr_Actvty_Titl_Lvl_2_Enabled__c){colCount+=1;}
            if(this.market.Ldr_Actvty_Titl_Lvl_3_Enabled__c){colCount+=1;}
            if(this.market.Ldr_Actvty_Titl_Lvl_4_Enabled__c){colCount+=1;}
            if(this.market.Ldr_Actvty_Titl_Lvl_5_Enabled__c){colCount+=1;}
            if(this.market.Ldr_Actvty_Titl_Lvl_UQ_Enabled__c){colCount+=1;}

        }catch(Exception ex){
            //ErrorHandler.handleError('MyBusiness', ex);
            return -1;
        }   
        return colCount;    
    }
    
    public String getLevelUQTitle(){
        return this.ldrTitlUtils.getLeaderTitle('UQ');  
    }

    public String getLevel1Title(){
        return this.ldrTitlUtils.getLeaderTitle('1');   
    }
    public String getLevel2Title(){
        return this.ldrTitlUtils.getLeaderTitle('2');   
    }
    public String getLevel3Title(){
        return this.ldrTitlUtils.getLeaderTitle('3');   
    }
    public String getLevel4Title(){
        return this.ldrTitlUtils.getLeaderTitle('4');   
    }
    public String getLevel5Title(){
        return this.ldrTitlUtils.getLeaderTitle('5');   
    }
    public String getLevel0Title(){
        return this.ldrTitlUtils.getLeaderTitle('0');   
    }
    private Decimal getFieldValue(String colFlds,Sobject currRec){
        Decimal totVal = null;
        //System.debug('>>>>>>>>>>>>>>> colFlds'+colFlds);
        String tempFld;
        for(String fldName: colFlds.split('\n')){
            tempFld = fldName.trim();
            //System.debug('>>>>>>>>>>>>currRec.get(tempFld)='+(currRec.get(tempFld)));
            if(currRec.get(tempFld)!=null){
                if(totVal==null){
                    totVal = 0.0;   
                }
                totVal += (Decimal)currRec.get(tempFld);
            }
        }
        return totVal;
    }
    
    public static testmethod void testLdrActivity(){
        LdrshipActivityController ctlr = new LdrshipActivityController();
        String mktIdKey = 'TEST123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createZoneUser('123456');
        testData.createSlsLdrActivity(testUsr,'Avon Zone Manager',testUsr.Id);  
        testData.createLdrActvtyConfig();   
        
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.getEnabledColCount()==15);
            System.assert(ctlr.getLevel1Title()==null);
            System.assert(ctlr.getLevel2Title()==null);
            System.assert(ctlr.getLevel3Title()==null);
            System.assert(ctlr.getLevel4Title()==null);
            System.assert(ctlr.getLevel5Title()==null);
            System.assert(ctlr.getLevelUQTitle()==null);
            System.assert(ctlr.getLevel0Title()==null);
        }
        testUsr = testData.createDivUser('D123456');
        testData.createSlsLdrActivity(testUsr,'Avon Division Manager',testUsr.Id);  
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.getEnabledColCount()==15);
        }
        
    }

}
			                            	