public class SearchObjectController {

  public List<ContactRow> results {get; set;}
  private User currUsr {get; private set;}    
  private String profileName {get; private set;}
  public String srchTxt {get; set;}
  private List<String> zoneList;  
  private MarketLeaderTitleUtils ldrTitlUtils;
  public Boolean testMode {get; set;}
  public PageReference init(){
    if(this.currUsr == null){
      this.currUsr = [select   Id,DFALT_ZONE_CD__c,DFALT_DIV_NM__c,MRKT_ID__c,
                  LanguageLocaleKey
              from  User
              where  Id=:UserInfo.getUserId()];
      Profile usrProfile = [  select   Id,Name
                  from  Profile
                  where  Id=:UserInfo.getProfileId()
                ];
      profileName = usrProfile.Name;
    }              
    this.ldrTitlUtils = new MarketLeaderTitleUtils();
    this.ldrTitlUtils.initialize(currUsr);
    this.srchTxt = ApexPages.currentPage().getParameters().get('srchTxt');
    executeQuery();
    return null;
  }
  public PageReference filterRows(){
    executeQuery();
    return null;
  }
  
  
  private void executeQuery(){
    /*
      Need to change the SOQL for Division Manager
    */
    try{
      if(this.zoneList == null){
        zoneList= new List<String>();
      
        if(profileName == 'Avon Zone Manager'){
          zoneList.add(currUsr.DFALT_ZONE_CD__c);
        }
        if(profileName == 'Avon Division Manager'){
          for(Sales_Organization__c slsOrg :[  Select SLS_ZONE_CD__c, SLS_DIV_NM__c 
                            From Sales_Organization__c
                            where SLS_ORG_LVL_NR__c='Z'
                            and  SLS_DIV_NM__c = :currUsr.DFALT_DIV_NM__c]){
            zoneList.add(slsOrg.SLS_ZONE_CD__c);                  
          }
          
        }
      }
      if(this.srchTxt != null){
        List<Contact> ctctList;
        System.debug('>>>>>>>>>>>>>>> testMode = '+testMode);
        if(testMode == null || !testMode){
          List<List<SObject>> allObjects = [  FIND :this.srchTxt 
                            IN ALL FIELDS 
                            RETURNING Contact (id, name,ACCT_NR__c,Phone,LDRSHP_TITL_LVL_NBR__c
                            where SLS_ZONE_CD__c in :this.zoneList
                            and LDRSHP_TITL_LVL_NBR__c !='-2'
                            and UPLN_ACCT_NR__c !=:this.srchTxt)
                          ];
          ctctList = (List<Contact>)allObjects[0];
        }else{
          ctctList = [select id, name,ACCT_NR__c,Phone,LDRSHP_TITL_LVL_NBR__c 
                from Contact where ACCT_NR__c=:this.srchTxt];  
        }
        System.debug('>>>>>>>>>>>>>>> ctctList='+ctctList);
        this.results = new List<ContactRow>();
        if(ctctList != null && ctctList.size() >0 ){
          for(Contact ct : ctctList){
            this.results.add(new ContactRow(ct,
                            this.ldrTitlUtils.getLeaderTitle(ct.LDRSHP_TITL_LVL_NBR__c)));
          }
        }
      }else{
        List<Contact> ctctList;
        if(testMode==null||!testMode){
          ctctList = [select Id,Name,Phone,ACCT_NR__c,LDRSHP_TITL_LVL_NBR__c from Contact using MRU];
        }else{
          ctctList = [select id, name,ACCT_NR__c,Phone,LDRSHP_TITL_LVL_NBR__c 
                from Contact limit 1];  
        }
        this.results = new List<ContactRow>();
        if(ctctList != null && ctctList.size() >0 ){
          for(Contact ct : ctctList){
            this.results.add(new ContactRow(ct,
                            this.ldrTitlUtils.getLeaderTitle(ct.LDRSHP_TITL_LVL_NBR__c)));
          }
        }
      }
    }catch(Exception ex){
    }          
  }
  
  public static testmethod void testSearchObjectController(){
    PageReference pageRef = Page.LkupObjectSelect;
    TestDataHelper testData = new TestDataHelper();
    
    User testUsr = testData.createZoneUser('Z123456');
    SearchObjectController ctlr = new SearchObjectController();
    Contact ct = testData.createContact('123456',testUsr.Id);
    System.debug('>>>>>>>>>>>>>>>>> contact:'+ct);
    List<List<SObject>> temp = [  FIND :ct.FirstName
                    IN NAME FIELDS 
                    RETURNING Contact (id, name,ACCT_NR__c,Phone,LDRSHP_TITL_LVL_NBR__c
                    //where SLS_ZONE_CD__c in ('Z1')
                    )
                  ];
    system.debug('>>>>>>>>>>>>> search results = '+temp);
    ctlr.testMode = true;
    testData.createSalesOrgs();
    System.runAs(testUsr){
      ctlr.init();
      pageRef.getParameters().put('srchTxt','123456');
      Test.setCurrentPage(pageRef);
      //ctlr.filterRows();
      ctlr.init();
    }  
    
    testUsr = testData.createDivUser('D123456');
    ct = testData.createContact('X123456',testUsr.Id);
    //ctlr
    System.runAs(testUsr){
      ctlr.init();
      pageRef.getParameters().put('srchTxt','123456');
      Test.setCurrentPage(pageRef);
      ctlr.filterRows();
      ctlr.init();
    }    
  }
}
			                            	