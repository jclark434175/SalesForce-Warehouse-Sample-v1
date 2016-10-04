public class MarketContentController {

  public Boolean isError {get; set;}
  public Market_Content__c mktContent {get; set;}
  private ApexPages.Standardcontroller stdCtlr;
  private static String HELP_TYPE='Help';
  
  public MarketContentController(ApexPages.StandardController ctlr){
    this.stdCtlr=ctlr;
  }

  public PageReference saveContent(){
    Market_Content__c rec = (Market_Content__c)stdCtlr.getRecord(); 
    if((  rec.ALM_Page_Id__c==null || 
        rec.ALM_Page_Id__c=='' ||
        rec.ALM_Page_Id__c.length()==0) &&
      rec.Type__c==HELP_TYPE)
    {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR  , 'ALM Page Id is required for Help'));
      return null;      
    }else{
      return stdCtlr.save();  
    }
  }
  
  public PageReference viewContent(){
    String pagetype = System.currentPageReference().getParameters().get('type');
    String pageId = System.currentPageReference().getParameters().get('pgId');
    System.debug('>>>>>>>>>>>>>>pageType='+pageType+',pageId='+pageId);
    isError=false;  
      User usr = [select MRKT_ID__c,LanguageLocaleKey from User 
              where Id=:UserInfo.getUserId()] ;       
      try{
        if(pageType == HELP_TYPE){
          this.mktContent = [  select Type__c,Content_Type__c,Content__c
                    from Market_Content__c
                    where Type__c=:pageType
                    and ALM_Page_Id__c=:pageId
                    and Market__r.Market_Id__c = :usr.MRKT_ID__c];
        }else{
          this.mktContent = [  select Type__c,Content_Type__c,Content__c
                    from Market_Content__c
                    where Type__c=:pageType
                    and Market__r.Market_Id__c = :usr.MRKT_ID__c];
        }
        if(mktContent.Content_Type__c == 'Link'){
          System.debug('>>>>>>>>>>>>>>isError='+isError);
          return new PageReference(mktContent.Content__c).setRedirect(true);  
        }
        else{
          return null;  
        }
      }catch(Exception ex){
        System.debug('>>>>>>>>>>error fetching record:'+ex);
        isError=true;
        return null;  
      }      
      
  }
  
  public static testmethod void testSaveMarketContent(){
    TestDataHelper testData = new TestDataHelper();
    Market__c mkt = testData.createMarket();
    
    Market_Content__c mktContent = new Market_Content__c(  Name='Test',Market__c=mkt.Id,Type__c='Help',
                              Content_Type__c='HTML',Content__c='Test data',ALM_Page_Id__c='1');
    insert mktContent;
    ApexPages.StandardController stdCtlr = new ApexPages.Standardcontroller(mktContent);
    PageReference pageRef = stdCtlr.edit();
    pageRef.getParameters().put('id',mktContent.Id);
    
    MarketContentController ctlr = new MarketContentController(stdCtlr);
    ctlr.saveContent();
    System.assertEquals(ApexPages.getMessages().size(),0);
    mktContent.ALM_Page_Id__c=null;
    pageRef = ctlr.saveContent();
    System.assertEquals(ApexPages.getMessages().size(),1);  
    mktContent.ALM_Page_Id__c='';
    pageRef = ctlr.saveContent();
    System.assertEquals(ApexPages.getMessages().size(),1);  
    ctlr = new MarketContentController(stdCtlr);
    pageRef = stdCtlr.edit();
  }
  
  public static testmethod void testViewMarketContent(){
    TestDataHelper testData = new TestDataHelper();
    Market__c mkt = testData.createMarket();
    User ldrUser = testData.createLeaderUser('test123');
    Market_Content__c mktContent = new Market_Content__c(  Name='Test',Market__c=mkt.Id,Type__c='Help',
                              Content_Type__c='HTML',Content__c='Test data',ALM_Page_Id__c='1');
    insert mktContent;
    System.runAs(ldrUser){
      ApexPages.StandardController stdCtlr = new ApexPages.Standardcontroller(mktContent);
      PageReference pageRef = Page.ShowMarketDocument;
      pageRef.getParameters().put('type','Help');
      pageRef.getParameters().put('pgId','1');
      Test.setCurrentPageReference(pageRef);
      MarketContentController ctlr = new MarketContentController(stdCtlr);
      ctlr.viewContent();
      System.assertEquals(ctlr.mktContent.Content__c,'Test data');
    }
     
    mktContent = new Market_Content__c(  Name='Test Link',Market__c=mkt.Id,Type__c='Terms and Conditions',
                              Content_Type__c='Link',Content__c='http://www.google.com');                              
    insert mktContent;
    System.runAs(ldrUser){
      ApexPages.StandardController stdCtlr = new ApexPages.Standardcontroller(mktContent);
      PageReference pageRef = Page.ShowMarketDocument;
      pageRef.getParameters().clear();
      pageRef.getParameters().put('type','Terms and Conditions');
      Test.setCurrentPageReference(pageRef);
      MarketContentController ctlr = new MarketContentController(stdCtlr);
      ctlr.viewContent();
      System.assertEquals(ctlr.mktContent.Content__c,'http://www.google.com');
      System.assertEquals(ctlr.IsError,false);
      pageRef.getParameters().clear();
      pageRef.getParameters().put('type','Terms_and_Conditions');
      Test.setCurrentPageReference(pageRef);
      ctlr = new MarketContentController(stdCtlr);
      ctlr.viewContent();
      System.assertEquals(ctlr.IsError,true);
    }
  }
  
}
			                            	