public class ShowMarketDocumentController{ 
public String mrt {get;set;}
public String lgn{get;set;}
Market_Document__c custObj = new Market_Document__c();
 
public Market_Document__c getdoc(){
  String pagetype = System.currentPageReference().getParameters().get('type');
    User u = [select MRKT_ID__c,LanguageLocaleKey from User 
            where Id=:UserInfo.getUserId()] ;       
    mrt = u.MRKT_ID__c;
    lgn = u.LanguageLocaleKey;
    
    System.debug('>>>>>>>>>>>>>>>>>> USer:'+u);
    System.debug('>>>>>>>>>>>>>>>>>> USer:'+u);
    Market_Document__c mds = 
                [Select m.Document_Id__c From Market_Document__c m where 
               m.Market__r.Market_Id__c=:mrt 
               and m.Type__c=:pagetype 
               and m.Language__c=:lgn];
    if(mds!=null)           
    custObj.Document_Id__c = mds.Document_Id__c;
    return mds;
}

public PageReference DetailPage() {
    getdoc();
    PageReference pg = new PageReference( '/servlet/servlet.FileDownload?file='+ custObj.Document_Id__c );
    return pg;
    }
static testMethod void testshowmarketdocument(){

  TestDataHelper testData = new TestDataHelper();
  List<Market_Document__c> mktDocs = testData.createMarketDocument();
  User testUsr = testData.createLeaderUser('12345');
  List<Market_Document__c> docs = [Select m.Document_Id__c From Market_Document__c m where 
               m.Market__r.Market_Id__c=:testData.market.Market_Id__c 
               and m.Type__c='Test' 
               and m.Language__c=:testUsr.LanguageLocaleKey];
    System.debug('>>>>>>>>>>>>>>>>>>>>> docs+'+docs);          
  ShowMarketDocumentController ctlr = new ShowMarketDocumentController();
  PageReference pageRef = Page.ShowMarketDocument;
  pageRef.getParameters().put('type','Test');
  Test.setCurrentPageReference(pageRef); 
  System.runAs(testUsr){
    pageRef = ctlr.DetailPage();
    System.assert(pageRef.getUrl()=='/servlet/servlet.FileDownload?file='+docs[0].Document_Id__c);
  }  
}

     
}
			                            	