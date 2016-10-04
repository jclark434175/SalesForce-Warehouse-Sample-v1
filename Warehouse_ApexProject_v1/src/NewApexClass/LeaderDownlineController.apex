public class LeaderDownlineController {
  public String repAcctNbr {get; set;} 
  public PageReference init(){
    this.repAcctNbr = ApexPages.currentPage().getParameters().get('repAcctNbr');
    if(repAcctNbr == null || repAcctNbr == ''){
      this.repAcctNbr =   [  select   MRKT_ID_ACCT_NR_KEY__c
                from  User
                where  Id = :UserInfo.getUserId()
              ].MRKT_ID_ACCT_NR_KEY__c;
    }
    return null;
  }
  
  public static testmethod void testLeaderDownline(){
    TestDataHelper testData= new TestDataHelper();
    testData.createMarket();
    User ldrUsr = testData.createLeaderUser('123456');
    LeaderDownlineController ctlr = new LeaderDownlineController();
    PageReference pageRef = Page.LeaderDownline;
    Test.setCurrentPage(pageRef);
    System.runAs(ldrUsr){
      ctlr.init();
      System.assert(ctlr.repAcctNbr == testData.market.Market_Id__c+'123456');
      pageRef.getParameters().put('repAcctNbr','123456');
      ctlr.init();
      System.assert(ctlr.repAcctNbr == '123456');
    }  
  }
}
			                            	