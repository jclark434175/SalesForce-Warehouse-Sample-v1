public class CampaignReportsController {
  public User currUsr{ get; private set;}
  public PageReference init(){
    //System.debug('>>>>>>>>>>>>>> Campaign Reports Controller:init() called');
    currUsr =   [  select   ACCT_NR__c,MRKT_ID_ACCT_NR_KEY__c,
                MRKT_ID__c,LanguageLocaleKey
            from  User
             where  Id = :UserInfo.getUserId()];
    return null;
  }
  
  public static testmethod void testCampaignReports(){
    CampaignReportsController ctlr = new CampaignReportsController();
    String mktId = '123456';
    Datetime currDt = System.now();
    TestDataHelper testData = new TestDataHelper();
    User ldrUsr = testData.createLeaderUser(mktId);
    System.runAs(ldrUsr){
      ctlr.init();
      System.assert(ctlr.currUsr.ACCT_NR__c==ldrUsr.ACCT_NR__c);    
    }
  }
}
			                            	