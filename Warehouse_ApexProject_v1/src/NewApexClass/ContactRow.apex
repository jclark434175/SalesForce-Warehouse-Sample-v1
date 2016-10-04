public class ContactRow {
  public Contact contact {get; set;}
  public String title {get; set;}
  public ContactRow(Contact ct,String title){
    this.contact = ct;
    this.title = title;
  }
  
  public static testmethod void testContactRow(){
    TestDataHelper testData = new TestDataHelper();
    Contact ct = testData.createContact('test123',UserInfo.getUserId());
    ContactRow row = new ContactRow(ct,'Title');
    System.assert(row.contact == ct);  
  }
    
}
			                            	