public class MyBusinessController {

    public List<MyBusinessRowWrapper> myBusinessRows {get; set;}
    public Market__c market {get; set;}
    public Leader_Downline_Summary__c ldrSmryRec {get; set;}
    public My_Business_Row__c awardSales {get; private set;}
    public My_Business_Row__c netSales {get; private set;}
    private Map<String,String> mktTags = new Map<String,String>();
    public String repMktAcctNbr {get; private set;}
    public String repAcctNbr {get; private set;}
    public String netSalesLabel {get; private set;}
    public String awardSalesLabel   {get; private set;}
    
    public PageReference init(){
        User currUsr;
         currUsr =  [   select  ACCT_NR__c,MRKT_ID_ACCT_NR_KEY__c,MRKT_ID__c
                        from    User
                        where   Id = :UserInfo.getUserId()];
        if(repAcctNbr == null || repAcctNbr == ''){
             this.repMktAcctNbr=currUsr.MRKT_ID_ACCT_NR_KEY__c;
             this.repAcctNbr=currUsr.ACCT_NR__c;
        }
        //try{
            My_Business__c currRec = [  select  Id,CurrencyIsoCode,
                                                MRKT_ACCT_KEY__c,
                                                ACCT_NR__c,
                                                MRKT_CD__c,
                                                MRKT_CMPGN_KEY__c,
                                                CRNCY_CD__c,
                                                OPERTNL_CMPGN_NR__c,
                                                AWRD_SLS_AMT__c,
                                                PC_AWRD_SLS_AMT__c,
                                                SPPY_AWRD_SLS_AMT__c,
                                                AVG_AWRD_SLS_AMT__c,
                                                NC_AWRD_SLS_AMT__c,
                                                PC_AVG_AWRD_SLS_AMT__c,
                                                SPPY_CMPGN_AVG_AWRD_SLS_AMT__c,
                                                NC_AVG_AWRD_SLS_AMT__c,
                                                NET_SLS_AMT__c,
                                                PC_NET_SLS_AMT__c,
                                                SPPY_NET_SLS_AMT__c,
                                                NC_NET_SLS_AMT__c,
                                                MULT_ORD_CNT__c,
                                                PC_MULT_ORD_CNT__c,
                                                SPPY_MULT_ORD_CNT__c,
                                                NC_MULT_ORD_CNT__c,
                                                PAST_DUE_AMT__c,
                                                PC_PAST_DUE_AMT__c,
                                                SPPY_PAST_DUE_AMT__c,
                                                NC_PAST_DUE_AMT__c,
                                                ORD_HOLD_AMT__c,
                                                PC_ORD_HOLD_AMT__c,
                                                SPPY_ORD_HOLD_AMT__c,
                                                NC_ORD_HOLD_AMT__c,
                                                GENRTN_1_APPT_CNT__c,
                                                PC_GENRTN_1_APPT_CNT__c,
                                                SPPY_GENRTN_1_APPT_CNT__c,
                                                NC_GENRTN_1_APPT_CNT__c,
                                                CUST_CNT__c,
                                                PC_CUST_CNT__c,
                                                SPPY_CUST_CNT__c,
                                                NC_CUST_CNT__c,
                                                RTURN_NET_SLS_AMT__c,
                                                PC_RTURN_NET_SLS_AMT__c,
                                                SPPY_RTURN_NET_SLS_AMT__c,
                                                NC_RTURN_NET_SLS_AMT__c,
                                                RTURN_AWRD_SLS_AMT__c,
                                                PC_RTURN_AWRD_SLS_AMT__c,
                                                NC_RTURN_AWRD_SLS_AMT__c,
                                                SPPY_RTURN_AWRD_SLS_AMT__c,
                                                LAST_PYMT_RECVD_AMT__c,
                                                BAL_DUE_AMT__c,
                                                PC_BAL_DUE_AMT__c,
                                                SPPY_BAL_DUE_AMT__c,
                                                NC_BAL_DUE_AMT__c,
                                                CTD_AWRD_SLS_AMT__c,
                                                ERNGS_PD_AMT__c,
                                                PC_ERNGS_PD_AMT__c,
                                                SPPY_ERNGS_PD_AMT__c,
                                                NC_ERNGS_PD_AMT__c,
                                                YTD_ERNGS_AMT__c,
                                                PRFRMNC_POINT_QTY__c,
                                                MIN_PRSNL_SLS_REQD_AMT__c,
                                                YTD_APPT_CNT__c,
                                                YTD_RNSTMT_CNT__c,
                                                YTD_AWRD_SLS_AMT__c,
                                                YTD_NET_SLS_AMT__c,
                                                YTD_RTURN_NET_SLS_AMT__c,
                                                YTD_CUST_SERVD_CNT__c,
                                                PAST_DUE_CMPGN_CNT__c,
                                                ORD_SRCE_DESC_TXT__c,
                                                GRP_APPT_CNT__c,
                                                GRP_RNSTMT_CNT__c,
                                                GRP_RMOVL_CNT__c,
                                                MLPLN_CLOSD_IND__c,
                                                PC_ORD_SBMTD_AMT__c,
                                                SPPY_ORD_SBMTD_AMT__c,
                                                ORD_INVCD_CNT__c,
                                                ORD_INVCD_AMT__c,
                                                PC_ORD_INVCD_CNT__c,
                                                PC_ORD_INVCD_AMT__c,
                                                SPPY_ORD_INVCD_CNT__c,
                                                SPPY_ORD_INVCD_AMT__c,
                                                ORD_CNCLD_CNT__c,
                                                ORD_CNCLD_AMT__c,
                                                PC_ORD_CNCLD_CNT__c,
                                                PC_ORD_CNCLD_AMT__c,
                                                SPPY_ORD_CNCLD_CNT__c,
                                                SPPY_ORD_CNCLD_AMT__c,
                                                ORD_ON_HOLD_CNT__c,
                                                PC_ORD_ON_HOLD_CNT__c,
                                                SPPY_ORD_ON_HOLD_CNT__c,
                                                NC_GENRTN_1_RMOVL_CNT__c,
                                                NC_GENRTN_1_RNSTMT_CNT__c,
                                                GENRTN_1_RMOVL_CNT__c,
                                                PC_GENRTN_1_RMOVL_CNT__c,
                                                SPPY_GENRTN_1_RMOVL_CNT__c,
                                                GENRTN_1_RNSTMT_CNT__c,
                                                PC_GENRTN_1_RNSTMT_CNT__c,
                                                SPPY_GENRTN_1_RNSTMT_CNT__c,
                                                DEMO_ITEM_ORDRD_CNT__c,
                                                PC_DEMO_ITEM_ORDRD_CNT__c,
                                                SPPY_DEMO_ITEM_ORDRD_CNT__c,
                                                DEMO_AMT__c,
                                                PC_DEMO_AMT__c,
                                                SPPY_DEMO_AMT__c,
                                                BRCHR_CNT__c,
                                                PC_BRCHR_CNT__c,
                                                SPPY_BRCHR_CNT__c,
                                                BRCHR_AMT__c,
                                                PC_BRCHR_AMT__c,
                                                SPPY_BRCHR_AMT__c,
                                                BAD_DEBT_AMT__c,
                                                PC_BAD_DEBT_AMT__c,
                                                SPPY_BAD_DEBT_AMT__c,
                                                REP_STUS_CD__c,
                                                PC_REP_STUS_CD__c,
                                                SPPY_REP_STUS_CD__c,
                                                REP_TITL_STUS_CD__c,
                                                PC_REP_TITL_STUS_CD__c,
                                                SPPY_REP_TITL_STUS_CD__c,
                                                NC_ORD_SBMTD_AMT__c,
                                                NC_ORD_INVCD_CNT__c,
                                                NC_ORD_INVCD_AMT__c,
                                                NC_ORD_CNCLD_CNT__c,
                                                NC_ORD_CNCLD_AMT__c,
                                                NC_ORD_ON_HOLD_CNT__c,
                                                NC_TITL_CHNGD_CNT__c,
                                                NC_ORD_STUS_CNT__c,
                                                NC_DEMO_ITEM_ORDRD_CNT__c,
                                                NC_DEMO_AMT__c,
                                                NC_BRCHR_CNT__c,
                                                NC_BRCHR_AMT__c,
                                                NC_BAD_DEBT_AMT__c,
                                                NC_REP_STUS_CD__c,
                                                NC_REP_TITL_STUS_CD__c,
                                                NC_UPLN_CNT__c,
                                                TITL_CHNGD_CNT__c,
                                                UPLN_CNT__c,
                                                MY_ACCT_MRKT_TAG_1_KPI__c,
                                                MY_ACCT_MRKT_TAG_2_KPI__c,
                                                PRSNL_SLS_MRKT_TAG_1_KPI__c,
                                                PRSNL_SLS_MRKT_TAG_2_KPI__c,
                                                PRSNL_SLS_MRKT_TAG_3_KPI__c,
                                                MY_BUS_MRKT_TAG_1_AMT__c,
                                                MY_BUS_MRKT_TAG_2_AMT__c,
                                                MY_BUS_MRKT_TAG_3_TXT__c,
                                                MY_BUS_MRKT_TAG_4_TXT__c,
                                                MY_BUS_MRKT_TAG_5_TXT__c,
                                                MY_BUS_MRKT_TAG_6_PCT__c,
                                                NC_MY_BUS_MRKT_TAG_1_AMT__c,
                                                NC_MY_BUS_MRKT_TAG_2_AMT__c,
                                                NC_MY_BUS_MRKT_TAG_3_TXT__c,
                                                NC_MY_BUS_MRKT_TAG_4_TXT__c,
                                                NC_MY_BUS_MRKT_TAG_5_TXT__c,
                                                NC_MY_BUS_MRKT_TAG_6_PCT__c,
                                                PC_MY_BUS_MRKT_TAG_1_AMT__c,
                                                PC_MY_BUS_MRKT_TAG_2_AMT__c,
                                                PC_MY_BUS_MRKT_TAG_3_TXT__c,
                                                PC_MY_BUS_MRKT_TAG_4_TXT__c,
                                                PC_MY_BUS_MRKT_TAG_5_TXT__c,
                                                PC_MY_BUS_MRKT_TAG_6_PCT__c,
                                                SPPY_MY_BUS_MRKT_TAG_1_AMT__c,
                                                SPPY_MY_BUS_MRKT_TAG_2_AMT__c,
                                                SPPY_MY_BUS_MRKT_TAG_3_TXT__c,
                                                SPPY_MY_BUS_MRKT_TAG_4_TXT__c,
                                                SPPY_MY_BUS_MRKT_TAG_5_TXT__c,
                                                SPPY_MY_BUS_MRKT_TAG_6_PCT__c,
                                                PD_SLS_AMT__c,PRSNL_QLFR_SLS_AMT__c,
                                                NC_PRSNL_QLFR_SLS_AMT__c
                                        from    My_Business__c
                                        where   MRKT_ACCT_KEY__c=:repMktAcctNbr];
        // Get the Leader downline summary record to be passed to action items 
        this.ldrSmryRec = 
                [
                    Select  
                            YTD_RNSTMT_CNT__c,TITL_1_PRMOTD_CNT__c,NC_MRKT_TAG_1_PRFRMNC_AMT__c,GENRTN_3_GRP_CUST_CNT__c,
                            YTD_RMOVL_CNT__c,TITL_1_PATD_CNT__c,NC_IN_ZONE_GRP_STF_CNT__c,GENRTN_3_GRP_AWRD_SLS_AMT__c,
                            YTD_GRP_NET_SLS_AMT__c,TITL_1_GRP_ABV_MIN_CNT__c,NC_GRP_RTURN_AMT__c,GENRTN_3_GRP_AVG_CUST_CNT__c,
                            YTD_GRP_AWRD_SLS_AMT__c,TITL_1_CTT_CNT__c,NC_GRP_RNSTMT_CNT__c,GENRTN_3_GRP_APPT_CNT__c,
                            YTD_CUST_SERVD_CNT__c,TITL_1_AT_RSK_CNT__c,NC_GRP_RMOVL_CNT__c,GENRTN_3_GRP_ADDS_CNT__c,
                            YTD_APPT_CNT__c,SystemModstamp,NC_GRP_PD_SLS_AMT__c,GENRTN_3_FRST_ORD_CNT__c,
                            WK4_PC_MULT_ORD_CNT__c,SSPY_TOTAL_ORD_RCVD__c,NC_GRP_PAST_DUE_AMT__c,GENRTN_3_CNT_RTURN_ORD_CNT__c,
                            WK4_NC_MULT_ORD_CNT__c,SPPY_MULT_ORD_CNT__c,NC_GRP_ORD_UND_MIN_CNT__c,GENRTN_3_BRTHDY_CNT__c,
                            WK4_CC_MULT_ORD_CNT__c,SPPY_MRKT_TAG_4_PRFRMNC_PCT__c,NC_GRP_ORD_PENDNG_CNT__c,GENRTN_3_BLW_MIN_AWRD_SLS_AMT__c,
                            WK3_PC_MULT_ORD_CNT__c,SPPY_MRKT_TAG_3_PRFRMNC_TXT__c,NC_GRP_ORD_ON_HOLD_CNT__c,GENRTN_3_BAL_AMT__c,
                            WK3_NC_MULT_ORD_CNT__c,SPPY_MRKT_TAG_2_PRFRMNC_TXT__c,NC_GRP_ORD_ABV_MIN_CNT__c,GENRTN_3_BAD_DEBT_AMT__c,
                            WK3_CC_MULT_ORD_CNT__c,SPPY_MRKT_TAG_1_PRFRMNC_AMT__c,NC_GRP_NO_ORD_CNT__c,GENRTN_3_AVON_ANNIV_CNT__c,
                            WK2_PC_MULT_ORD_CNT__c,SPPY_GRP_TITL_PROMTD_CNT__c,NC_GRP_NET_SLS_AMT__c,GENRTN_2_WK4_MULT_ORD_CNT__c,
                            WK2_NC_MULT_ORD_CNT__c,SPPY_GRP_TITL_DMTD_CNT__c,NC_GRP_INHRTD_CNT__c,GENRTN_2_WK3_MULT_ORD_CNT__c,
                            WK2_CC_MULT_ORD_CNT__c,SPPY_GRP_TITL_CHNG_CNT__c,NC_GRP_CUST_CNT__c,GENRTN_2_WK2_MULT_ORD_CNT__c,
                            WK1_PC_MULT_ORD_CNT__c,SPPY_GRP_RTURN_AMT__c,NC_GRP_AWRD_SLS_AMT__c,GENRTN_2_WK1_MULT_ORD_CNT__c,
                            WK1_NC_MULT_ORD_CNT__c,SPPY_GRP_RNSTMT_CNT__c,NC_GRP_AVG_CUST_CNT__c,GENRTN_2_NO_DEMO_ITEM_CNT__c,
                            WK1_CC_MULT_ORD_CNT__c,SPPY_GRP_RMOVL_CNT__c,NC_GRP_APPT_CNT__c,GENRTN_2_NO_BRCHR_CNT__c,
                            UQ_TITL_1_WO_TOP_SLR_TITL_CNT__c,SPPY_GRP_PD_SLS_AMT__c,NC_GENRTN_3_MULT_ORD_CNT__c,GENRTN_2_NEW_REP_1ST_ORD_CNT__c,
                            UQ_TITL_1_WO_PATD_CNT__c,SPPY_GRP_PAST_DUE_AMT__c,NC_GENRTN_2_MULT_ORD_CNT__c,GENRTN_2_MULT_ORD_CNT__c,
                            UQ_TITL_1_TOP_SLR_CNT__c,SPPY_GRP_ORD_UND_MIN_CNT__c,NC_GENRTN_1_MULT_ORD_CNT__c,GENRTN_2_MRKT_TAG_4_PRFRMNC_PC__c,
                            UQ_TITL_1_TAR_CNT__c,SPPY_GRP_ORD_PENDNG_CNT__c,NC_BLW_MIN_AWRD_SLS_AMT__c,GENRTN_2_MRKT_TAG_4_PRFRMNC_PCT__c,
                            UQ_TITL_1_STF_CNT__c,SPPY_GRP_ORD_ON_HOLD_CNT__c,MRKT_TAG_4_ANLYSS_SLS_TXT__c,GENRTN_2_MRKT_TAG_3_PRFRMNC_TX__c,
                            UQ_TITL_1_PRSNL_ABV_MIN_CNT__c,SPPY_GRP_ORD_ABV_MIN_CNT__c,MRKT_TAG_4_ANLYSS_ORDS_TXT__c,GENRTN_2_MRKT_TAG_2_PRFRMNC_TX__c,
                            UQ_TITL_1_PRMOTD_CNT__c,SPPY_GRP_NO_ORD_CNT__c,MRKT_TAG_4_ANLYSS_BUS_TXT__c,GENRTN_2_MRKT_TAG_1_PRFRMNC_AM__c,
                            UQ_TITL_1_PATD_CNT__c,SPPY_GRP_NET_SLS_AMT__c,MRKT_TAG_3_QLFR_AMT__c,GENRTN_2_MRKT_TAG_1_PRFRMNC_AMT__c,
                            UQ_TITL_1_GRP_ABV_MIN_CNT__c,SPPY_GRP_INHRTD_CNT__c,MRKT_TAG_3_ANLYSS_SLS_PCT__c,GENRTN_2_GRP_TITL_PROMTD_CNT__c,
                            UQ_TITL_1_CTT_CNT__c,SPPY_GRP_ERNGS_PD_AMT__c,MRKT_TAG_3_ANLYSS_ORDS_PCT__c,GENRTN_2_GRP_TITL_DMTD_CNT__c,
                            UQ_TITL_1_AT_RSK_CNT__c,SPPY_GRP_CUST_CNT__c,MRKT_TAG_3_ANLYSS_BUS_PCT__c,GENRTN_2_GRP_TITL_CHNG_CNT__c,
                            TOTAL_WO_TOP_SLR_CNT__c,SPPY_GRP_AWRD_SLS_AMT__c,MRKT_TAG_2_QLFR_NR__c,GENRTN_2_GRP_RTURN_AMT__c,
                            TOTAL_WO_PATD_CNT__c,SPPY_GRP_AVG_CUST_CNT__c,MRKT_TAG_2_ANLYSS_SLS_AMT__c,GENRTN_2_GRP_RNSTMT_CNT__c,
                            TOTAL_TOP_SLR_CNT__c,SPPY_GRP_APPT_CNT__c,MRKT_TAG_2_ANLYSS_ORDS_AMT__c,GENRTN_2_GRP_RMOVL_CNT__c,
                            TOTAL_TAR_CNT__c,SPPY_ACTVTY_PCT__c,MRKT_TAG_2_ANLYSS_BUS_AMT__c,GENRTN_2_GRP_PD_SLS_AMT__c,
                            TOTAL_PRSNL_ABV_MIN_CNT__c,Representative__c,MRKT_TAG_1_QLFR_NR__c,GENRTN_2_GRP_PAST_DUE_AMT__c,
                            TOTAL_PRMOTD_CNT__c,PRSNL_AWRD_SLS_AMT__c,MRKT_TAG_1_ANLYSS_SLS_NR__c,GENRTN_2_GRP_ORD_UND_MIN_CNT__c,
                            TOTAL_PATD_CNT__c,PRIOR_CMPGN_AVG_ORD_WITH_MULTS__c,MRKT_TAG_1_ANLYSS_ORDS_NR__c,GENRTN_2_GRP_ORD_RCVD_CNT__c,
                            TOTAL_INACTV_3_CMPGN_CNT__c,PC_TOTAL_ORD_RCVD__c,MRKT_TAG_1_ANLYSS_BUS_NR__c,GENRTN_2_GRP_ORD_PENDNG_CNT__c,
                            TOTAL_INACTV_2_CMPGN_CNT__c,PC_RTURN_ORD_CNT__c,MRKT_ID__c,GENRTN_2_GRP_ORD_ABV_MIN_CNT__c,
                            TOTAL_INACTV_1_CMPGN_CNT__c,PC_OUT_ZONE_GRP_STF_CNT__c,MRKT_ACCT_KEY__c,GENRTN_2_GRP_NO_ORD_CNT__c,
                            TOTAL_GRP_TITL_CHNG_CNT__c,PC_NO_DEMO_CNT__c,LastModifiedDate,GENRTN_2_GRP_NET_SLS_AMT__c,
                            TOTAL_GRP_RMOVL_CNT__c,PC_NO_BRCHR_CNT__c,LastModifiedById,GENRTN_2_GRP_INHRTD_CNT__c,
                            TOTAL_GRP_PAST_DUE_AMT__c,PC_NEW_REP_1ST_ORD_CNT__c,LOA_1_6_STF_CNT__c,GENRTN_2_GRP_HOLD_ORD_CNT__c,
                            TOTAL_GRP_ADDS_CNT__c,PC_MULT_ORD_CNT__c,IsDeleted,GENRTN_2_GRP_CUST_CNT__c,
                            TOTAL_GRP_ABV_MIN_CNT__c,PC_MRKT_TAG_4_PRFRMNC_PCT__c,Id,GENRTN_2_GRP_AWRD_SLS_AMT__c,
                            TOTAL_GENRTN_1_STF_CNT__c,PC_MRKT_TAG_4_ANLYSS_SLS_TXT__c,IN_ZONE_SPPY_GRP_STF_CNT__c,GENRTN_2_GRP_AVG_CUST_CNT__c,
                            TOTAL_CTT_CNT__c,PC_MRKT_TAG_4_ANLYSS_ORDS_TXT__c,IN_ZONE_GENRTN_3_GRP_STF_CNT__c,GENRTN_2_GRP_APPT_CNT__c,
                            TOTAL_BRTHDY_CNT__c,PC_MRKT_TAG_4_ANLYSS_BUS_TXT__c,IN_ZONE_GENRTN_2_GRP_STF_CNT__c,GENRTN_2_GRP_ADDS_CNT__c,
                            TOTAL_BAL_AMT__c,PC_MRKT_TAG_3_PRFRMNC_TXT__c,IN_ZONE_GENRTN_1_GRP_STF_CNT__c,GENRTN_2_FRST_ORD_CNT__c,
                            TOTAL_BAD_DEBT_AMT__c,PC_MRKT_TAG_3_ANLYSS_SLS_PCT__c,IN_ZONE_CC_GRP_STF_CNT__c,GENRTN_2_CNT_RTURN_ORD_CNT__c,
                            TOTAL_AVON_ANNIV_CNT__c,PC_MRKT_TAG_3_ANLYSS_ORDS_PCT__c,INACTV_3_CMPGN_UQ_TITL_1_CNT__c,GENRTN_2_BRTHDY_CNT__c,
                            TITL_5_WO_TOP_SLR_TITL_CNT__c,PC_MRKT_TAG_3_ANLYSS_BUS_PCT__c,INACTV_3_CMPGN_TITL_5_CNT__c,GENRTN_2_BLW_MIN_AWRD_SLS_AMT__c,
                            TITL_5_WO_PATD_CNT__c,PC_MRKT_TAG_2_PRFRMNC_TXT__c,INACTV_3_CMPGN_TITL_4_CNT__c,GENRTN_2_BAL_AMT__c,
                            TITL_5_TOP_SLR_CNT__c,PC_MRKT_TAG_2_ANLYSS_SLS_AMT__c,INACTV_3_CMPGN_TITL_3_CNT__c,GENRTN_2_BAD_DEBT_AMT__c,
                            TITL_5_TAR_CNT__c,PC_MRKT_TAG_2_ANLYSS_ORDS_AMT__c,INACTV_3_CMPGN_TITL_2_CNT__c,GENRTN_2_AVON_ANNIV_CNT__c,
                            TITL_5_STF_CNT__c,PC_MRKT_TAG_2_ANLYSS_BUS_AMT__c,INACTV_3_CMPGN_TITL_1_CNT__c,GENRTN_1_WK4_MULT_ORD_CNT__c,
                            TITL_5_PRSNL_ABV_MIN_CNT__c,PC_MRKT_TAG_1_PRFRMNC_AMT__c,INACTV_2_CMPGN_UQ_TITL_1_CNT__c,GENRTN_1_WK3_MULT_ORD_CNT__c,
                            TITL_5_PRMOTD_CNT__c,PC_MRKT_TAG_1_ANLYSS_SLS_NR__c,INACTV_2_CMPGN_TITL_5_CNT__c,GENRTN_1_WK2_MULT_ORD_CNT__c,
                            TITL_5_PATD_CNT__c,PC_MRKT_TAG_1_ANLYSS_ORDS_NR__c,INACTV_2_CMPGN_TITL_4_CNT__c,GENRTN_1_WK1_MULT_ORD_CNT__c,
                            TITL_5_GRP_ABV_MIN_CNT__c,PC_MRKT_TAG_1_ANLYSS_BUS_NR__c,INACTV_2_CMPGN_TITL_3_CNT__c,GENRTN_1_UQ_TITL_1_STF_CNT__c,
                            TITL_5_CTT_CNT__c,PC_IN_ZONE_GRP_STF_CNT__c,INACTV_2_CMPGN_TITL_2_CNT__c,GENRTN_1_TITL_5_STF_CNT__c,
                            TITL_5_AT_RSK_CNT__c,PC_GRP_RTURN_AMT__c,INACTV_2_CMPGN_TITL_1_CNT__c,GENRTN_1_TITL_4_STF_CNT__c,
                            TITL_4_WO_TOP_SLR_TITL_CNT__c,PC_GRP_RNSTMT_CNT__c,INACTV_1_CMPGN_UQ_TITL_1_CNT__c,GENRTN_1_TITL_3_STF_CNT__c,
                            TITL_4_WO_PATD_CNT__c,PC_GRP_RMOVL_CNT__c,INACTV_1_CMPGN_TITL_5_CNT__c,GENRTN_1_TITL_2_STF_CNT__c,
                            TITL_4_TOP_SLR_CNT__c,PC_GRP_PD_SLS_AMT__c,INACTV_1_CMPGN_TITL_4_CNT__c,GENRTN_1_TITL_1_STF_CNT__c,
                            TITL_4_TAR_CNT__c,PC_GRP_PAST_DUE_AMT__c,INACTV_1_CMPGN_TITL_3_CNT__c,GENRTN_1_NO_DEMO_ITEM_CNT__c,
                            TITL_4_STF_CNT__c,PC_GRP_ORD_UND_MIN_CNT__c,INACTV_1_CMPGN_TITL_2_CNT__c,GENRTN_1_NO_BRCHR_CNT__c,
                            TITL_4_PRSNL_ABV_MIN_CNT__c,PC_GRP_ORD_PENDNG_CNT__c,INACTV_1_CMPGN_TITL_1_CNT__c,GENRTN_1_NEW_REP_1ST_ORD_CNT__c,
                            TITL_4_PRMOTD_CNT__c,PC_GRP_ORD_ON_HOLD_CNT__c,GRP_PTNTL_ERNGS_AMT__c,GENRTN_1_MULT_ORD_CNT__c,
                            TITL_4_PATD_CNT__c,PC_GRP_ORD_ABV_MIN_CNT__c,GRP_ORD_UND_MIN_CNT__c,GENRTN_1_MRKT_TAG_4_PRFRMNC_PC__c,
                            TITL_4_GRP_ABV_MIN_CNT__c,PC_GRP_NO_ORD_CNT__c,GRP_ORD_ABV_MIN_CNT__c,GENRTN_1_MRKT_TAG_4_PRFRMNC_PCT__c,
                            TITL_4_CTT_CNT__c,PC_GRP_NET_SLS_AMT__c,GENRTN_3_WK4_MULT_ORD_CNT__c,GENRTN_1_MRKT_TAG_3_PRFRMNC_TX__c,
                            TITL_4_AT_RSK_CNT__c,PC_GRP_INHRTD_CNT__c,GENRTN_3_WK3_MULT_ORD_CNT__c,GENRTN_1_MRKT_TAG_2_PRFRMNC_TX__c,
                            TITL_3_WO_TOP_SLR_TITL_CNT__c,PC_GRP_ERNGS_PD_AMT__c,GENRTN_3_WK2_MULT_ORD_CNT__c,GENRTN_1_MRKT_TAG_1_PRFRMNC_AM__c,
                            TITL_3_WO_PATD_CNT__c,PC_GRP_CUST_CNT__c,GENRTN_3_WK1_MULT_ORD_CNT__c,GENRTN_1_MRKT_TAG_1_PRFRMNC_AMT__c,
                            TITL_3_TOP_SLR_CNT__c,PC_GRP_AWRD_SLS_AMT__c,GENRTN_3_NO_DEMO_ITEM_CNT__c,GENRTN_1_GRP_TITL_PROMTD_CNT__c,
                            TITL_3_TAR_CNT__c,PC_GRP_AVG_CUST_CNT__c,GENRTN_3_NO_BRCHR_CNT__c,GENRTN_1_GRP_TITL_DMTD_CNT__c,
                            TITL_3_STF_CNT__c,PC_GRP_APPT_CNT__c,GENRTN_3_NEW_REP_1ST_ORD_CNT__c,GENRTN_1_GRP_TITL_CHNG_CNT__c,
                            TITL_3_PRSNL_ABV_MIN_CNT__c,PC_BLW_MIN_AWRD_SLS_AMT__c,GENRTN_3_MULT_ORD_CNT__c,GENRTN_1_GRP_RTURN_AMT__c,
                            TITL_3_PRMOTD_CNT__c,PC_ACTVTY_PCT__c,GENRTN_3_MRKT_TAG_4_PRFRMNC_PC__c,GENRTN_1_GRP_RNSTMT_CNT__c,
                            TITL_3_PATD_CNT__c,PC_ABV_MIN_AWRD_SLS_AMT__c,GENRTN_3_MRKT_TAG_4_PRFRMNC_PCT__c,GENRTN_1_GRP_RMOVL_CNT__c,
                            TITL_3_GRP_ABV_MIN_CNT__c,OwnerId,GENRTN_3_MRKT_TAG_3_PRFRMNC_TX__c,GENRTN_1_GRP_PD_SLS_AMT__c,
                            TITL_3_CTT_CNT__c,OUT_ZONE_SPPY_GRP_STF_CNT__c,GENRTN_3_MRKT_TAG_2_PRFRMNC_TX__c,GENRTN_1_GRP_PAST_DUE_AMT__c,
                            TITL_3_AT_RSK_CNT__c,OUT_ZONE_GENRTN_3_GRP_STF_CNT__c,GENRTN_3_MRKT_TAG_1_PRFRMNC_AM__c,GENRTN_1_GRP_ORD_UND_MIN_CNT__c,
                            TITL_2_WO_TOP_SLR_TITL_CNT__c,OUT_ZONE_GENRTN_2_GRP_STF_CNT__c,GENRTN_3_MRKT_TAG_1_PRFRMNC_AMT__c,GENRTN_1_GRP_ORD_RCVD_CNT__c,
                            TITL_2_WO_PATD_CNT__c,OUT_ZONE_GENRTN_1_GRP_STF_CNT__c,GENRTN_3_GRP_TITL_PROMTD_CNT__c,GENRTN_1_GRP_ORD_PENDNG_CNT__c,
                            TITL_2_TOP_SLR_CNT__c,OUT_ZONE_CC_GRP_STF_CNT__c,GENRTN_3_GRP_TITL_DMTD_CNT__c,GENRTN_1_GRP_ORD_ABV_MIN_CNT__c,
                            TITL_2_TAR_CNT__c,OPERTNL_CMPGN_NR__c,GENRTN_3_GRP_TITL_CHNG_CNT__c,GENRTN_1_GRP_NO_ORD_CNT__c,
                            TITL_2_STF_CNT__c,Name,GENRTN_3_GRP_RTURN_AMT__c,GENRTN_1_GRP_NET_SLS_AMT__c,
                            TITL_2_PRSNL_ABV_MIN_CNT__c,NEG_NET_SLS_DWNLN_STF_CNT__c,GENRTN_3_GRP_RNSTMT_CNT__c,GENRTN_1_GRP_INHRTD_CNT__c,
                            TITL_2_PRMOTD_CNT__c,NC_TOTAL_ORD_RCVD__c,GENRTN_3_GRP_RMOVL_CNT__c,GENRTN_1_GRP_HOLD_ORD_CNT__c,
                            TITL_2_PATD_CNT__c,NC_TOTAL_MULT_ORD_CNT__c,GENRTN_3_GRP_PD_SLS_AMT__c,GENRTN_1_GRP_CUST_CNT__c,
                            TITL_2_GRP_ABV_MIN_CNT__c,NC_RTURN_ORD_CNT__c,GENRTN_3_GRP_PAST_DUE_AMT__c,GENRTN_1_GRP_AWRD_SLS_AMT__c,
                            TITL_2_CTT_CNT__c,NC_OUT_ZONE_GRP_STF_CNT__c,GENRTN_3_GRP_ORD_UND_MIN_CNT__c,GENRTN_1_GRP_AVG_CUST_CNT__c,
                            TITL_2_AT_RSK_CNT__c,NC_NO_DEMO_CNT__c,GENRTN_3_GRP_ORD_RCVD_CNT__c,GENRTN_1_GRP_APPT_CNT__c,
                            TITL_1_WO_TOP_SLR_TITL_CNT__c,NC_NO_BRCHR_CNT__c,GENRTN_3_GRP_ORD_PENDNG_CNT__c,GENRTN_1_GRP_ADDS_CNT__c,
                            TITL_1_WO_PATD_CNT__c,NC_NEW_REP_1ST_ORD_CNT__c,GENRTN_3_GRP_ORD_ABV_MIN_CNT__c,GENRTN_1_FRST_ORD_CNT__c,
                            TITL_1_TOP_SLR_CNT__c,NC_MULT_ORD_CNT__c,GENRTN_3_GRP_NO_ORD_CNT__c,GENRTN_1_CNT_RTURN_ORD_CNT__c,
                            TITL_1_TAR_CNT__c,NC_MRKT_TAG_4_PRFRMNC_PCT__c,GENRTN_3_GRP_NET_SLS_AMT__c,GENRTN_1_BRTHDY_CNT__c,
                            TITL_1_STF_CNT__c,NC_MRKT_TAG_3_PRFRMNC_TXT__c,GENRTN_3_GRP_INHRTD_CNT__c,GENRTN_1_BLW_MIN_AWRD_SLS_AMT__c,
                            TITL_1_PRSNL_ABV_MIN_CNT__c,NC_MRKT_TAG_2_PRFRMNC_TXT__c,GENRTN_3_GRP_HOLD_ORD_CNT__c,GENRTN_1_BAL_AMT__c,
                            GENRTN_1_BAD_DEBT_AMT__c,CC_TOTAL_HOLD_ORD_CNT__c,CC_GRP_RMOVL_CNT__c,ActionItem_Inherited_Count__c,
                            GENRTN_1_AVON_ANNIV_CNT__c,CC_TOTAL_GRP_ORD_UND_MIN_CNT__c,CC_GRP_PD_SLS_AMT__c,ActionItem_Downline_Changes__c,
                            DWNLN_POSTV_NET_CHNG_CNT__c,CC_RTURN_ORD_CNT__c,CC_GRP_PAST_DUE_AMT__c,ActionItem_BDay_Annv_Count__c,
                            DWNLN_NEG_NET_CHNG_CNT__c,CC_NO_DEMO_CNT__c,CC_GRP_ORD_UND_MIN_CNT__c,AVG_ORD_WITH_MULTS_AMT__c,
                            DETL_LDRSHP_MRKT_TAG_4_TXT__c,CC_NO_BRCHR_CNT__c,CC_GRP_ORD_PENDNG_CNT__c,ACTVTY_PCT__c,
                            DETL_LDRSHP_MRKT_TAG_3_PCT__c,CC_NEW_REP_1ST_ORD_CNT__c,CC_GRP_ORD_ON_HOLD_CNT__c,ACCT_PAST_DUE_CNT__c,
                            DETL_LDRSHP_MRKT_TAG_2_NR__c,CC_MULT_ORD_CNT__c,CC_GRP_ORD_ABV_MIN_CNT__c,ACCT_NR__c,
                            DETL_LDRSHP_MRKT_TAG_1_AMT__c,CC_MRKT_TAG_4_PRFRMNC_PCT__c,CC_GRP_NO_ORD_CNT__c,ABV_MIN_AWRD_SLS_AMT__c ,
                            CurrencyIsoCode,CC_MRKT_TAG_3_PRFRMNC_TXT__c,CC_GRP_NET_SLS_AMT__c,
                            CreatedDate,CC_MRKT_TAG_2_PRFRMNC_TXT__c,CC_GRP_CUST_CNT__c,
                            CreatedById,CC_MRKT_TAG_1_PRFRMNC_AMT__c,CC_GRP_AWRD_SLS_AMT__c,
                            CRNCY_CD__c,CC_GRP_TITL_PROMTD_CNT__c,CC_GRP_AVG_CUST_CNT__c,
                            CC_TOTAL_ORD_RCVD__c,CC_GRP_TITL_DMTD_CNT__c,CC_GRP_APPT_CNT__c,
                            CC_TOTAL_ORD_PENDING_CNT__c,CC_GRP_TITL_CHNG_CNT__c,CC_GENRTN_1_GRP_STF_CNT__c,
                            CC_GRP_RNSTMT_CNT__c,CC_GRP_RTURN_AMT__c,CC_BLW_MIN_AWRD_SLS_AMT__c,
                            INACTV_1_CMPGN_NON_LDR_CNT__c,INACTV_2_CMPGN_NON_LDR_CNT__c,INACTV_3_CMPGN_NON_LDR_CNT__c,
                            NON_LDR_TOP_SLR_CNT__c,NON_LDR_WO_TOP_SLR_TITL_CNT__c,RTURN_SLS_REP_CNT__c,
                            PAST_DUE_REP_CNT__c,PRSNL_SLS_BLW_QLFR_REP_CNT__c,GRP_QLFR_SLS_AMT__c,PRSNL_QLFR_SLS_AMT__c,NC_ACTVTY_PCT__c           
                    From Leader_Downline_Summary__c
                    where MRKT_ACCT_KEY__c = :repMktAcctNbr
                ];
            
            
            this.market = [ Select  My_Bus_SPPY_Enabled__c, My_Bus_PC_Enabled__c, 
                                    My_Bus_NC_Enabled__c, My_Bus_CC_Enabled__c,
                                    Market_Id__c 
                                    From Market__c
                            where   Market_Id__c=:currUsr.MRKT_ID__c];
            List<MyBusiness_Row_Config__c> configList = [Select     Market__c,Same_Time_Last_Year_Fld__c, Row_Type__c, 
                                                                    Prior_Campaign_Fld__c, Next_Campaign_Fld__c, 
                                                                    Is_Market_Tag__c, Data_Type__c,Current_Campaign_Fld__c,
                                                                    Reverse_Trending_Arrows__c 
                                                            From MyBusiness_Row_Config__c 
                                                            where Market__r.Market_Id__c=:currUsr.MRKT_ID__c];
            List<String> mktTagSubjAreas = new List<String>();
            mktTagSubjAreas.add('Ldr-My Business');
            MarketTagUtils mktTags = new MarketTagUtils();
            mktTags.initialize(mktTagSubjAreas);
            My_Business_Row__c currRow;
            SObject sObj = currRec;
            myBusinessRows = new List<MyBusinessRowWrapper>();
            Boolean oddRow=true;
            for(MyBusiness_Row_Config__c cfg: configList){
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>> My Bus Row Config: '+cfg);
                currRow = new My_Business_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
                currRow.Data_Type__c = cfg.Data_Type__c;
                currRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
                if(!cfg.Is_Market_Tag__c){
                    currRow.Row_Label__c = cfg.Row_Type__c;
                }else{
                    System.debug('&&&&&&&&&&&&&&&&&&& Before Change Label...='+currRow.Row_Label__c);
                    currRow.Row_Label__c = mktTags.getLabel('Ldr-My Business',cfg.Row_Type__c);
                    System.debug('&&&&&&&&&&&&&&&&&&& After Change Label.....='+currRow.Row_Label__c);
                }
                /*
                    If Currency or Number with Decimals, map it to XC_Amt__c field
                */
                System.debug('&&&&&&&&&&&&&&&&&&& Data_Type__c='+cfg.Data_Type__c);
                if(cfg.Data_Type__c == 'Currency'){
                    if(cfg.Current_Campaign_Fld__c!=null)
                        currRow.CC_Amt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld__c);
                    if(cfg.Prior_Campaign_Fld__c!=null)
                        currRow.PC_Amt__c = (Decimal)sObj.get(cfg.Prior_Campaign_Fld__c);
                    if(cfg.Same_Time_Last_Year_Fld__c!=null)
                        currRow.SPPY_Amt__c = (Decimal)sObj.get(cfg.Same_Time_Last_Year_Fld__c);
                    if(cfg.Next_Campaign_Fld__c!=null)
                        currRow.NC_Amt__c = (Decimal)sObj.get(cfg.Next_Campaign_Fld__c);
                }else if(cfg.Data_Type__c == 'Number'){
                    if(cfg.Current_Campaign_Fld__c!=null)
                        currRow.CC_Cnt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld__c);
                    if(cfg.Prior_Campaign_Fld__c!=null)
                        currRow.PC_Cnt__c = (Decimal)sObj.get(cfg.Prior_Campaign_Fld__c);
                    if(cfg.Same_Time_Last_Year_Fld__c!=null)
                        currRow.SPPY_Cnt__c = (Decimal)sObj.get(cfg.Same_Time_Last_Year_Fld__c);
                    if(cfg.Next_Campaign_Fld__c!=null)
                        currRow.NC_Cnt__c = (Decimal)sObj.get(cfg.Next_Campaign_Fld__c);
                }else{
                    if(cfg.Current_Campaign_Fld__c!=null)
                        currRow.CC_Txt__c = (String)sObj.get(cfg.Current_Campaign_Fld__c);
                    if(cfg.Prior_Campaign_Fld__c!=null)
                        currRow.PC_Txt__c = (String)sObj.get(cfg.Prior_Campaign_Fld__c);
                    if(cfg.Same_Time_Last_Year_Fld__c!=null)
                        currRow.SPPY_Txt__c = (String)sObj.get(cfg.Same_Time_Last_Year_Fld__c);
                    if(cfg.Next_Campaign_Fld__c!=null)
                        currRow.NC_Txt__c = (String)sObj.get(cfg.Next_Campaign_Fld__c);
                    
                }
                myBusinessRows.add(new MyBusinessRowWrapper(currRow,cfg.Reverse_Trending_Arrows__c));
                
        
                if(cfg.Row_Type__c == 'Award Sales'){
                    awardSalesLabel = currRow.Row_Label__c;
                    this.awardSales = currRow;  
                }
   
                if(cfg.Row_Type__c == 'Net Sales'){
                    netSalesLabel = currRow.Row_Label__c;
                    this.netSales = currRow;    
                }
                System.debug('>>>>>>>>>>>>>>>>>>>>>>MyBusiness Rows :'+myBusinessRows);
                oddRow = !oddRow;
            }
        return null;
    }
    
    public Integer getEnabledColCount(){
        Integer colCount = 1;
        try{
            if(this.market.My_Bus_SPPY_Enabled__c){
                colCount+=2;
            }   
            if(this.market.My_Bus_PC_Enabled__c){
                colCount+=2;
            }   
            if(this.market.My_Bus_NC_Enabled__c){
                colCount+=1;
            }   
            if(this.market.My_Bus_CC_Enabled__c){
                colCount+=1;
            }
        }catch(Exception ex){
            //ErrorHandler.handleError('MyBusiness', ex);
            return -1;
        }   
        return colCount;    
    }
    
    public static testmethod void testMyBusiness(){
        MyBusinessController ctlr = new MyBusinessController();
        String mktIdKey = 'TEST123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createLeaderUser('123456');
        List<My_Business__c> myBusData = testData.createMyBusinessData(testUsr.MRKT_ID_ACCT_NR_KEY__c,testUsr.Id);  
        List<Leader_Downline_Summary__c> ldrData = testData.createLdrSmryData(testUsr.MRKT_ID_ACCT_NR_KEY__c,testUsr.Id);
        List<MyBusiness_Row_Config__c> rowCfg = testData.createMyBusinessConfig();
        System.runAs(testUsr){
            ctlr.init();
            System.assert(ctlr.getEnabledColCount()==7);
        }
    }
}
			                            	