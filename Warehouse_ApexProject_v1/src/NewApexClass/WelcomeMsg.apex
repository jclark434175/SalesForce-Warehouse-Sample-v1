public class WelcomeMsg {

  @future
  public static void createWelcomeTask(List<Id> userIds,String mktId){
    createTasks(userIds,mktId);
  }

  private static void createTasks(List<Id> userIds,String mktId){
        try{
          Market__c m = [Select Id,Name 
                      From Market__c m
                      where Market_Id__c = :mktId ];    
          //Use the Sub-Query for the task to create a new task
          Task templateTsk = [select Subject,ActivityDate,Description 
                    from Task 
                    where WhatId=:m.Id 
                    and Subject='Welcome to Avon Leadership'
                    limit 1];
          List<Task> tasksToCreate = new List<Task>();
          Task tempTask;
          for(Id usrId:userIds){
            tempTask = new Task(OwnerId=usrId,
                      Subject = templateTsk.Subject,
                            Status='Not Started',
                            Priority='Normal',
                      Description=templateTsk.Description,
                            ActivityDate=System.today().addDays(2)
                      );
            tasksToCreate.add(tempTask);  
          } 
          insert tasksToCreate;
          //System.debug('Inserted Tasks successfully for users:'+userIds);
        }catch(Exception ex){
          
        }    
  }  
  public static testmethod void testWelcomeTask(){
    TestDataHelper testData = new TestDataHelper();
    testData.createMarket();
          Task welTsk= new Task(OwnerId=UserInfo.getUserId(),
                    Subject = 'Welcome to Avon Leadership',
                          Status='Completed',
                          Priority='Normal',
                    Description='Some Description',
                          WhatId=testData.market.Id
                    );
        insert welTsk;
        User ldrUser = testData.createLeaderUser('123LDR');
        ldrUser.Welcome_Message__c=false;
        update ldrUser;
        /*List<Id> idList =new List<Id>();
        idList.add(ldrUser.Id);
        WelcomeMsg.createTasks(idList, testData.market.Market_Id__c);
        */
  }
}
			                            	