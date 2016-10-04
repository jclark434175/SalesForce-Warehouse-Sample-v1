/*
  Represents a row of data that is displayed. 
  Could be used in conjuntion with any object and also maintains the odd/even flag
  that can be used for styling purposes.
*/
public class ObjectRow {
  public SObject record {get; private set;}
  public Boolean oddRow {get; set;}
  public Boolean selected {get; set;}
  public ObjectRow(SObject rec,Boolean oddEven){
    this.record = rec;
    this.oddRow = oddEven;
  }
  
  public EmailTemplate getEmailTemplate(){
    return (EmailTemplate)record;  
  }
  public User_Sales_Org_Hierarchy__c getUserSalesOrg(){
    return (User_Sales_Org_Hierarchy__c)record;  
  }

  public Sales_Organization__c getSalesOrg(){
    return (Sales_Organization__c)record;  
  }
  public String getRecordId(){
    return (String)record.get('Id');  
  }

  public String getSalesOrgCd(){
    return (String)record.get('SLS_ORG_CD__c');  
  }
  public String getSalesOrgLevel(){
    return (String)record.get('SLS_ORG_LVL_NR__c');  
  }
  public static testmethod void testObjectRow(){
    EmailTemplate temp = [select Id,Name from EmailTemplate limit 1];
    ObjectRow row = new ObjectRow(temp,true);
    system.assert(row.getEmailTemplate() == temp);
    TestDataHelper testData = new TestDataHelper();
    User ldr = testData.createLeaderUser('test123');
    List<User_Sales_Org_Hierarchy__c>  tempList = testData.createUsrSlsOrgHrchy(ldr);
    List<Sales_Organization__c>  tempList1 = testData.createSalesOrgs();
    row = new ObjectRow(tempList[0],true);
    System.assert(row.getUserSalesOrg()==tempList[0]);
    system.assert(row.getSalesOrgCd() == tempList[0].SLS_ORG_CD__c);
    system.assert(row.getRecordId() == tempList[0].Id);
    
    row = new ObjectRow(tempList1[0],true);
    system.assert(row.getSalesOrg() == tempList1[0]);
    system.assert(row.getSalesOrgCd() == tempList1[0].SLS_ORG_CD__c);
    system.assert(row.getSalesOrgLevel() == tempList1[0].SLS_ORG_LVL_NR__c);
    system.assert(row.getRecordId() == tempList1[0].Id);
    
  }
}
			                            	