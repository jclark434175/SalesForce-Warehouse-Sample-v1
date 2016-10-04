public class testMyMessageController {

    public static testMethod void test_testMyMessageController () {
      TestDataHelper testdata = new TestDataHelper();
      testData.createMarket();
      Market__c mkt = testData.market;

    User ldrUsr = testData.createLeaderUser('123456789z');
    Task mktTask = testData.createMarketTask();
    testData.createTaskForUser(ldrUsr);
        PageReference sigpage = new PageReference('/apex/MyMessage');
        Test.setCurrentPage(sigpage);

    System.runAs(ldrUsr){        
          MyMessageController controller = new MyMessageController();
          controller.getbroadcast();
          controller.getTasks();
          //Task t=[Select id from Task where id=:tsks.id]; 
    
          PageReference sigpage2 = new PageReference('/apex/MyMessageDetail?id='+ mktTask.Id);
          Test.setCurrentPage(sigpage2);
          
          MyMessageDetailController controller2 = new MyMessageDetailController ();
          controller2.init();    
    }    
    }
}
			                            	