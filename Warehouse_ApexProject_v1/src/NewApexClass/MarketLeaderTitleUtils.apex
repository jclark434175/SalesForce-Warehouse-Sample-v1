public class MarketLeaderTitleUtils {
  private Map<String,String> ldrTitles = new Map<String,String>();

  public void initialize(User currUser){
    ldrTitles = new Map<String,String>();
    for(Leader_Title__c ldrTitle :[  Select  Market__c, MRKT_TAG_QLFR_3_NR__c, LDRSHP_TITL_LVL_NR__c, 
                        LCL_LDRSHP_TITL_LANG_DESC_TXT__c, 
                        LCL_LDRSHP_TITL_CD__c, LANG_CD__c, GENRTN_3_MIN_ORD_AMT__c, 
                        GENRTN_3_ERNGS_PCT__c, GENRTN_2_MIN_ORD_AMT__c, 
                        GENRTN_2_ERNGS_PCT__c, GENRTN_1_MIN_ORD_AMT__c, 
                        GENRTN_1_ERNGS_PCT__c
                    From   Leader_Title__c
                    where  Market__r.Market_Id__c=:currUser.MRKT_ID__c
                    and    LANG_CD__c=:currUser.LanguageLocaleKey])
    {
      ldrTitles.put(ldrTitle.LDRSHP_TITL_LVL_NR__c,ldrTitle.LCL_LDRSHP_TITL_LANG_DESC_TXT__c);
    }
  }    


  public List<Leader_Title__c> initializeAndRetList(User currUser){
    ldrTitles = new Map<String,String>();
    List<Leader_Title__c> tempLdrList = new List<Leader_Title__c>();
    for(Leader_Title__c ldrTitle :[  Select  Market__c, MRKT_TAG_QLFR_3_NR__c, LDRSHP_TITL_LVL_NR__c, 
                        LCL_LDRSHP_TITL_LANG_DESC_TXT__c, 
                        LCL_LDRSHP_TITL_CD__c, LANG_CD__c, GENRTN_3_MIN_ORD_AMT__c, 
                        GENRTN_3_ERNGS_PCT__c, GENRTN_2_MIN_ORD_AMT__c, 
                        GENRTN_2_ERNGS_PCT__c, GENRTN_1_MIN_ORD_AMT__c, 
                        GENRTN_1_ERNGS_PCT__c
                    From   Leader_Title__c
                    where  Market__r.Market_Id__c=:currUser.MRKT_ID__c
                    and    LANG_CD__c=:currUser.LanguageLocaleKey
                    order by LDRSHP_TITL_LVL_NR__c asc])
    {
      tempLdrList.add(ldrTitle);
      ldrTitles.put(ldrTitle.LDRSHP_TITL_LVL_NR__c,ldrTitle.LCL_LDRSHP_TITL_LANG_DESC_TXT__c);
    }
    return tempLdrList;
  }    

  public Leader_Title__c initializeAndRetTitle(User currUser,String lvlNbr){
    ldrTitles = new Map<String,String>();
    Leader_Title__c leaderTitl;
    for(Leader_Title__c ldrTitle :[  Select  Market__c, MRKT_TAG_QLFR_3_NR__c, LDRSHP_TITL_LVL_NR__c, 
                        LCL_LDRSHP_TITL_LANG_DESC_TXT__c, 
                        LCL_LDRSHP_TITL_CD__c, LANG_CD__c, GENRTN_3_MIN_ORD_AMT__c, 
                        GENRTN_3_ERNGS_PCT__c, GENRTN_2_MIN_ORD_AMT__c, 
                        GENRTN_2_ERNGS_PCT__c, GENRTN_1_MIN_ORD_AMT__c, 
                        GENRTN_1_ERNGS_PCT__c
                    From   Leader_Title__c
                    where  Market__r.Market_Id__c=:currUser.MRKT_ID__c
                    and    LANG_CD__c=:currUser.LanguageLocaleKey])
    {
      if(lvlNbr == ldrTitle.LDRSHP_TITL_LVL_NR__c){
        leaderTitl = ldrTitle;  
      }
      ldrTitles.put(ldrTitle.LDRSHP_TITL_LVL_NR__c,ldrTitle.LCL_LDRSHP_TITL_LANG_DESC_TXT__c);
    }
    return leaderTitl;
  }    

  public void initialize(User currUser,String titleLevel){
    ldrTitles = new Map<String,String>();
    for(Leader_Title__c ldrTitle :[  Select  Market__c, MRKT_TAG_QLFR_3_NR__c, LDRSHP_TITL_LVL_NR__c, 
                        LCL_LDRSHP_TITL_LANG_DESC_TXT__c, 
                        LCL_LDRSHP_TITL_CD__c, LANG_CD__c, GENRTN_3_MIN_ORD_AMT__c, 
                        GENRTN_3_ERNGS_PCT__c, GENRTN_2_MIN_ORD_AMT__c, 
                        GENRTN_2_ERNGS_PCT__c, GENRTN_1_MIN_ORD_AMT__c, 
                        GENRTN_1_ERNGS_PCT__c
                    From   Leader_Title__c
                    where  Market__r.Market_Id__c=:currUser.MRKT_ID__c
                    and    LANG_CD__c=:currUser.LanguageLocaleKey
                    and    LDRSHP_TITL_LVL_NR__c = :titleLevel])
    {
      ldrTitles.put(ldrTitle.LDRSHP_TITL_LVL_NR__c,ldrTitle.LCL_LDRSHP_TITL_LANG_DESC_TXT__c);
    }
  }    
  
  public String getLeaderTitle(String titleLevelNbr){
    return this.ldrTitles.get(titleLevelNbr);
  }


    public static testmethod void testLeaderTitles(){
    MarketLeaderTitleUtils ctlr = new MarketLeaderTitleUtils();
    TestDataHelper testData = new TestDataHelper();
    testData.createLeaderTitles();
    User testUsr = testData.createLeaderUser('123456');
    System.runAs(testUsr){
      ctlr.initialize(testUsr);
      System.assert(ctlr.getLeaderTitle('1')=='Title 1');
      List<Leader_Title__c> tempList = ctlr.initializeAndRetList(testUsr);
      System.assert(tempList.size()==6);
      
      ctlr.initialize(testUsr,'1');
      System.assert(ctlr.getLeaderTitle('1')=='Title 1');
      ctlr.initialize(testUsr,'1');
      System.assert(ctlr.getLeaderTitle('1')=='Title 1');
      System.assert(ctlr.initializeAndRetTitle(testUsr,'1').LCL_LDRSHP_TITL_LANG_DESC_TXT__c=='Title 1');
    }
      
    }
  

}
			                            	