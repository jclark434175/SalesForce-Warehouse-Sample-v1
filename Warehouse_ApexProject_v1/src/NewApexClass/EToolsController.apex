public class EToolsController {
  public Integer dayOfYear {get; private set;}
  public Integer currYear {get; private set;}
  public Market__c market {get; private set;}
  public PageReference init(){
    Date currDt = System.today();
    dayOfYear = currDt.dayOfYear();
    currYear = currDt.year();
    User currUsr =   [  select   ACCT_NR__c,MRKT_ID_ACCT_NR_KEY__c,MRKT_ID__c
            from  User
             where  Id = :UserInfo.getUserId()];
    this.market = [  Select   Name,Id 
            From Market__c
            where  Market_Id__c=:currUsr.MRKT_ID__c];
             
    return null;
  }
  
  public static testmethod void testETools(){
    EToolsController ctlr = new EToolsController();
    TestDataHelper testData = new TestDataHelper();
    testData.createMarket();
    User testUsr = testData.createLeaderUser('test123');
    System.runAs(testUsr){
      ctlr.init();
      System.assert(ctlr.dayOfYear == System.Today().dayOfYear());
      System.assert(ctlr.currYear == System.Today().year());  
    }  
  }
}
			                            	