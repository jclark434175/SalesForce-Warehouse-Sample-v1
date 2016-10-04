public class MarketAnalysisController {
    
    public List<AnalysisBlock> blockList {get; set;}
    public String section {get; private set;}
    public Sales_Org_Leadership__c currRec {get; private set;}
    private Sales_Org_Ldrship_MktTags__c currRecMktTags;
    public User currUsr {get; set;}
    
    public PageReference init(){
        String repAcctNbr = ApexPages.currentPage().getParameters().get('repAcctNbr');
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
    
        this.section = ApexPages.currentPage().getParameters().get('section');
        blockList = new List<AnalysisBlock>();
                            
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
                            TOTAL_STAFF_CHNG_PCT__c,CC_UQ_TITL_STAFF_NET_CHNG__c,CC_TITL_1_STAFF_NET_CHNG__c,CC_TITL_2_STAFF_NET_CHNG__c,
                            CC_TITL_3_STAFF_NET_CHNG__c,CC_TITL_4_STAFF_NET_CHNG__c,CC_TITL_5_STAFF_NET_CHNG__c,CC_ZONE_MGR_STAFF_NET_CHNG__c,
                            PC_NON_LDRSHP_PEND_ORD_CNT__c,RTURN_SLS_REP_CNT__c,PAST_DUE_REP_CNT__c,PRSNL_SLS_BLW_QLFR_REP_CNT__c,
                            NON_LDRSHP_RTURN_AMT__c,DWNLN_NON_LDR_PEND_ORD_CNT__c,PC_PRSNL_ORD_UND_MIN_CNT__c,PC_PRSNL_ORD_ABV_MIN_CNT__c
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
                    
            
        List<String> mktTagSubjAreas = new List<String>();
        //Zishan Change to 07/23/09 from Ldr-Analysis to Zone-Analysis
        mktTagSubjAreas.add('Zone-Analysis');
        MarketTagUtils mktTags = new MarketTagUtils();
        mktTags.initialize(mktTagSubjAreas);
                
        User currUser = [select LanguageLocaleKey,MRKT_ID__c from User 
                         where Id=:UserInfo.getUserId()];
        MarketLeaderTitleUtils ldrTitlUtils = new MarketLeaderTitleUtils();
        ldrTitlUtils.initialize(currUser);
                
        AnalysisBlock block = new AnalysisBlock();
        String prevBlock;
        Boolean oddRow = true;
        for(Market_Analysis_config__c cfg: [    Select  Section__c, Row_Type__c, Market__c, Is_Market_Tag__c,Block__c,
                                                        Data_Type__c,Col4_Fld__c, Col3_Fld__c, Col2_Fld__c, Col1_Fld__c,
                                                        Is_Title_Tag__c,Report__r.Report_Id__c,
                                                        Display_Totals__c,Override_Label__c
                                                From    Market_Analysis_Config__c
                                                where   Market__r.Market_Id__c=:currRec.MRKT_ID__c
                                                and     Section__c=:section])
        //Zishan Added 07/22/09 Override Label
        {
            if((prevBlock!=null && cfg.Block__c != prevBlock)){
                this.blockList.add(block);
                block = new AnalysisBlock();
                block.blockName=cfg.Block__c;
                oddRow = true;
            }
            block.displayTotals=cfg.Display_Totals__c;
            block.reportId = cfg.Report__r.Report_Id__c;
            if(cfg.Col1_Fld__c !=null){
                block.col1Enabled = true;
            }               
            if(cfg.Col2_Fld__c !=null){
                block.col2Enabled = true;
            }               
            if(cfg.Col3_Fld__c !=null){
                block.col3Enabled = true;
            }   
            if(cfg.Col4_Fld__c !=null){
                block.col4Enabled = true;
            }
            
            block.blockName=cfg.Block__c;           
            block.addBlockRow(createRow(currRec,currRecMktTags,cfg,mktTags,ldrTitlUtils,oddRow));
            prevBlock = cfg.Block__c;
            oddRow = !oddRow;
        }
        this.blockList.add(block);
        return null;
                
    }
    
    private AnalysisRow createRow(Sales_Org_Leadership__c currRec,Sales_Org_Ldrship_MktTags__c mktTagData,Market_Analysis_Config__c cfg,
                                         MarketTagUtils mktTags,MarketLeaderTitleUtils ldrTitlUtils,Boolean oddRow){
        My_Business_Row__c myBusRow = new My_Business_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode);
        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>> cfg='+cfg);
        myBusRow.Data_Type__c = cfg.Data_Type__c;
        myBusRow.Is_Title_Tag__c = cfg.Is_Title_Tag__c;
        myBusRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
        //Zishan Added here Override Label 07/22/09
        myBusRow.Override_Label__c = cfg.Override_Label__c;
        if(!cfg.Is_Market_Tag__c && !cfg.Is_Title_Tag__c){
            myBusRow.Row_Label__c = cfg.Row_Type__c;
        }

        SObject objToUse;
        //System.debug('cfg.Row_Type__c='+cfg.Row_Type__c);
        if(cfg.Is_Title_Tag__c){
            String rowType = cfg.Row_Type__c;
            myBusRow.Row_Label__c = ldrTitlUtils.getLeaderTitle(rowType.substring('Title Level '.length()));
        }
        if(cfg.Is_Market_Tag__c){
            objToUse = mktTagData;
            myBusRow.Row_Label__c = mktTags.getLabel('Zone-Analysis',cfg.Row_Type__c);
        }else{
            objToUse = currRec; 
        }
        //Zishan Added 07/22/09
         if(cfg.Override_Label__c){
            myBusRow.Row_Label__c = mktTags.getLabel('Zone-Analysis',cfg.Row_Type__c);
         }         
         
        if(cfg.Data_Type__c == 'Currency'){
            if(cfg.Col1_Fld__c!=null)
                myBusRow.CC_Amt__c = getFieldValue(cfg.Col1_Fld__c,objToUse);
            if(cfg.Col2_Fld__c!=null)
                myBusRow.PC_Amt__c = getFieldValue(cfg.Col2_Fld__c,objToUse);
            if(cfg.Col3_Fld__c!=null)
                myBusRow.NC_Amt__c = getFieldValue(cfg.Col3_Fld__c,objToUse);
            if(cfg.Col4_Fld__c!=null)
                myBusRow.SPPY_Amt__c = getFieldValue(cfg.Col4_Fld__c,objToUse);
        }else if(cfg.Data_Type__c == 'Number'){
            if(cfg.Col1_Fld__c!=null)
                myBusRow.CC_Cnt__c = getFieldValue(cfg.Col1_Fld__c,objToUse);
            if(cfg.Col2_Fld__c!=null)
                myBusRow.PC_Cnt__c = getFieldValue(cfg.Col2_Fld__c,objToUse);
            if(cfg.Col3_Fld__c!=null)
                myBusRow.NC_Cnt__c = getFieldValue(cfg.Col3_Fld__c,objToUse);
            if(cfg.Col4_Fld__c!=null)
                myBusRow.SPPY_Cnt__c = getFieldValue(cfg.Col4_Fld__c,objToUse);
        }else{
            if(cfg.Col1_Fld__c!=null)
                myBusRow.CC_Txt__c = (String)objToUse.get(cfg.Col1_Fld__c);
            if(cfg.Col2_Fld__c!=null)
                myBusRow.PC_Txt__c = (String)objToUse.get(cfg.Col2_Fld__c);
            if(cfg.Col3_Fld__c!=null)
                myBusRow.NC_Txt__c = (String)objToUse.get(cfg.Col3_Fld__c);
            if(cfg.Col4_Fld__c!=null)
                myBusRow.SPPY_Txt__c = (String)objToUse.get(cfg.Col4_Fld__c);
        }
        System.debug('>>>>>>>>>>>>>>>>>>>>> Row:'+myBusRow);
      return new AnalysisRow(myBusRow,cfg.Report__r.Report_Id__c,oddRow);
        
    }
    
    
    public Sales_Org_Leadership__c getCurrentRecord(){
        return this.currRec;    
    }
    
    private Decimal getFieldValue(String colFlds,SObject currRec){
        Decimal totVal = 0.0;

        System.debug('>>>>>>>>>>>>>>> colFlds'+colFlds);
        String tempFld;
        for(String fldName: colFlds.split('\n')){
            tempFld = fldName.trim();   
            totVal+=(currRec.get(tempFld)!=null?(Decimal)currRec.get(tempFld):0.0);
        }
        return totVal;
    }

    public static testmethod void testMktAnalysis(){
        MarketAnalysisController ctlr = new MarketAnalysisController();
        String mktIdKey = '123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createZoneUser(mktIdKey);
        List<Sales_Org_Leadership__c> ldrData = testData.createSlsLdrActivity(testUsr,'Avon Zone Manager',testUsr.Id);
        testData.createMktAnalysisConfig();
        PageReference pageRef = new PageReference('/apex/MarketAnalysis');
        pageRef.getParameters().put('section','Orders');
        Test.setCurrentPageReference(pageRef);
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.blockList.size()==2);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            System.assert(ctlr.blockList[1].blockRows.size()==2);
            
            pageRef.getParameters().put('section','Sales');
            ctlr.init();
            System.assert(ctlr.blockList.size()==1);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            pageRef.getParameters().put('section','Current Business');
            ctlr.init();
            System.assert(ctlr.blockList.size()==1);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            //System.assert(ctlr.getCurrentRecord().Id == ldrData[0].Id);
        }
        pageRef = new PageReference('/apex/MarketAnalysis');
        pageRef.getParameters().put('section','Orders');
        Test.setCurrentPageReference(pageRef);
        testUsr = testData.createDivUser('D'+mktIdKey);
        testData.createSlsLdrActivity(testUsr,'Avon Division Manager',testUsr.Id);
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.blockList.size()==2);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            System.assert(ctlr.blockList[1].blockRows.size()==2);

            /*testUsr.DFALT_ZONE_CD__c = null;
            update testUsr;         
            ctlr.init();
            System.assert(ctlr.blockList.size()==2);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            System.assert(ctlr.blockList[1].blockRows.size()==2);

            pageRef.getParameters().put('section','Sales');
            ctlr.init();
            System.assert(ctlr.blockList.size()==1);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            pageRef.getParameters().put('section','Current Business');
            ctlr.init();
            System.assert(ctlr.blockList.size()==1);
            System.assert(ctlr.blockList[0].blockRows.size()==2);
            */
        }
                    
    }

}
			                            	