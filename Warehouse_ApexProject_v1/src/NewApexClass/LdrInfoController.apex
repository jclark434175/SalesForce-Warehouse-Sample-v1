public class LdrInfoController {
  public String repName {get; set;}
  public String repContactId {get; set;}
  public String section {get; set;}
  public Contact currContact {get; set;}
  public String impRepId {get; set;}
  public String drillDwnRepId {get; set;}
  public Boolean isError {get; set;}
  public String marketId {get; set;}
  public User currUsr {get; private set;}
  private String profileName;
  private List<String> zoneList;
  public PageReference init(){
    if(currUsr ==null){
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
    impRepId = ApexPages.currentPage().getParameters().get('impRepNbr');
    System.debug('>>>>>>>>>>>>>>> impRepNbr='+impRepId);
    if(impRepId !=null){
      this.currContact = [select Id,Name,Phone,LDRSHP_TITL_LVL_NBR__c,
                    MRKT_ACCT_KEY__c,ACCT_NR__c
                from  Contact
                where ACCT_NR__c=:impRepId
                and  MRKT_ID__c=:currUsr.MRKT_ID__c];
      this.repContactId = this.currContact.Id;
      this.repName = this.currContact.Name;
      
    }
    drillDwnRepId = ApexPages.currentPage().getParameters().get('drillDwnRepNbr');
    this.section = ApexPages.currentPage().getParameters().get('section');
    if(isError==null){
      this.isError=false;
    }
    return null;  
  }
  
  public PageReference impersonate(){
    System.debug('>>>>>>>>>>>>>>>this.repContactId:'+this.repContactId);
    if(this.repContactId !=null && this.repContactId !=''){
      this.section='Current Campaign';
      this.currContact = [select Id,Name,Phone,LDRSHP_TITL_LVL_NBR__c,
                    MRKT_ACCT_KEY__c,ACCT_NR__c
                from  Contact
                where Id=:this.repContactId];
      this.impRepId = this.currContact.ACCT_NR__c;
      this.drillDwnRepId= this.currContact.ACCT_NR__c;
      this.isError=false;
    }else{
      //See if the user just entered a Name without using the lookup 
      //function
      if(this.repName !=null && this.repName.length()>2){
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
        
        List<List<SObject>> allObjects = [  FIND :this.repName 
                          IN ALL FIELDS 
                          RETURNING Contact (id, name,MRKT_ACCT_KEY__c,
                          Phone,LDRSHP_TITL_LVL_NBR__c,ACCT_NR__c
                          where SLS_ZONE_CD__c in :zoneList
                          and LDRSHP_TITL_LVL_NBR__c !='-2'
                          and UPLN_ACCT_NR__c !=:this.repName)
                        ];
                        
        List<Contact> contacts = (List<Contact>)allObjects[0];
        if(contacts!=null && contacts.size()== 1){
          this.currContact = contacts[0];
          this.repContactId = this.currContact.Id;  
          this.repName = this.currContact.Name;  
          this.section='Current Campaign';
          this.impRepId = this.currContact.ACCT_NR__c;
          this.drillDwnRepId= this.currContact.ACCT_NR__c;
          isError = false;
        }
        if(contacts==null || contacts.size()==0 ||contacts.size()>1){
          this.isError=true;
          this.currContact = null;
          this.repContactId = null;  
          this.repName = null;  
          this.section=null;
          this.impRepId = null;
          this.drillDwnRepId= null;
        }
      
      }else{
        this.isError=true;
      }//display error message
        
    }
    return null;            
  }
  public PageReference currentCampaign(){
    this.section='Current Campaign';
    return null;  
  }
  public PageReference myDownline(){
    this.section='Downline';
    return null;  
  }
  public PageReference campaignReports(){
    this.section='Reports';
    return null;  
  }
  
  public static testmethod void testLdrInfo(){
    LdrInfoController ctlr = new LdrInfoController();
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createZoneUser('Z12345');
    List<Genealogy__c> geneData = testData.createDownlineData('123456',2,testUsr.Id);
    System.debug(geneData);
    PageReference pageRef = Page.LeaderInfo;
    pageRef.getParameters().put('impRepNbr',geneData[0].ACCT_NR__c);
    Test.setCurrentPageReference(pageRef);
      
    System.runAs(testUsr){
      ctlr.init();
      ctlr.impersonate();
      System.assert(ctlr.section=='Current Campaign');
      ctlr.campaignReports();
      System.assert(ctlr.section=='Reports');
      ctlr.myDownline();
      System.assert(ctlr.section=='Downline');
      ctlr.currentCampaign();  
      System.assert(ctlr.section=='Current Campaign');
      ctlr  = new LdrInfoController();
      ctlr.repName = '1234560First 1234560Last';
      ctlr.impersonate();
    }
    testData.createSalesOrgs();
    testUsr = testData.createDivUser('D12345');
     geneData = testData.createDownlineData('X123456',2,testUsr.Id);
    ctlr = new LdrInfoController();
    pageRef = Page.LeaderInfo;
    pageRef.getParameters().put('impRepNbr',geneData[0].ACCT_NR__c);
    Test.setCurrentPageReference(pageRef);
    System.runAs(testUsr){
      ctlr.init();
      ctlr.impersonate();
      System.assert(ctlr.section=='Current Campaign');
      ctlr.campaignReports();
      System.assert(ctlr.section=='Reports');
      ctlr.myDownline();
      System.assert(ctlr.section=='Downline');
      ctlr.currentCampaign();  
      System.assert(ctlr.section=='Current Campaign');
      ctlr  = new LdrInfoController();
      ctlr.repName = '1234560First 1234560Last';
      ctlr.impersonate();
    }    
  } 
}
			                            	