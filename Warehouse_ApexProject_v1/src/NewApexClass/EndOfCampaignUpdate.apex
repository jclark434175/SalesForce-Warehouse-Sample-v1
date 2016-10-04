public class EndOfCampaignUpdate {
  public Integer recCnt {get; set;}
  public Datetime startTime {get; private set;}
  public Datetime endTime {get; private set;}
  public String marketId {get; set;}
  public Integer batchsize {get; set;}
  public Integer recMax {get; set;}
  public Datetime lastRowDtTime {get; private set;}
  public List<String> logs {get; private set;}
  private Integer batchCount;
  private Integer recInBatch;
  private Boolean isComplete;
  private static String BASE_SOQL = 
      ' select   SystemModstamp,Id,CurrencyIsoCode,MRKT_ACCT_KEY__c,ACCT_NR__c,MRKT_CD__c,MRKT_CMPGN_KEY__c,CRNCY_CD__c,OPERTNL_CMPGN_NR__c,AWRD_SLS_AMT__c,'+
      ' PC_AWRD_SLS_AMT__c,SPPY_AWRD_SLS_AMT__c,AVG_AWRD_SLS_AMT__c,NC_AWRD_SLS_AMT__c,PC_AVG_AWRD_SLS_AMT__c,SPPY_CMPGN_AVG_AWRD_SLS_AMT__c,'+
      ' NC_AVG_AWRD_SLS_AMT__c,NET_SLS_AMT__c,PC_NET_SLS_AMT__c,SPPY_NET_SLS_AMT__c,NC_NET_SLS_AMT__c,MULT_ORD_CNT__c,PC_MULT_ORD_CNT__c,'+
      ' SPPY_MULT_ORD_CNT__c,NC_MULT_ORD_CNT__c,PAST_DUE_AMT__c,PC_PAST_DUE_AMT__c,SPPY_PAST_DUE_AMT__c,NC_PAST_DUE_AMT__c,ORD_HOLD_AMT__c,'+
      ' PC_ORD_HOLD_AMT__c,SPPY_ORD_HOLD_AMT__c,NC_ORD_HOLD_AMT__c,GENRTN_1_APPT_CNT__c,PC_GENRTN_1_APPT_CNT__c,SPPY_GENRTN_1_APPT_CNT__c,'+
      ' NC_GENRTN_1_APPT_CNT__c,CUST_CNT__c,PC_CUST_CNT__c,SPPY_CUST_CNT__c,NC_CUST_CNT__c,RTURN_NET_SLS_AMT__c,PC_RTURN_NET_SLS_AMT__c,'+
      ' SPPY_RTURN_NET_SLS_AMT__c,NC_RTURN_NET_SLS_AMT__c,RTURN_AWRD_SLS_AMT__c,PC_RTURN_AWRD_SLS_AMT__c,NC_RTURN_AWRD_SLS_AMT__c,'+
      ' SPPY_RTURN_AWRD_SLS_AMT__c,LAST_PYMT_RECVD_AMT__c,BAL_DUE_AMT__c,PC_BAL_DUE_AMT__c,SPPY_BAL_DUE_AMT__c,NC_BAL_DUE_AMT__c,CTD_AWRD_SLS_AMT__c,'+
      ' ERNGS_PD_AMT__c,PC_ERNGS_PD_AMT__c,SPPY_ERNGS_PD_AMT__c,NC_ERNGS_PD_AMT__c,YTD_ERNGS_AMT__c,PRFRMNC_POINT_QTY__c,MIN_PRSNL_SLS_REQD_AMT__c,'+
      ' YTD_APPT_CNT__c,YTD_RNSTMT_CNT__c,YTD_AWRD_SLS_AMT__c,YTD_NET_SLS_AMT__c,YTD_RTURN_NET_SLS_AMT__c,YTD_CUST_SERVD_CNT__c,PAST_DUE_CMPGN_CNT__c,'+
      ' ORD_SRCE_DESC_TXT__c,GRP_APPT_CNT__c,GRP_RNSTMT_CNT__c,GRP_RMOVL_CNT__c,MLPLN_CLOSD_IND__c,PC_ORD_SBMTD_AMT__c,SPPY_ORD_SBMTD_AMT__c,'+
      ' ORD_INVCD_CNT__c,ORD_INVCD_AMT__c,PC_ORD_INVCD_CNT__c,PC_ORD_INVCD_AMT__c,SPPY_ORD_INVCD_CNT__c,SPPY_ORD_INVCD_AMT__c,ORD_CNCLD_CNT__c,'+
      ' ORD_CNCLD_AMT__c,PC_ORD_CNCLD_CNT__c,PC_ORD_CNCLD_AMT__c,SPPY_ORD_CNCLD_CNT__c,SPPY_ORD_CNCLD_AMT__c,ORD_ON_HOLD_CNT__c,PC_ORD_ON_HOLD_CNT__c,'+
      ' SPPY_ORD_ON_HOLD_CNT__c,NC_GENRTN_1_RMOVL_CNT__c,NC_GENRTN_1_RNSTMT_CNT__c,GENRTN_1_RMOVL_CNT__c,PC_GENRTN_1_RMOVL_CNT__c,'+
      ' SPPY_GENRTN_1_RMOVL_CNT__c,GENRTN_1_RNSTMT_CNT__c,PC_GENRTN_1_RNSTMT_CNT__c,SPPY_GENRTN_1_RNSTMT_CNT__c,DEMO_ITEM_ORDRD_CNT__c,'+
      ' PC_DEMO_ITEM_ORDRD_CNT__c,SPPY_DEMO_ITEM_ORDRD_CNT__c,DEMO_AMT__c,PC_DEMO_AMT__c,SPPY_DEMO_AMT__c,BRCHR_CNT__c,PC_BRCHR_CNT__c,'+
      ' SPPY_BRCHR_CNT__c,BRCHR_AMT__c,PC_BRCHR_AMT__c,SPPY_BRCHR_AMT__c,BAD_DEBT_AMT__c,PC_BAD_DEBT_AMT__c,SPPY_BAD_DEBT_AMT__c,REP_STUS_CD__c,'+
      ' PC_REP_STUS_CD__c,SPPY_REP_STUS_CD__c,REP_TITL_STUS_CD__c,PC_REP_TITL_STUS_CD__c,SPPY_REP_TITL_STUS_CD__c,NC_ORD_SBMTD_AMT__c,'+
      ' NC_ORD_INVCD_CNT__c,NC_ORD_INVCD_AMT__c,NC_ORD_CNCLD_CNT__c,NC_ORD_CNCLD_AMT__c,NC_ORD_ON_HOLD_CNT__c,NC_TITL_CHNGD_CNT__c,NC_ORD_STUS_CNT__c,'+
      ' NC_DEMO_ITEM_ORDRD_CNT__c,NC_DEMO_AMT__c,NC_BRCHR_CNT__c,NC_BRCHR_AMT__c,NC_BAD_DEBT_AMT__c,NC_REP_STUS_CD__c,NC_REP_TITL_STUS_CD__c,'+
      ' NC_UPLN_CNT__c,TITL_CHNGD_CNT__c,UPLN_CNT__c,MY_ACCT_MRKT_TAG_1_KPI__c,MY_ACCT_MRKT_TAG_2_KPI__c,PRSNL_SLS_MRKT_TAG_1_KPI__c,'+
      ' PRSNL_SLS_MRKT_TAG_2_KPI__c,PRSNL_SLS_MRKT_TAG_3_KPI__c,MY_BUS_MRKT_TAG_1_AMT__c,MY_BUS_MRKT_TAG_2_AMT__c,MY_BUS_MRKT_TAG_3_TXT__c,'+
      ' MY_BUS_MRKT_TAG_4_TXT__c,MY_BUS_MRKT_TAG_5_TXT__c,MY_BUS_MRKT_TAG_6_PCT__c,NC_MY_BUS_MRKT_TAG_1_AMT__c,NC_MY_BUS_MRKT_TAG_2_AMT__c,'+
      ' NC_MY_BUS_MRKT_TAG_3_TXT__c,NC_MY_BUS_MRKT_TAG_4_TXT__c,NC_MY_BUS_MRKT_TAG_5_TXT__c,NC_MY_BUS_MRKT_TAG_6_PCT__c,PC_MY_BUS_MRKT_TAG_1_AMT__c,'+
      ' PC_MY_BUS_MRKT_TAG_2_AMT__c,PC_MY_BUS_MRKT_TAG_3_TXT__c,PC_MY_BUS_MRKT_TAG_4_TXT__c,PC_MY_BUS_MRKT_TAG_5_TXT__c,PC_MY_BUS_MRKT_TAG_6_PCT__c,'+
      ' SPPY_MY_BUS_MRKT_TAG_1_AMT__c,SPPY_MY_BUS_MRKT_TAG_2_AMT__c,SPPY_MY_BUS_MRKT_TAG_3_TXT__c,SPPY_MY_BUS_MRKT_TAG_4_TXT__c,'+
      ' SPPY_MY_BUS_MRKT_TAG_5_TXT__c,SPPY_MY_BUS_MRKT_TAG_6_PCT__c,PD_SLS_AMT__c'+
      ' from  My_Business__c '+
      ' where MRKT_CD__c = :mktId';
      
  public PageReference init(){
    this.marketId = ApexPages.currentPage().getParameters().get('mktId');
    this.batchSize = Integer.valueOf(ApexPages.currentPage().getParameters().get('batchSize'));
    this.recMax = Integer.valueOf(ApexPages.currentPage().getParameters().get('recMax'));
    if(this.logs ==null){
      this.logs = new List<String>();
    }
    if(batchCount==null){
      batchCount=1;
    }
    if(isComplete==null){
      isComplete=false;
    }
    return start();
  }
  public PageReference start(){
    transient List<My_Business__c> myBusToUpdate = new List<My_Business__c>();
    SavePoint savePoint = Database.setSavePoint();
    recCnt = 0;
    String soqlToRun = BASE_SOQL;
    if(this.lastRowDtTime!=null){
      soqlToRun += ' and SytemModTimestamp > :rowDtTime';
    }
    soqlToRun +=' limit :maxRecords';
    String mktId = this.marketId;
    Datetime rowDtTime = this.lastRowDtTime;
    Integer maxRecords = this.recMax;
    startTime = System.now();
    logs.add('[Batch '+batchCount+'] START - '+startTime);
    recInBatch=0;
    for(My_Business__c myBus:Database.query(soqlToRun))
    {
      recCnt++;
      recInBatch++;    
      if(myBusToUpdate.size()==batchsize){
        update myBusToUpdate;
        myBusToUpdate = new List<My_Business__c>();
        endTime = System.now();  
        logs.add('[Batch '+batchCount+'] THROUGHPUT - '+(recInBatch/(endTime.getTime()-startTime.getTime())));
        logs.add('[Batch '+batchCount+'] END - '+endTime);
        batchCount++;
        recInBatch=0;
        startTime = System.now();
        logs.add('[Batch '+batchCount+'] START - '+startTime);
      }
      myBus.AWRD_SLS_AMT__c=myBus.NC_AWRD_SLS_AMT__c;
      myBus.AVG_AWRD_SLS_AMT__c=myBus.NC_AVG_AWRD_SLS_AMT__c;
      myBus.NET_SLS_AMT__c=myBus.NC_NET_SLS_AMT__c;
      myBus.MULT_ORD_CNT__c=myBus.NC_MULT_ORD_CNT__c;
      myBus.PAST_DUE_AMT__c=myBus.NC_PAST_DUE_AMT__c;
      myBus.ORD_HOLD_AMT__c=myBus.NC_ORD_HOLD_AMT__c;
      myBus.CUST_CNT__c=myBus.NC_CUST_CNT__c;
      myBus.RTURN_NET_SLS_AMT__c=myBus.NC_RTURN_NET_SLS_AMT__c;
      myBus.LAST_PYMT_RECVD_AMT__c=myBus.NC_ORD_ON_HOLD_CNT__c;
      myBus.BAL_DUE_AMT__c=myBus.NC_BAL_DUE_AMT__c;
      myBus.ERNGS_PD_AMT__c=myBus.NC_ERNGS_PD_AMT__c;
  
      myBus.NC_AWRD_SLS_AMT__c=0.0;
      myBus.NC_AVG_AWRD_SLS_AMT__c=0.0;
      myBus.NC_NET_SLS_AMT__c=0.0;
      myBus.NC_MULT_ORD_CNT__c=0.0;
      myBus.NC_PAST_DUE_AMT__c=0.0;
      myBus.NC_ORD_HOLD_AMT__c=0.0;
      myBus.NC_CUST_CNT__c=0.0;
      myBus.NC_RTURN_NET_SLS_AMT__c=0.0;
      myBus.NC_ORD_ON_HOLD_CNT__c=0.0;
      myBus.NC_BAL_DUE_AMT__c=0.0;
      myBus.NC_ERNGS_PD_AMT__c=0.0;
      myBusToUpdate.add(myBus);
      lastRowDtTime=myBus.SystemModstamp;
    }  
    update myBusToUpdate;
    endTime = System.now();
    logs.add('[Batch '+batchCount+'] END - '+endTime);
    
    Database.rollback(savePoint);
    return null;
  }
  
  public static testmethod void testEndOfCmpgnUpdate(){
    List<My_Business__c> recs = new List<My_Business__c>();
    
        My_Business__c rec;
        for(Integer i=0;i<5;i++){
          rec = new My_Business__c(MRKT_ACCT_KEY__c='XX12345'+i,
                                                AWRD_SLS_AMT__c=100.00,
                                                PC_AWRD_SLS_AMT__c=80.000,
                                                SPPY_AWRD_SLS_AMT__c=100.00,
                                                MY_BUS_MRKT_TAG_4_TXT__c='Some text',
                                                CUST_CNT__c=100,
                                                ORD_UND_MIN_IND__c='Y',
                                                CurrencyISOCode='USD',
                                                OwnerId=UserInfo.getUserId(),
                                                MRKT_CD__c='XX'
                                                );
          recs.add(rec);
        }
        insert recs;

    EndOfCampaignUpdate ctlr=new EndOfCampaignUpdate();
    PageReference pageRef = new PageReference('/apex/EndOfCampaignUpdate?mktId=XX&batchSize=1&recMax=2');
    Test.setCurrentPageReference(pageRef);
    ctlr.init();
    //ctlr.start();   
  }
}
			                            	