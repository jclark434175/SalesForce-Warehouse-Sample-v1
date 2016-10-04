public class MarketReportLinks {

  public String marketId {get; set;}
  public String rpt2Display {get; set;}
  public String userProfile {get; set;}
  public Integer nbrMPlans {get; set;} 
  public List<Report_Config__c> reportList {get; set;}
  public String getInitialize(){
    Market__c market = [select Mail_Plan_Enabled__c,Action_Item_Mail_Plans__c 
              from Market__c 
              where Market_Id__c=:this.marketId];
    if(market.Mail_Plan_Enabled__c){
      this.nbrMplans = Integer.valueOf(market.Action_Item_Mail_Plans__c+'');
    }
    
    this.userProfile = [select Name from Profile where Id = :UserInfo.getProfileId()].Name;

    if(rpt2Display!=null && rpt2Display.length()>0){
      String[] rptNames = rpt2Display.split(',');
      reportList = [  select Id,Report_Id__c,Name,
                  Report_Type__c
              from Report_Config__c
              where Market__r.Market_Id__c=:this.marketId
              and Report_Type__c in :rptNames
              and Applicable_To__c includes (:userProfile)
              order by Name
            ];
    
    }else{
      reportList = [  select Id,Report_Id__c,Name,
                  Report_Type__c
              from Report_Config__c
              where Market__r.Market_Id__c=:this.marketId
              and Applicable_To__c includes (:userProfile)
              order by Name
            ];
    
    }
    return '';
  }
  
  public static testmethod void testMktReportLinks(){
    TestDataHelper testData = new TestDataHelper();
    User ldrUser = testData.createLeaderUser('LDR1');
    testData.createReportConfig();
    MarketReportLinks ctlr = new MarketReportLinks();
    ctlr.rpt2Display = 'Test1,Test2';
    ctlr.marketId = testData.market.Market_Id__c;
    System.runAs(ldrUser){
      ctlr.getInitialize();
      System.assert(ctlr.reportList.size()==2);
    }
    ctlr.rpt2Display = '';
    ctlr.marketId = testData.market.Market_Id__c;
    System.runAs(ldrUser){
      ctlr.getInitialize();
      System.assertEquals(ctlr.reportList.size(),5);
    }
  }
}
			                            	