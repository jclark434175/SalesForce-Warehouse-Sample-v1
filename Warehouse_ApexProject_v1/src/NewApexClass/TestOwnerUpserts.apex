public class TestOwnerUpserts {
  public static testmethod void testMyBusiness(){
    TestDataHelper testData = new TestDataHelper();
    User usr = testData.createLeaderUser('L1234567');
    System.runAs(usr){
      List<My_Business__c> myBusList = testData.createMyBusinessDataWithOwner('L123456');
      System.debug('>>>>>>>>usr.Id='+usr.Id+',myBusList[0].OwnerId='+myBusList[0].OwnerId);
      //System.assert(myBusList[0].OwnerId==usr.Id);
    }
  }

  public static testmethod void testLdrSmry(){
    TestDataHelper testData = new TestDataHelper();
    User usr = testData.createLeaderUser('L1234567');
    System.runAs(usr){
      List<Leader_Downline_Summary__c> myBusList = testData.createLdrSmryDataWithOwner('L123456');
    }
  }

}
			                            	