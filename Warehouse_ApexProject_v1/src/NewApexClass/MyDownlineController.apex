public class MyDownlineController {
  public String repAcctNbr {get; private set;}  

  public PageReference init(){
    String repAcctNbr = ApexPages.currentPage().getParameters().get('repAcctNbr');
    if(repAcctNbr == null || repAcctNbr == ''){
      User currUsr =   [  select   Name,Id,ACCT_NR__c,
                    MRKT_ID_ACCT_NR_KEY__c
                from  User
                where  Id = :UserInfo.getUserId()
              ];
      this.repAcctNbr= currUsr.ACCT_NR__c;
    }
    return null;
  }
  
  public static testmethod void testMyDownline(){
    TestDataHelper testData= new TestDataHelper();
    testData.createMarket();
    User ldrUsr = testData.createLeaderUser('123456');
    MyDownlineController ctlr = new MyDownlineController();
    PageReference pageRef = Page.LeaderMyDownline;
    Test.setCurrentPage(pageRef);
    System.runAs(ldrUsr){
      ctlr.init();
      System.assert(ctlr.repAcctNbr == '123456');
      pageRef.getParameters().put('repAcctNbr',ldrUsr.ACCT_NR__c);
      ctlr.init();
      System.assert(ctlr.repAcctNbr == ldrUsr.ACCT_NR__c);
    }  
  }

}
			                            	