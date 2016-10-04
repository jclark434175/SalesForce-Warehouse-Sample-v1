public class UpdateUserPrefController {
  public User userRec {get; set;}
  public Map<String,ObjectRow> allowedSlsOrgs;
  public List<ObjectRow> slsOrgs;
  public String selOrgCdId {get; set;}
  public String userProfile {get; private set;}
  private Boolean mobileUsrPrev {get; private set;}
  public Boolean isError {get; set;}
  public Boolean testMode {get; set;}
  public Boolean updateSuccess{ get; private set;}
  private static String LOGIN_URL='https://login.salesforce.com';
  public PageReference init(){
    this.userRec = [select   Id,DFALT_ZONE_CD__c,DFALT_DIV_NM__c,ACCT_NR__c,ProfileId,
                MRKT_ID__c,LanguageLocaleKey,UserPermissionsMobileUser,
                UserName,Name
            from  User
            where  Id=:UserInfo.getUserId()];
    mobileUsrPrev = this.userRec.UserPermissionsMobileUser;
    Profile usrProfile = [  select   Id,Name
                from  Profile
                where  Id=:UserInfo.getProfileId()
              ];
    
    userProfile = usrProfile.Name;
    if(updateSuccess==null){
      updateSuccess=false;  
    }
    isError =false;
    getRecords();
    return null;
  }
  
  public List<ObjectRow> getAllowedSlsOrgs(){
    return this.slsOrgs;
  }
  public PageReference updatePreferences(){

    System.debug('>>>>>>>>>>>>>>>this.selOrgCdId='+this.selOrgCdId);
    if(this.allowedSlsOrgs !=null && this.selOrgCdId !=null &&this.selOrgCdId !=''){
      if(userProfile == 'Avon Zone Manager'){
        User_Sales_Org_Hierarchy__c currSelect = this.allowedSlsOrgs.get(this.selOrgCdId).getUserSalesOrg();
        this.userRec.DFALT_ZONE_CD__c = currSelect.SLS_ORG_CD__c;
      }else if(userProfile == 'Avon Division Manager'){
        if(this.selOrgCdId == 'All'){
          this.userRec.DFALT_ZONE_CD__c = null;
        }else{
          Sales_Organization__c currSelect = this.allowedSlsOrgs.get(this.selOrgCdId).getSalesOrg();
          if(currSelect.SLS_ORG_LVL_NR__c == 'Z'){
            this.userRec.DFALT_ZONE_CD__c = currSelect.SLS_ORG_CD__c;
          }
        }
      }
      /*
      If the user was previously not a mobile user and now has opted in
      for being a mobile user, we'll create a task for the market administrator.
      */
      System.debug('>>>>>>>>>>>>>>>>>>>>mobileUsrPrev='+mobileUsrPrev);
      System.debug('>>>>>>>>>>>>>>>>>>>>this.userRec.UserPermissionsMobileUser='+this.userRec.UserPermissionsMobileUser);
    }  
    Market__c market = [select   Name,Market_Administrator__c,
                  Market_Administrator__r.Email,
                  Available_Languages__c
              from Market__c
              where Market_Id__c=:this.userRec.MRKT_ID__c];
    if(!market.Available_Languages__c.contains(userRec.LanguageLocaleKey)){
      isError =true;
      return null;  
    }
    System.debug('>>>>>>>>>>>>>>>>>>>> userRec.ProfileId:'+userRec.ProfileId);
    if(testMode==null || !testMode){
      update userRec;
    }
    //Don't create task if the update to the user record was not successful.
    if(this.userRec.UserPermissionsMobileUser != mobileUsrPrev &&
      this.userRec.UserPermissionsMobileUser){

      createMarketAdminTask(market);
      mobileUsrPrev = this.userRec.UserPermissionsMobileUser;
      sendInstructionsEmail(market);  
      
    }
    isError =false;
    getRecords();
    updateSuccess=true;
    return null;
  }
  private void createMarketAdminTask(Market__c market){
      Date currDt = System.today();
      currDt.addDays(1);
      String taskDesc= 'User Name:'+this.userRec.Name+'\n';
      taskDesc +='Account Number:'+this.userRec.ACCT_NR__c+'\n';
      Task resetTsk = new Task(  OwnerId=market.Market_Administrator__c,
                    Subject='Mobile User Request:'+this.userRec.Name,
                    ActivityDate=currDt,
                    IsReminderSet=true,
                    Priority='High',
                    Status='Not Started',
                    Description = taskDesc);
      //System.debug('>>>>>>>>>>>>>>> Mobile Reset Task:'+resetTsk);
      insert resetTsk;
      Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
      msg.setSubject('ALM Mobile Request:'+this.userRec.Name);
      msg.setSenderDisplayName(this.userRec.Name);
      msg.setHtmlBody('<html><body>A new task has been assigned to you via the mobile request process. '+
      'Please click on the link below to access the task and reset the respective user\'s '+
      'password.

Task: <a href="'+LOGIN_URL+'?startURL=/'+resetTsk.Id+'">'+LOGIN_URL+'/'+resetTsk.Id+'</a></body></html>');
      msg.setTargetObjectId(market.Market_Administrator__c);
      msg.setSaveAsActivity(false);
      Messaging.sendEmail(new Messaging.Email[] { msg });
  }
  private void sendInstructionsEmail(Market__c market){
    String fldName;
    if(testMode ==null || !testMode){
      fldName =  'Mkt'+this.userRec.MRKT_ID__c+'_'+
                this.userRec.LanguageLocaleKey+'_'+
                'MOBILE';
    }else{
      fldName='Dummy Folder DO NOT DELETE';  
    }
    System.debug('>>>>>>>>>>>>>>>fldName ='+fldName);
    Folder fld = [select Id,Name from Folder where Name=:fldName];
    //Always get the first Email Template. There should not be
    //more than 1 email template in the Mobile Folder.
    EmailTemplate temp = [  select Id,Name from EmailTemplate
                where FolderId=:fld.Id
                limit 1
              ];
    EmailUtils.sendEmail(new Id[]{this.userRec.Id},temp.Id,market.Market_Administrator__r.Email);
  }

  private void getRecords(){
    String slsOrgLvl='';
    if(userProfile == 'Avon Leader'){
      slsOrgLvl='N/A';
    }
    if(userProfile == 'Avon Zone Manager'){
      slsOrgLvl='Z';
    }
    /*if(userProfile == 'Avon Division Manager'){
      slsOrgLvl='D';
    }*/
    if(userProfile == 'Avon Division Manager'){
      allowedSlsOrgs = new Map<String,ObjectRow>();
      slsOrgs = new List<ObjectRow>();
      Boolean oddRow = false;
      ObjectRow row;
      /*
        Get all Zones for the Division that the Division
        Manager has on their user record
      */
      /*ObjectRow divRow;
      divRow = new ObjectRow(new Sales_Organization__c(SLS_ORG_LVL_NR__c='D',
                               SLS_ORG_CD__c=userRec.DFALT_DIV_NM__c),
                     oddRow);
      if(userRec.DFALT_ZONE_CD__c=='All' ||userRec.DFALT_ZONE_CD__c == null){
        divRow.selected = true;        
      }else{
        divRow.selected = false;        
      }
      allowedSlsOrgs.put('All',divRow);
      */
      
      System.debug('>>>>>>>>>>> userRec.DFALT_DIV_NM__c='+userRec.DFALT_DIV_NM__c);
      for(Sales_Organization__c slsOrg: [    Select   SLS_ORG_LVL_NR__c, SLS_ORG_CD__c,
                              SLS_DIV_NM__c 
                          From   Sales_Organization__c
                          where  SLS_ORG_LVL_NR__c = 'Z'
                          and    SLS_DIV_NM__c = :userRec.DFALT_DIV_NM__c
                          and    Market__r.Market_Id__c=:this.userRec.MRKT_ID__c])
      {
        row = new ObjectRow(slsOrg,oddRow);
        if(  slsOrg.SLS_ORG_CD__c == userRec.DFALT_ZONE_CD__c)
        {
          row.selected=true;
          this.selOrgCdId = slsOrg.Id;
        }else{
          row.selected=false;
        }
        oddRow = !oddRow;
        allowedSlsOrgs.put(slsOrg.SLS_ORG_CD__c,row);
        slsOrgs.add(row);
      }
            
    }
    
    if(userProfile == 'Avon Zone Manager'){
      allowedSlsOrgs = new Map<String,ObjectRow>();
      slsOrgs = new List<ObjectRow>();
      Boolean oddRow = true;
      ObjectRow row;
      for(User_Sales_Org_Hierarchy__c slsOrg: [
                          Select   Id,SLS_ORG_LVL_CD__c, SLS_ORG_CD__c, 
                              MRKT_ID_ACCT_NR_SLS_ORG_KEY__c, ACCT_NR__c 
                          From   User_Sales_Org_Hierarchy__c u
                          where  ACCT_NR__c = :userRec.ACCT_NR__c
                          and    SLS_ORG_LVL_CD__c = :slsOrgLvl
                          and    Market__r.Market_Id__c = :userRec.MRKT_ID__c])
      {
        row = new ObjectRow(slsOrg,oddRow);
        if(  slsOrg.SLS_ORG_CD__c == userRec.DFALT_ZONE_CD__c)
        {
          row.selected=true;
          this.selOrgCdId = slsOrg.Id;
        }else{
          row.selected=false;
        }
        oddRow = !oddRow;
        allowedSlsOrgs.put(slsOrg.SLS_ORG_CD__c,row);
        slsOrgs.add(row);
      }
      
      
    }
    
  } 
  public Integer getSlsOrgSize(){
    if(this.allowedSlsOrgs != null){
      return this.slsOrgs.size();
    }else{
      return 0;
    }
  }
  public static testmethod void testUpdatePrefController(){
    TestDataHelper testData = new TestDataHelper();
    testData.createEmailTemplate();
    String acctNbr = '123456';
    User usr = testData.createZoneUser(acctNbr);
    User mktAdmin = testData.createMarketAdminUser('MKT_ADMIN');
    System.debug('>>>>>>>>>>>>>>>>>>>>>> mktAdmin User:'+mktAdmin);
    testData.market.Market_Administrator__c = mktAdmin.Id;
    update testData.market;
    List<User_Sales_Org_Hierarchy__c> usrHierarchy = testData.createUsrSlsOrgHrchy(usr,'XZ1','Z');
    testData.createUsrSlsOrgHrchy(usr,'XZ2','Z');
    List<Sales_Organization__c> slsOrgs = testData.createSalesOrgs();
    
    UpdateUserPrefController ctlr = new UpdateUserPrefController();
    ctlr.testMode =true; 
    System.runAs(usr){
      System.assert(ctlr.getSlsOrgSize()==0);
      ctlr.init();
      System.assert(ctlr.getAllowedSlsOrgs().size()==2);
      System.debug('>>>>>>>>>>> SALES ORG DATA ZONE:'+ctlr.allowedSlsOrgs);
      ctlr.selOrgCdId = usrHierarchy[0].SLS_ORG_CD__c;
      ctlr.updatePreferences();
      ctlr.selOrgCdId = usrHierarchy[0].SLS_ORG_CD__c;
      ctlr.userRec.LanguageLocaleKey='en_US';
      ctlr.userRec.UserPermissionsMobileUser=true;
      ctlr.updatePreferences();
      System.assert(ctlr.isError==false);
      ctlr.userRec.LanguageLocaleKey='fr';
      ctlr.selOrgCdId = usrHierarchy[0].SLS_ORG_CD__c;
      ctlr.updatePreferences();
      System.assert(ctlr.isError==true);
    }
    System.runAs(mktAdmin){
      List<Task> mobileTask = [select Id,Subject from Task where OwnerId=:mktAdmin.Id];
      //System.debug('>>>>>>>>>>>>>> TOTAL TASKS RETURNED: '+mobileTask);
      system.assert(mobileTask.size()==1);
    }
  }
  
  public static testmethod void test2SalesLeader(){
    TestDataHelper testData = new TestDataHelper();
    testData.createEmailTemplate();
    String acctNbr = '123456';
    User usr = testData.createZoneUser(acctNbr);
    User mktAdmin = testData.createMarketAdminUser('MKT_ADMIN');
    System.debug('>>>>>>>>>>>>>>>>>>>>>> mktAdmin User:'+mktAdmin);
    testData.market.Market_Administrator__c = mktAdmin.Id;
    update testData.market;
    List<User_Sales_Org_Hierarchy__c> usrHierarchy = testData.createUsrSlsOrgHrchy(usr,'XZ1','Z');
    testData.createUsrSlsOrgHrchy(usr,'XZ2','Z');
    List<Sales_Organization__c> slsOrgs = testData.createSalesOrgs();
    
    UpdateUserPrefController ctlr = new UpdateUserPrefController();
    ctlr.testMode =true; 
    System.runAs(usr){
      System.assert(ctlr.getSlsOrgSize()==0);
      ctlr.init();
      System.assert(ctlr.getAllowedSlsOrgs().size()==2);
      System.debug('>>>>>>>>>>> SALES ORG DATA ZONE:'+ctlr.allowedSlsOrgs);
      ctlr.selOrgCdId = usrHierarchy[0].SLS_ORG_CD__c;
      ctlr.updatePreferences();
      System.assert(ctlr.isError==false);
      ctlr.userRec.LanguageLocaleKey='fr';
      ctlr.selOrgCdId = usrHierarchy[0].SLS_ORG_CD__c;
      ctlr.updatePreferences();
      System.assert(ctlr.isError==true);
    }
    System.runAs(mktAdmin){
      List<Task> mobileTask = [select Id,Subject from Task where OwnerId=:mktAdmin.Id];
      //System.debug('>>>>>>>>>>>>>> TOTAL TASKS RETURNED: '+mobileTask);
      //system.assert(mobileTask.size()==1);
    }
    usr = testData.createDivUser('D'+acctNbr);
    usr.DFALT_ZONE_CD__c ='All';
    update usr;
    //usrHierarchy = testData.createUsrSlsOrgHrchy(usr,'D1','D');
    ctlr = new UpdateUserPrefController();
    System.runAs(usr){
      ctlr.init();
      System.assert(ctlr.getAllowedSlsOrgs().size()==1);
      System.assert(ctlr.getSlsOrgSize()==1);
      ctlr.selOrgCdId = 'All';
      ctlr.updatePreferences();
      User tempUsr = [select DFALT_DIV_NM__c,DFALT_ZONE_CD__c 
              from User
              where Id=:usr.Id];
      System.assert(tempUsr.DFALT_ZONE_CD__c==null);  
      ctlr.selOrgCdId =   'XZ1';
      ctlr.updatePreferences();
      tempUsr = [select DFALT_DIV_NM__c,DFALT_ZONE_CD__c 
              from User
              where Id=:usr.Id];
      System.assert(tempUsr.DFALT_ZONE_CD__c=='XZ1');  
    }

    ctlr = new UpdateUserPrefController();
    usr = testData.createLeaderUser('L'+acctNbr);
    System.runAs(usr){
      ctlr.init();
      System.assert(ctlr.getAllowedSlsOrgs()==null);
    }
    
  }
  
  public static testmethod void testZoneManager(){
    TestDataHelper testData = new TestDataHelper();
    testData.createEmailTemplate();
    String acctNbr = '123456';
    User usr = testData.createZoneUser(acctNbr);
    User mktAdmin = testData.createMarketAdminUser('MKT_ADMIN');
    System.debug('>>>>>>>>>>>>>>>>>>>>>> mktAdmin User:'+mktAdmin);
    testData.market.Market_Administrator__c = mktAdmin.Id;

    UpdateUserPrefController ctlr = new UpdateUserPrefController();
    ctlr.testMode =true; 
    
    update testData.market;
    List<User_Sales_Org_Hierarchy__c> usrHierarchy = testData.createUsrSlsOrgHrchy(usr,'XZ1','Z');
    testData.createUsrSlsOrgHrchy(usr,'XZ2','Z');
    List<Sales_Organization__c> slsOrgs = testData.createSalesOrgs();
    
    usr = testData.createDivUser('D'+acctNbr);
    usr.DFALT_ZONE_CD__c ='All';
    update usr;
    //usrHierarchy = testData.createUsrSlsOrgHrchy(usr,'D1','D');
    ctlr = new UpdateUserPrefController();
    System.runAs(usr){
      ctlr.init();
      System.assert(ctlr.getAllowedSlsOrgs().size()==1);
      System.assert(ctlr.getSlsOrgSize()==1);
      ctlr.selOrgCdId = 'All';
      ctlr.updatePreferences();
      User tempUsr = [select DFALT_DIV_NM__c,DFALT_ZONE_CD__c 
              from User
              where Id=:usr.Id];
      System.assert(tempUsr.DFALT_ZONE_CD__c==null);  
      ctlr.selOrgCdId =   'XZ1';
      ctlr.updatePreferences();
      tempUsr = [select DFALT_DIV_NM__c,DFALT_ZONE_CD__c 
              from User
              where Id=:usr.Id];
      System.assert(tempUsr.DFALT_ZONE_CD__c=='XZ1');  
    }

    ctlr = new UpdateUserPrefController();
    usr = testData.createLeaderUser('L'+acctNbr);
    System.runAs(usr){
      ctlr.init();
      System.assert(ctlr.getAllowedSlsOrgs()==null);
    }
    
  }
}
			                            	