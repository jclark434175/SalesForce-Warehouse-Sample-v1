public class EmailRepsController {
  
  private List<String> acctNbrList; 
  private Map<Id,Contact> contactIdMap; 
  private List<id> contactIds;
  public List<ObjectRow> templates {get; private set;}
   public Market__c market {get; private set;}
   public String selTemplateId {get; set;}
   public Integer successEmailCount {get; set;}
   public Integer failedEmailCount {get; set;}
   public Map<Id,Contact> errRepDetails {get; set;}
   public Map<Id,Contact> repDetails {get; set;}
   private Map<Id,String> templateDescMap;
   
   User currUsr {get; set;}
   String userProfile {get; set;}
   public Boolean testMode {get; set;}
   public Boolean emailSuccess {get; private set;}
  public PageReference init(){
    String acctNbrs = ApexPages.currentPage().getParameters().get('acctNbr');
    acctNbrList = acctNbrs.split(',');
    List<String> emailAcctNbrs = new List<String>();
    Map<String,String> uplines = new Map<String,String>();
    List<String> tokens;
    errRepDetails = new Map<Id,Contact>();
    repDetails = new Map<Id,Contact>();
    
    for(String acctNbr: acctNbrList){
      /*
      Code no longer used as emails can be sent only to 1st gen uplines
      
      if(acctNbr.indexOf(':') >0){
        tokens=acctNbr.split(':');
        uplines.put(tokens[0],getFormattedValue(tokens[1]));    
      }else{(*/
      uplines.put(acctNbr,'N/A');  
    }
    List<Contact> contactToUpdt = new List<Contact>();
    this.contactIdMap= new Map<Id,Contact>();
    contactIds = new List<Id>();
    String downline;
    this.successEmailCount=0;
    this.failedEmailCount=0;
    for( Contact ct: [select Id,Name,Email,Phone,Downline_Rep_Info__c,MRKT_ACCT_KEY__c
              from  Contact
              where MRKT_ACCT_KEY__c in :uplines.keySet()])
    {
      //ct.Downline_Rep_Info__c = uplines.get(ct.MRKT_ACCT_KEY__c);
      //contactToUpdt.add(ct);
      System.debug('>>>>>>>>>>>>>> Rep :'+ct);
      repDetails.put(ct.Id,ct);
      if(ct.Email!=null && ct.Email!=''){
        contactIdMap.put(ct.Id,ct);
        contactIds.add(ct.Id);
        this.successEmailCount++;
      }else{
        System.debug('>>>>>>>>>>>>>>>>> No email found for Rep:'+ct.Name);
        errRepDetails.put(ct.Id,ct);
        this.failedEmailCount++;
      }  
    }
    String pgId = ApexPages.currentPage().getParameters().get('retPgId');
    String rptName = ApexPages.currentPage().getParameters().get('rptName');
    String usrPrefx = '';
    this.currUsr = [Select   Name,MRKT_TAG_1_HDR_TXT__c, MRKT_ID__c,  USER_CNTRY_CD__c,
                LastName, LanguageLocaleKey, FirstName,MRKT_ID_ACCT_NR_KEY__c,
                DFALT_ZONE_CD__c, DFALT_DIV_NM__c,MAX_EMAIL_LIMIT__c 
            From User
            where Id = :UserInfo.getUserId()];
    this.userProfile = [select Name from Profile where Id = :UserInfo.getProfileId()].Name;
    if(userProfile == 'Avon Leader'){
      usrPrefx = 'LDR';
    }else if(userProfile == 'Avon Zone Manager' || userProfile == 'Avon Division Manager'){
      usrPrefx = 'ZONE';
    }
    //System.debug('>>>>>>>>>>>>>>>>>>>>>>>> curr Usr : '+ this.currUsr);            
    this.market = [
                Select  SPPY_CMPGN_NR__c, PREV_1_CMPGN_NR__c, Name, 
                    Market_Id__c, Mail_Plan_Enabled__c, CURRNT_CMPGN_RMN_DAY_CNT__c, 
                    CMPGN_STRT_DT__c, CMPGN_NR__c, CMPGN_END_DT__c,
                    LAST_UPDT_DT__c,eCard_Status_Message_Header__c
                From   Market__c  
                where  Market_Id__c =:currUsr.MRKT_ID__c];
    List<String> fldNames=new List<String>();
    String fldName;
    //System.debug('>>>>>>>>>>>>>>>>>>> FolderName:'+fldName);
    if(testMode != null && testMode){
      /*
        This folder needs to be manually created before deployment.
        This is because we cannot create Folders via APEX and 
        have to rely on a pre-created folder to make sure the rest 
        of the code executes.
      */
      fldName='Dummy Folder DO NOT DELETE';
    }else{
      fldName = 'Mkt'+this.market.Market_Id__c+'_'+currUsr.LanguageLocaleKey+'_'+usrPrefx+'_'+rptName;
    }
    fldNames.add(fldName);
    System.debug('>>>>>>>>>>>>>>>>>>>> fldNames='+fldNames);
    this.templates = new List<ObjectRow>();
    this.templateDescMap = new Map<Id,String>();
    Boolean oddRow = true;
    if(rptName !='Downline'){
      for(EmailTemplate template:[  select   Id,Name,Subject,Description,TemplateType, 
                          TemplateStyle, 
                          NamespacePrefix, 
                          HtmlValue, 
                          FolderId, BrandTemplateId
                      from  EmailTemplate
                      where  Folder.Name in :fldNames
                      order by Subject asc
                    ])
      {
        this.templates.add(new ObjectRow(template,oddRow));
        templateDescMap.put(template.Id,template.Description);
        oddRow= !oddRow;  
      }
    }else{
      String allFldPattern;
      if(testMode!= null && testMode){
        allFldPattern='%Dummy Folder DO NOT DELETE%';
      }else{
         allFldPattern= 'Mkt'+this.market.Market_Id__c+'_'+currUsr.LanguageLocaleKey+'_'+usrPrefx+'_%';
      }
      for(EmailTemplate template:[  select   Id,Name,Subject,Description,TemplateType, 
                          TemplateStyle, 
                          NamespacePrefix, 
                          HtmlValue, 
                          FolderId, BrandTemplateId
                      from  EmailTemplate
                      where  Folder.Name like :allFldPattern
                      order by Subject asc
                    ])
      {
        this.templates.add(new ObjectRow(template,oddRow));
        templateDescMap.put(template.Id,template.Description);
        oddRow= !oddRow;  
      }
      
    }  
    if(this.emailSuccess == null){
      emailSuccess = false;
    }        
    return null;        
  }
  
  public PageReference sendEmail(){
    List<ID> errIds = EmailUtils.sendEmail(this.contactIds,this.selTemplateId);
    processErrors(errIds);
    emailSuccess=true;
    return null;  
  }
  
  public void processErrors(List<Id> errIdList){
    //For Reps that errored out, remove them from the original list
    for(Id ctId: errIdList){
      this.errRepDetails.put(ctId,repDetails.get(ctId));
      this.contactIdMap.remove(ctId);
    }
    String messageDesc =   '"'+this.templateDescMap.get(this.selTemplateId)+'" '+
                this.market.eCard_Status_Message_Header__c+ '\n\n';  
    Date currDt = System.today();
    for(Contact ct:this.errRepDetails.values()){
      messageDesc+='- '+ct.Name+' ('+(ct.Phone==null?'':ct.Phone)+')'+'\n';
    }
    messageDesc+='\n';
    for(Contact ct:this.contactIdMap.values()){
      messageDesc+='+ '+ct.Name+' ('+(ct.Phone==null?'':ct.Phone)+')'+'\n';
    }
    
    Task emailErrTsk = new Task(  OwnerId=UserInfo.getUserId(),
                  Subject='eMail Summary – '+Datetime.now().format('EEEE MMMM d yyyy HH:mm a'),
                  ActivityDate=currDt,
                  IsReminderSet=true,
                  Priority='High',
                  Status='Not Started',
                  Description = messageDesc);
    insert emailErrTsk;
  }
  
  /*private String getFormattedValue(String acctNbrs){
    String tempStr='';
    for(String acctNbr: acctNbrs.split(';')){
      tempStr+=acctNbr+'\n';  
    }  
    return tempStr;
  }*/
  
  public static testmethod void testEmailReps(){
    EmailRepsController ctlr = new EmailRepsController();
    String mktIdKey = '123456';
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createLeaderUser('123456');
    testData.createSalesOrgs();
    List<Genealogy__c> geneData = testData.createDownlineData(testUsr.MRKT_ID_ACCT_NR_KEY__c,1,testUsr.Id);
    PageReference pageRef = Page.EmailReps;
    System.debug('*****************************'+geneData[0].MRKT_ACCT_KEY__c);
    pageRef.getParameters().put('acctNbr',geneData[0].MRKT_ACCT_KEY__c+',');
    Test.setCurrentPage(pageRef);
    EmailTemplate template = testData.createEmailTemplate();
    ctlr.testMode = true;
    
    System.runAs(testUsr){
      ctlr.init();
      System.assert(ctlr.templates.size()==1);
      pageRef.getParameters().put('acctNbr',geneData[1].MRKT_ACCT_KEY__c);
      pageRef.getParameters().put('rptName','Title Change');
      ctlr.init();
      System.assert(ctlr.templates.size()==1);
      ctlr.selTemplateId = template.Id;
      ctlr.sendEmail();
      System.assert(ctlr.errRepDetails.size()==0);     
        
    
    }  

    Contact ct = new Contact(Id=geneData[0].Representative__c,Email=null);
    update ct;
    
    ctlr = new EmailRepsController();
    ctlr.testMode = true;
    pageRef.getParameters().put('acctNbr',geneData[0].MRKT_ACCT_KEY__c+',');
    pageRef.getParameters().put('rptName','Downline');
    Test.setCurrentPage(pageRef);
    List<Task> tskList = [select Id,Subject from Task where OwnerId=:testUsr.Id and Subject like 'eMail Summary%'];
    delete tskList;
    System.runAs(testUsr){
      ctlr.init();
      ctlr.selTemplateId = template.Id;
      ctlr.sendEmail();
      System.assert(ctlr.errRepDetails.size()==1);
      tskList = [select Id,Subject from Task where OwnerId=:testUsr.Id and Subject like 'eMail Summary%'];
      
      System.assertEquals(tskList.size(),1);
      List<ID> errIdList = new List<ID>();
      errIdList.add(ct.Id);
      ctlr.processErrors(errIdList);
      tskList = [select Id,Subject from Task where OwnerId=:UserInfo.getUserId() and Subject like 'eMail Summary%'];      
      System.assertEquals(tskList.size(),2);
    }
  }
}
			                            	