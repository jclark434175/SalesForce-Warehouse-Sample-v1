public class EmailUtils {
  public static List<Id> sendEmail(List<String> repAcctList,String templateId){
    List<ID> targetObjIds = new List<ID>();
    System.debug('>>>>>>>>>>>>>>>> toIdsArray ='+repAcctList);
    List<Contact> cnt = [Select Id from Contact where MRKT_ACCT_KEY__c in : repAcctList];
    for(Integer i=0;i<cnt.size();i++) 
    {
      targetObjIds.add(cnt[i].Id);
    }
    return sendEmail(targetObjIds,templateId);
  }

  public static List<Id> sendEmail(List<ID> targetObjIds,String templateId){
    List<ID> errIdList = new List<ID>();
    if(targetObjIds.size() > 0){
      Messaging.SingleEmailMessage mail;
      User currUser = [select Id,Username,Email,GI3_Email__c from User where Id=:UserInfo.getUserId()][0];
      List<Messaging.Email> emailsToSend = new List<Messaging.Email>();
      for(Id trgId:targetObjIds){
        mail = new Messaging.SingleEmailMessage();
        mail.setReplyTo(currUser.GI3_Email__c);
        mail.saveAsActivity=false;
        mail.setTemplateId(templateId);
        mail.setUseSignature(false);
        mail.setTargetObjectId(trgId);  
        emailsToSend.add(mail);
      }
      try{
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(emailsToSend);
        for(Messaging.SendEmailResult emailRslt: results){
          System.debug('************** result:'+emailRslt);
          if(!emailRslt.isSuccess()){
            for(Messaging.SendEmailError emailErr: emailRslt.getErrors()){
              errIdList.add(emailErr.getTargetObjectId());
            }
          }
        }
      }catch(Exception ex){
        //Return the entire input back as everything failed.
        return targetObjIds;
      }
    }  
    return errIdList; 
    
  }
  public static List<Id> sendEmail(List<Id> targetObjIds,String templateId,String repyTo){
    List<ID> errIdList = new List<ID>();
    
    if(targetObjIds.size() > 0){
      Messaging.SingleEmailMessage mail;
      User currUser = [select Id,Username,Email,GI3_Email__c from User where Id=:UserInfo.getUserId()][0];
      List<Messaging.Email> emailsToSend = new List<Messaging.Email>();
      for(Id trgId:targetObjIds){
        mail = new Messaging.SingleEmailMessage();
        mail.setReplyTo(currUser.GI3_Email__c);
        mail.saveAsActivity=false;
        mail.setTemplateId(templateId);
        mail.setTargetObjectId(trgId);
        mail.setUseSignature(false);
        emailsToSend.add(mail);
      }
      try{
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(emailsToSend);
        for(Messaging.SendEmailResult emailRslt: results){
          if(!emailRslt.isSuccess()){
            for(Messaging.SendEmailError emailErr: emailRslt.getErrors()){
              errIdList.add(emailErr.getTargetObjectId());
            }
          }
        }
      }catch(Exception ex){
        //Return the entire input back as everything failed.
        return targetObjIds;
      }
    }
    return errIdList;  
    
  }
  
  public static testmethod void testEmailUtils(){
    TestDataHelper testData = new TestDataHelper();
    Contact ct = testData.createContact('123456',UserInfo.getUserId());
    EmailTemplate template = testData.createEmailTemplate();
    List<Id> ctIds = new List<Id>();
    ctIds.add(ct.Id);
    
    List<ID> errIds = EmailUtils.sendEmail(new String[]{ct.MRKT_ACCT_KEY__c},template.Id);
    System.assert(errIds.size()==0);  
    errIds = EmailUtils.sendEmail(ctIds,template.Id,'test@avon.com');
    System.assert(errIds.size()==0);  
    errIds = EmailUtils.sendEmail(ctIds,template.Id);  
    System.assert(errIds.size()==0);  
    
    ct.Email = 'something@something.com';
    update ct;
    errIds = EmailUtils.sendEmail(ctIds,template.Id);
    //The email send shoudl have failed but in test methods
    //not sure how to simulate an actual error  
    System.assert(errIds.size()==0);  

    errIds = EmailUtils.sendEmail(ctIds,template.Id,'test@avon.com');
    //The email send shoudl have failed but in test methods
    //not sure how to simulate an actual error  
    System.assert(errIds.size()==0);  
    
  }

  
}
			                            	