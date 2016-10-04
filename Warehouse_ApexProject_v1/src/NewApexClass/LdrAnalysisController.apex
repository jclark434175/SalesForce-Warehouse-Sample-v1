public class LdrAnalysisController {

  public List<AnalysisBlock> blockList {get; set;}
  public String section {get; private set;}
  private Leader_Downline_Summary__c currRec;
  public String repAcctNbr {get; set;}
  public User currUsr {get; private set;}  
  /*public PageReference showSales(){
    this.section='Sales';
    return null;
  }*/
  public PageReference init(){
    this.repAcctNbr = ApexPages.currentPage().getParameters().get('repAcctNbr');
    
    currUsr = [  select   MRKT_ID__c,MRKT_ID_ACCT_NR_KEY__c,LanguageLocaleKey
          from  User
          where  Id = :UserInfo.getUserId()
        ];
    if(repAcctNbr == null || repAcctNbr == ''){
      this.repAcctNbr =   currUsr.MRKT_ID_ACCT_NR_KEY__c;
    }    
    this.section = ApexPages.currentPage().getParameters().get('section');
    if(this.section == null || this.section == ''){
      this.section='Orders';  
    }
    blockList = new List<AnalysisBlock>();
    this.currRec = 
        [
        Select  YTD_RNSTMT_CNT__c,TITL_1_PRMOTD_CNT__c,NC_MRKT_TAG_1_PRFRMNC_AMT__c,GENRTN_3_GRP_CUST_CNT__c,
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
            PAST_DUE_REP_CNT__c,PRSNL_SLS_BLW_QLFR_REP_CNT__c,      
            GENRTN_1_GRP_NET_CHNG_CNT__c,GENRTN_2_GRP_NET_CHNG_CNT__c,GENRTN_3_GRP_NET_CHNG_CNT__c,CC_GRP_NET_CHNG_CNT__c
          From Leader_Downline_Summary__c
          where MRKT_ACCT_KEY__c = :repAcctNbr
        ];
        
    List<String> mktTagSubjAreas = new List<String>();
    mktTagSubjAreas.add('Ldr-Downline Analysis');
    MarketTagUtils mktTags = new MarketTagUtils();
    mktTags.initialize(mktTagSubjAreas);
        
    MarketLeaderTitleUtils ldrTitlUtils = new MarketLeaderTitleUtils();
    ldrTitlUtils.initialize(currUsr);
        
    AnalysisBlock block = new AnalysisBlock();
    block.displayTotals = false;
    String prevBlock;
    Boolean oddRow = true;
    for(Downline_Analysis_config__c cfg: [  Select   Section__c, Row_Type__c, Market__c, Is_Market_Tag__c,Block__c,
                            Data_Type__c, Col3_Fld__c, Col2_Fld__c, Col1_Fld__c,
                            Is_Title_Tag__c,Report__r.Report_Id__c
                        From   Downline_Analysis_Config__c
                        where  Market__r.Market_Id__c=:currUsr.MRKT_ID__c
                        and    Section__c=:section])
    {
      System.debug('#####################prevBlock:'+prevBlock+',cfg.Block__c:'+cfg.Block__c);
      if((prevBlock!=null && cfg.Block__c != prevBlock)){
        this.blockList.add(block);
        block = new AnalysisBlock();
        block.blockName=cfg.Block__c;
        block.displayTotals = false;
        oddRow = true;
        
      }
      if(cfg.Col1_Fld__c !=null){
        block.col1Enabled = true;
      }        
      if(cfg.Col2_Fld__c !=null){
        block.col2Enabled = true;
      }        
      if(cfg.Col3_Fld__c !=null){
        block.col3Enabled = true;
      }  
      block.blockName=cfg.Block__c;      
      block.addBlockRow(createRow(currRec,cfg,mktTags,ldrTitlUtils,oddRow));
      prevBlock = cfg.Block__c;
      oddRow = !oddRow;
    }
    this.blockList.add(block);
    return null;
        
  }
  
  private AnalysisRow createRow(Leader_Downline_Summary__c currRec,Downline_Analysis_Config__c cfg,
                     MarketTagUtils mktTags,MarketLeaderTitleUtils ldrTitlUtils,Boolean oddRow){
    My_Business_Row__c myBusRow = new My_Business_Row__c(CurrencyIsoCode=currRec.CurrencyIsoCode);
    myBusRow.Data_Type__c = cfg.Data_Type__c;
    myBusRow.Is_Title_Tag__c = cfg.Is_Title_Tag__c;
    myBusRow.Is_Market_Tag__c = cfg.Is_Market_Tag__c;
    if(!cfg.Is_Market_Tag__c && !cfg.Is_Title_Tag__c){
      myBusRow.Row_Label__c = cfg.Row_Type__c;
    }
    
    System.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&cfg.Row_Type__c='+cfg.Row_Type__c+',Is_Title_Tag__c:'+cfg.Is_Title_Tag__c);
    if(cfg.Is_Title_Tag__c){
      String rowType = cfg.Row_Type__c;
      myBusRow.Row_Label__c = ldrTitlUtils.getLeaderTitle(rowType.substring('Title Level '.length()));
    }
    if(cfg.Is_Market_Tag__c){
      myBusRow.Row_Label__c = mktTags.getLabel('Ldr-Downline Analysis',cfg.Row_Type__c);
    }
    
    if(cfg.Data_Type__c == 'Currency'){
      if(cfg.Col1_Fld__c!=null)
        myBusRow.CC_Amt__c = (Decimal)currRec.get(cfg.Col1_Fld__c);
      if(cfg.Col2_Fld__c!=null)
        myBusRow.PC_Amt__c = (Decimal)currRec.get(cfg.Col2_Fld__c);
      if(cfg.Col3_Fld__c!=null)
        myBusRow.NC_Amt__c = (Decimal)currRec.get(cfg.Col3_Fld__c);
    }else if(cfg.Data_Type__c == 'Number'){
      if(cfg.Col1_Fld__c!=null)
        myBusRow.CC_Cnt__c = (Decimal)currRec.get(cfg.Col1_Fld__c);
      if(cfg.Col2_Fld__c!=null)
        myBusRow.PC_Cnt__c = (Decimal)currRec.get(cfg.Col2_Fld__c);
      if(cfg.Col3_Fld__c!=null)
        myBusRow.NC_Cnt__c = (Decimal)currRec.get(cfg.Col3_Fld__c);
    }else{
      if(cfg.Col1_Fld__c!=null)
        myBusRow.CC_Txt__c = (String)currRec.get(cfg.Col1_Fld__c);
      if(cfg.Col2_Fld__c!=null)
        myBusRow.PC_Txt__c = (String)currRec.get(cfg.Col2_Fld__c);
      if(cfg.Col3_Fld__c!=null)
        myBusRow.NC_Txt__c = (String)currRec.get(cfg.Col3_Fld__c);
    }
    System.debug('>>>>>>>>>>>>>>>>>>>>> Row:'+myBusRow);
    return new AnalysisRow(myBusRow,cfg.Report__r.Report_Id__c,oddRow);
  }
  
  public Leader_Downline_Summary__c getCurrentRecord(){
    return this.currRec;  
  }

  public static testmethod void testLeaderAnalysis(){
    LdrAnalysisController ctlr = new LdrAnalysisController();
    String mktIdKey = '123456';
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createLeaderUser(mktIdKey);
    Contact ct = testData.createContact(mktIdKey,testUsr.Id);
    List<Leader_Downline_Summary__c> ldrData = testData.createLdrSmryData(testUsr.MRKT_ID_ACCT_NR_KEY__c,testUsr.Id);
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+testData.createLdrAnalysisConfig());
    ctlr.repAcctNbr = testUsr.MRKT_ID_ACCT_NR_KEY__c;
    PageReference pageRef = new PageReference('/apex/LeaderAnalysis');
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
      System.assert(ctlr.getCurrentRecord().Id == ldrData[0].Id);
    }
          
  }
}
			                            	