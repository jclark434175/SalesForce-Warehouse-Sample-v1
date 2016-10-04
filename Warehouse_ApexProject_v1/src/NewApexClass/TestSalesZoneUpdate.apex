public class TestSalesZoneUpdate {
  
  public static testmethod void testSalesZoneUpdate(){
    TestDataHelper testData = new TestDataHelper();
    User usr = testData.createLeaderUser('TEST123');
    Contact ct = testData.createContact('TEST123',UserInfo.getUserId());
    ct.SLS_ZONE_CD__c='Zone1';
    update ct;
    ct = [select Id,SLS_ZONE_CD__c from Contact where MRKT_ACCT_KEY__c=:usr.MRKT_ID_ACCT_NR_KEY__c];
    //System.assert(ct.SLS_ZONE_CD__c==usr.DFALT_ZONE_CD__c);    
  }
}
			                            	