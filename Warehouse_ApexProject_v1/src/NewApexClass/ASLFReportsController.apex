public class ASLFReportsController {
  public String repAcctNbr {get; set;}
  public Market__c market {get; private set;}
  public String usrLangCd {get; set;}
  public String dateStr {get; set;}
  
  public String getInitialize(){

    User currUsr =   [  select   ACCT_NR__c,MRKT_ID_ACCT_NR_KEY__c,
                  MRKT_ID__c,LanguageLocaleKey
              from  User
               where  Id = :UserInfo.getUserId()];
  
    this.market = [  select   Name,ASLF_Report_Url__c,ASLF_Market_Id__c,
                ASLF_Timezone_Offset__c,Campaign_Report_Override_URL__c
            from Market__C
            where Market_Id__c=:currUsr.MRKT_ID__c];
    if(currUsr.LanguageLocaleKey == 'en_US'){
      usrLangCd = 'en';  
    }else{
      usrLangCd = currUsr.LanguageLocaleKey;  
    }
    DateTime currDt = System.Now();
    System.debug('>>>>>>>>>>>>>>>>>>>>> currDt='+currDt);
    currDt = currDt.addHours(((Decimal)this.market.ASLF_Timezone_Offset__c).intValue());
    System.debug('>>>>>>>>>>>>>>>>>>>>> after offset currDt='+currDt);
    this.dateStr = currDt.format('MM/dd/yyyy');           
  
    return '';  
  } 
  
  public static testmethod void testASLFReports(){
    ASLFReportsController ctlr = new ASLFReportsController();
    ctlr.repAcctNbr = '123456';
    TestDataHelper testData = new TestDataHelper();
    User ldrUsr = testData.createLeaderUser('123456');
    System.runAs(ldrUsr){
      ctlr.getInitialize();
      System.debug('>>>>>>>>>> Market URL:'+ctlr.market.ASLF_Report_URL__c);
      Datetime currDt= System.now();
      
      System.assert(ctlr.dateStr==currDt.format('MM/dd/yyyy'));  
      System.assert(ctlr.usrLangCd=='en');
      ldrUsr.LanguageLocaleKey='fr';
      update ldrUsr;
      ctlr.getInitialize();
      System.assert(ctlr.usrLangCd=='fr');
        
    }   
  }
}
			                            	