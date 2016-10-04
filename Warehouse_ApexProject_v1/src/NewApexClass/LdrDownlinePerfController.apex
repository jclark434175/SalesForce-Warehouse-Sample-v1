public class LdrDownlinePerfController {

    public List<MyBusinessRowWrapper> myBusinessRows {get; set;}
    public List<MyBusinessRowWrapper> myPerfRows {get; set;}
    public Market__c market {get; set;}
    public String repAcctNbr {get; set;}
    public String mktCode {get; set;}
    private String salesChartDataJson;
    private String orderChartDataJson;
    private GoogleViz ordersChartData;
    /*
    Labels for the Downline Award Sales chart
    */
    public String salesChartTitle {get; set;}
    public String salesChart1stGen {get; set;}
    public String salesChart2ndGen {get; set;}
    public String salesChart3rdGen {get; set;}
    public String chartCurrent {get; set;}
    public String chartPrior {get; set;}

    /*
    Labels for the Orders chart
    */
    public String ordersChartTitle {get; set;}
    public String achMinLbl {get; set;}
    public String undMinLbl  {get; set;}
    public String pendLbl{get; set;}
    public String onHldLbl {get; set;}

    public Leader_Title__c currTitle {get; set;}
    
    public String getInitialize(){
            Leader_Downline_Summary__c currRec = [
                                    select
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
                                        PAST_DUE_REP_CNT__c,PRSNL_SLS_BLW_QLFR_REP_CNT__c,CC_GRP_AWD_SLS_QLFR__c,
                                        PC_GENRTN_1_GRP_AWRD_SLS_AMT__c,PC_GENRTN_2_GRP_AWRD_SLS_AMT__c,PC_GENRTN_3_GRP_AWRD_SLS_AMT__c,
                                        GENRTN_1_ACTVTY_PCT__c,GENRTN_2_ACTVTY_PCT__c,GENRTN_3_ACTVTY_PCT__c,GRP_QLFR_SLS_AMT__c,PRSNL_QLFR_SLS_AMT__c,NC_ACTVTY_PCT__c            
                                    From Leader_Downline_Summary__c
                                    where   MRKT_ACCT_KEY__c=:this.repAcctNbr];
        User currUsr = [select MRKT_ID__c,LanguageLocaleKey from User 
                        where Id=:UserInfo.getUserId()];
        
        String usrLangCd = currUsr.LanguageLocaleKey;
        
                                    
        this.market = [ Select  Id,Market_Id__c,Downline_Perf_SPPY_Enabled__c, Downline_Perf_PC_Enabled__c, 
                                Downline_Perf_NC_Enabled__c, Downline_Perf_CC_Enabled__c,
                                Downline_Perf_CC_Gen1_Enabled__c,Downline_Perf_CC_Gen2_Enabled__c,
                                Downline_Perf_CC_Gen3_Enabled__c,Current_Perf_Next_Level_Enabled__c
                                From Market__c 
                        where   Market_Id__c=:currUsr.MRKT_ID__c];
                        
       // Changed by Snehashis Ghosh on 04 September, 2009 added in SOQL {Prior_Campaign_Fld_1st_Gen__c,Prior_Campaign_Fld_2nd_Gen__c,Prior_Campaign_Fld_3rd_Gen__c}                 
        List<Ldr_Downline_Perf_Row_Config__c> configList = [Select  Market__c,Same_Time_Last_Year_Fld__c, Row_Type__c, 
                                                                Prior_Campaign_Fld__c, Next_Campaign_Fld__c, 
                                                                Is_Market_Tag__c, Data_Type__c,Current_Campaign_Fld__c,
                                                                Current_Campaign_Fld_1stGen__c,Current_Campaign_Fld_2ndGen__c,
                                                                Current_Campaign_Fld_3rdGen__c,Reverse_Trending_Arrows__c
                                                        From    Ldr_Downline_Perf_Row_Config__c 
                                                        where Market__r.Market_Id__c=:currUsr.MRKT_ID__c];
        Contact repContact = [  select Id,Name,LDRSHP_TITL_LVL_NBR__c
                                from  Contact
                                where MRKT_ACCT_KEY__c=:this.repAcctNbr];
        System.debug('>>>>>>>>>>>>>>>>repContact = '+repContact);
        List<Leader_Title__c> ldrTitles = [Select   Market__c, GENRTN_1_ERNGS_PCT__c,
                                                    GENRTN_1_MIN_ORD_AMT__c,
                                                    GENRTN_2_ERNGS_PCT__c,
                                                    GENRTN_2_MIN_ORD_AMT__c,
                                                    GENRTN_3_ERNGS_PCT__c,
                                                    GENRTN_3_MIN_ORD_AMT__c,
                                                    LANG_CD__c,
                                                    LCL_LDRSHP_TITL_CD__c,
                                                    LCL_LDRSHP_TITL_LANG_DESC_TXT__c,
                                                    LDRSHP_TITL_LVL_NR__c,
                                                    MIN_FRST_LVL_TITL_REQD_NR__c,
                                                    MIN_GRP_SLS_REQD_AMT__c,
                                                    MIN_PRSNL_SLS_REQD_AMT__c,
                                                    MIN_REP_RCRTMNTS_REQD_NR__c,
                                                    MIN_SCN_LVL_TITL_REQD_NR__c,
                                                    MIN_THRD_LVL_TITL_REQD_NR__c,
                                                    MRKT_ID__c,
                                                    MRKT_LDRSHP_TITL_LANG_CD__c,
                                                    MRKT_TAG_QLFR_1_NR__c,
                                                    MRKT_TAG_QLFR_2_NR__c,
                                                    MRKT_TAG_QLFR_3_NR__c
                                            From    Leader_Title__c
                                            where   LDRSHP_TITL_LVL_NR__c>=:repContact.LDRSHP_TITL_LVL_NBR__c
                                            and     LANG_CD__c=:usrLangCd
                                            and     Market__r.Market_Id__c=:currUsr.MRKT_ID__c
                                            ORDER BY LDRSHP_TITL_LVL_NR__c ASC
                                            LIMIT 2] ;
        Leader_Title__c nextTitle;
        if(ldrTitles.size()>0){
            this.currTitle = ldrTitles[0];
        }
        if(ldrTitles.size()==2){
            nextTitle = ldrTitles[1];
        }       
        System.debug('>>>>>>>>>>>>>>>>currTitle = '+currTitle);
        System.debug('>>>>>>>>>>>>>>>>nextTitle = '+nextTitle);
        myPerfRows = new List<MyBusinessRowWrapper>();          
        My_Business_Row__c currRow;
        
        List<String> mktTagSubjAreas = new List<String>();
        mktTagSubjAreas.add('Ldr-Downline Performance');
        mktTagSubjAreas.add('Ldr-Current Performance');
        MarketTagUtils mktTags = new MarketTagUtils();
        mktTags.initialize(mktTagSubjAreas,this.market.Market_Id__c,usrLangCd);
        
        Boolean oddRow=true;
        for(Current_Performance_Config__c perfCfg :[    Select  Row_Type__c, Next_Level_Fld__c, Market__c, 
                                                            Data_Type__c, Current_Perf_Fld__c,Is_Market_Tag__c
                                                    From    Current_Performance_Config__c 
                                                    where   Market__r.Market_Id__c=:currUsr.MRKT_ID__c]){
            currRow = new My_Business_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
            currRow.Data_Type__c = perfCfg.Data_Type__c;
            currRow.Is_Market_Tag__c = perfCfg.Is_Market_Tag__c;
            /*
            Current Performance : Screen mapping
            ==============================================
            CC_Amt__c = Current Performance
            NC_Amt__c = Amt for Next Level from the Next Title record
            PC_Amt__c = Amt for Current Title record
            
            */
            if(!perfCfg.Is_Market_Tag__c){
                currRow.Row_Label__c = perfCfg.Row_Type__c;
            }else{
                currRow.Row_Label__c = mktTags.getLabel('Ldr-Current Performance',perfCfg.Row_Type__c);
            }           
            if(perfCfg.Data_Type__c=='Currency'){
                if(perfCfg.Current_Perf_Fld__c!=null)
                    currRow.CC_Amt__c = (Decimal)currRec.get(perfCfg.Current_Perf_Fld__c);
                if(nextTitle !=null && perfCfg.Next_Level_Fld__c!=null)
                    currRow.NC_Amt__c = (Decimal)nextTitle.get(perfCfg.Next_Level_Fld__c);
                if(currTitle !=null && perfCfg.Next_Level_Fld__c!=null)
                    currRow.PC_Amt__c = (Decimal)currTitle.get(perfCfg.Next_Level_Fld__c);
            }
            if(perfCfg.Data_Type__c=='Number'){
                if(perfCfg.Current_Perf_Fld__c!=null)
                    currRow.CC_Cnt__c = (Decimal)currRec.get(perfCfg.Current_Perf_Fld__c);
                if(nextTitle !=null && perfCfg.Next_Level_Fld__c!=null)
                    currRow.NC_Cnt__c = (Decimal)nextTitle.get(perfCfg.Next_Level_Fld__c);
                if(currTitle !=null && perfCfg.Next_Level_Fld__c!=null)
                    currRow.PC_Cnt__c = (Decimal)currTitle.get(perfCfg.Next_Level_Fld__c);
            }
            myPerfRows.add(new MyBusinessRowWrapper(currRow));
            oddRow = !oddRow;
        }   
        System.debug('>>>>>>>>>>>>>>>>myPerfRows = '+myPerfRows);
                                        
        SObject sObj = currRec;
        myBusinessRows = new List<MyBusinessRowWrapper>();
        oddRow = true;
        
        for(Ldr_Downline_Perf_Row_Config__c cfg: configList){
            currRow = new My_Business_Row__c(Odd_Row__c=oddRow,CurrencyIsoCode=currRec.CurrencyIsoCode);
            currRow.Data_Type__c = cfg.Data_Type__c;
            currRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
            if(!cfg.Is_Market_Tag__c){
                currRow.Row_Label__c = cfg.Row_Type__c;
            }else{
                currRow.Row_Label__c = mktTags.getLabel('Ldr-Downline Performance',cfg.Row_Type__c);
            }
            if(cfg.Data_Type__c == 'Currency'){
                if(cfg.Current_Campaign_Fld__c!=null)
                    currRow.CC_Amt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld__c);
                if(cfg.Prior_Campaign_Fld__c!=null)
                    currRow.PC_Amt__c = (Decimal)sObj.get(cfg.Prior_Campaign_Fld__c);
                if(cfg.Same_Time_Last_Year_Fld__c!=null)
                    currRow.SPPY_Amt__c = (Decimal)sObj.get(cfg.Same_Time_Last_Year_Fld__c);
                if(cfg.Current_Campaign_Fld_1stGen__c!=null)
                    currRow.CC_1st_Gen_amt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld_1stGen__c);
                if(cfg.Current_Campaign_Fld_2ndGen__c!=null)
                    currRow.CC_2nd_Gen_Amt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld_2ndGen__c);
                if(cfg.Current_Campaign_Fld_3rdGen__c!=null)
                    currRow.CC_3rd_Gen_Amt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld_3rdGen__c);
                if(cfg.Next_Campaign_Fld__c!=null)
                    currRow.NC_Amt__c = (Decimal)sObj.get(cfg.Next_Campaign_Fld__c);
                    
                //Changed by Snehashis Ghosh on 08 Sep 2009
                  currRow.PC_1st_Gen_Amt__c = currRec.PC_GENRTN_1_GRP_AWRD_SLS_AMT__c;
                  currRow.PC_2nd_Gen_Amt__c = currRec.PC_GENRTN_2_GRP_AWRD_SLS_AMT__c;
                  currRow.PC_3rd_Gen_Amt__c = currRec.PC_GENRTN_3_GRP_AWRD_SLS_AMT__c;
                  
                 // end by Snehashis Ghosh   
                 
            }else if(cfg.Data_Type__c == 'Number'){
                if(cfg.Current_Campaign_Fld__c!=null)
                    currRow.CC_Cnt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld__c);
                if(cfg.Prior_Campaign_Fld__c!=null)
                    currRow.PC_Cnt__c = (Decimal)sObj.get(cfg.Prior_Campaign_Fld__c);
                if(cfg.Same_Time_Last_Year_Fld__c!=null)
                    currRow.SPPY_Cnt__c = (Decimal)sObj.get(cfg.Same_Time_Last_Year_Fld__c);
                if(cfg.Current_Campaign_Fld_1stGen__c!=null)
                    currRow.CC_1nd_Gen_Cnt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld_1stGen__c);
                if(cfg.Current_Campaign_Fld_2ndGen__c!=null)
                    currRow.CC_2nd_Gen_Cnt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld_2ndGen__c);
                if(cfg.Current_Campaign_Fld_3rdGen__c!=null)
                    currRow.CC_3rd_Gen_Cnt__c = (Decimal)sObj.get(cfg.Current_Campaign_Fld_3rdGen__c);
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
                if(cfg.Current_Campaign_Fld_1stGen__c!=null)
                    currRow.CC_1st_Gen_Txt__c = (String)sObj.get(cfg.Current_Campaign_Fld_1stGen__c);
                if(cfg.Current_Campaign_Fld_2ndGen__c!=null)
                    currRow.CC_2nd_Gen_Txt__c = (String)sObj.get(cfg.Current_Campaign_Fld_2ndGen__c);
                if(cfg.Current_Campaign_Fld_3rdGen__c!=null)
                    currRow.CC_3rd_Gen_Txt__c = (String)sObj.get(cfg.Current_Campaign_Fld_3rdGen__c);
                
            }
            myBusinessRows.add(new MyBusinessRowWrapper(currRow,cfg.Reverse_Trending_Arrows__c));
            
            if(cfg.Row_Type__c =='Group Award Sales'){
                setSalesChartData(currRow);
            }
            /*
             Order Chart Data configuration
            */
            if(currRow.Row_Label__c =='Orders Under Minimum'){
                System.debug('>>>>>>>>>> Orders Under Min = '+currRow);
                addOrdersChartData(currRow,this.undMinLbl); 
            }
            if(currRow.Row_Label__c =='Orders Achieving Minimum'){
                System.debug('>>>>>>>>>> Orders Ach Min = '+currRow);
                addOrdersChartData(currRow,this.achMinLbl); 
            }
            if(currRow.Row_Label__c =='Orders on Hold'){
                System.debug('>>>>>>>>>> Orders On Hold = '+currRow);
                addOrdersChartData(currRow,this.onHldLbl); 
            }
            oddRow = !oddRow;
        }
        /*
        TODO: Add Total of Orders to "Orders chart"
        */
        if(ordersChartData != null){
            orderChartDataJson = this.ordersChartData.toJSONString();
        }
        return '';
    }
    
    public Integer getEnabledColCount(){
        Integer colCount = 1;
        if(this.market.Downline_Perf_SPPY_Enabled__c){
            colCount+=2;
        }   
        if(this.market.Downline_Perf_PC_Enabled__c){
            colCount+=2;
        }   
        if(this.market.Downline_Perf_NC_Enabled__c){
            colCount+=1;
        }   
        if(this.market.Downline_Perf_CC_Enabled__c){
            colCount+=1;
        }
        if(this.market.Downline_Perf_CC_Gen1_Enabled__c){
            colCount+=1;
        }
        if(this.market.Downline_Perf_CC_Gen2_Enabled__c){
            colCount+=1;
        }
        if(this.market.Downline_Perf_CC_Gen3_Enabled__c){
            colCount+=1;
        }
        return colCount;    
    }
    
    private void setSalesChartData(My_Business_Row__c awardSales){
        GoogleViz viz = new GoogleViz();
        viz.cols = new List<GoogleViz.col>();
        viz.cols.add(new GoogleViz.Col('col1', 'Generation', 't'));
        viz.cols.add(new GoogleViz.Col('col2', this.chartCurrent, 'n'));
        if(this.market.Downline_Perf_PC_Enabled__c){ 
          viz.cols.add(new GoogleViz.Col('col3', this.chartPrior, 'n'));
        }
        
        GoogleViz.row r = new GoogleViz.row();
        r.cells.add ( new GoogleViz.cell( this.salesChart1stGen)); 
        r.cells.add ( new GoogleViz.cell( awardSales.CC_1st_Gen_Amt__c) ); 
        // Changed by Snehashis Ghosh on 04 Sep, 2009  [Old Code <<r.cells.add ( new GoogleViz.cell( awardSales.PC_Amt__c) );>>]
        if(this.market.Downline_Perf_PC_Enabled__c){ 
          r.cells.add ( new GoogleViz.cell( awardSales.PC_1st_Gen_Amt__c) ); 
        }
        viz.addRow( r );
        r = new GoogleViz.row();
        r.cells.add ( new GoogleViz.cell( this.salesChart2ndGen)); 
        r.cells.add ( new GoogleViz.cell( awardSales.CC_2nd_Gen_Amt__c) ); 
        // Changed by Snehashis Ghosh on 04 Sep, 2009  [Old Code <<r.cells.add ( new GoogleViz.cell( awardSales.PC_Amt__c) );>>] 
        if(this.market.Downline_Perf_PC_Enabled__c){ 
          r.cells.add ( new GoogleViz.cell( awardSales.PC_2nd_Gen_Amt__c) ); 
        }
        viz.addRow( r );
        r = new GoogleViz.row();
        r.cells.add ( new GoogleViz.cell( this.salesChart3rdGen)); 
        r.cells.add ( new GoogleViz.cell( awardSales.CC_3rd_Gen_Amt__c) ); 
         // Changed by Snehashis Ghosh on 04 Sep, 2009  [Old Code <<r.cells.add ( new GoogleViz.cell( awardSales.PC_Amt__c) );>>] 
        if(this.market.Downline_Perf_PC_Enabled__c){ 
          r.cells.add ( new GoogleViz.cell( awardSales.PC_3rd_Gen_Amt__c) );
        }
        viz.addRow( r );
      salesChartDataJson = viz.toJSONString();
    }
    
    private void addOrdersChartData(My_Business_Row__c orderData,String label){
        if(this.ordersChartData == null){
            this.ordersChartData = new GoogleViz();
            this.ordersChartData.cols = new List<GoogleViz.col>();
            this.ordersChartData.cols.add(new GoogleViz.Col('col1', 'Generation', 't'));
            this.ordersChartData.cols.add(new GoogleViz.Col('col2', this.chartCurrent, 'n'));
            if(this.market.Downline_Perf_PC_Enabled__c){
              this.ordersChartData.cols.add(new GoogleViz.Col('col3', this.chartPrior, 'n'));
            }
        }

        GoogleViz.row r;
        r = new GoogleViz.row();
        r.cells.add ( new GoogleViz.cell(label)); 
        r.cells.add ( new GoogleViz.cell( orderData.CC_Cnt__c ));
        if(this.market.Downline_Perf_PC_Enabled__c){
          r.cells.add ( new GoogleViz.cell( orderData.PC_Cnt__c ));
        } 
        this.ordersChartData.addRow( r );
                    
    }
    
    public String getSalesChartData(){
        return salesChartDataJson;  
    }
    public String getOrderChartData(){
        return this.orderChartDataJson; 
    }   
    
    public static testmethod void testLdrDownlinePerf(){
        LdrDownlinePerfController ctlr = new LdrDownlinePerfController();
        String mktIdKey = '123456';
        TestDataHelper testData = new TestDataHelper();
        User testUsr = testData.createLeaderUser(mktIdKey);
        Contact ct = testData.createContact(mktIdKey,testUsr.Id);
        testData.createLdrPerfConfig();
        testData.createCurrPerfConfig();
        List<Leader_Downline_Summary__c> ldrData = testData.createLdrSmryData(testUsr.MRKT_ID_ACCT_NR_KEY__c,testUsr.Id);
        testData.createLdrPerfConfig();
        ctlr.repAcctNbr = testUsr.MRKT_ID_ACCT_NR_KEY__c;
        System.runAs(testUsr){
            ctlr.getInitialize();
            System.assert(ctlr.getEnabledColCount()==10);
            System.debug(ctlr.getSalesChartData());
            System.debug(ctlr.getOrderChartData());
            //System.assert(ctlr.getSalesChartData()=='{cols: [{id: "col1", label: "Generation", type: "t"},{id: "col2", label: "null", type: "n"},{id: "col3", label: "null", type: "n"}], rows: [[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}]]}');
            //System.assert(ctlr.getOrderChartData()=='{cols: [{id: "col1", label: "Generation", type: "t"},{id: "col2", label: "null", type: "n"},{id: "col3", label: "null", type: "n"}], rows: [[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}],[{v: null},{v: 100.0},{v: 100.0}]]}');
        }
            
    }
}
			                            	