public class MyMessageController {

/*use this for getTask personal messages*/
    private List<Task> fullTaskList = new List<Task>();
    private List<Task> displayedTaskList = new List<Task>();
/*use this for Broadcast messages*/
    private List<Task> fullBroadList = new List<Task>();
    private List<Task> displayBroadMessageList = new List<Task>();
  
/*Variables*/
  public Id tskToClose {get; set;}
    public String mrt{get;set;}    
    public Integer numLeft{get;set;}
    public Integer total {get; set;}
    public Integer bnumLeft{get;set;}
    public Integer totalb {get; set;}
    public String objectId {get; set;}
    public String objectIdb {get; set;}
    private Integer x=0;
    private Integer y=0;
    private static Integer PAGESIZE=50;

  /*public List<Market_Survey__c> getMarketSurveys(){
        User u= [select MRKT_ID__c from User where Id=:UserInfo.getUserId()] ;
        Date currDt = Date.today();
    return [select Name,Id,End_Date__c from Market_Survey__c 
        where Market__r.Market_Id__c=:u.MRKT_ID__c
        and Status__c='Deployed'
        and End_Date__c>=:currDt];
  }*/
/*Broadcast Messages Assigned to the Market*/    
    public List<Task> getbroadcast() {
    /*Step1: Get the Current User Market Id*/
        User u= [select MRKT_ID__c from User where Id=:UserInfo.getUserId()] ;
    /*Step2: set the variable 'mrt' to the user market Id*/        
        mrt = u.MRKT_ID__c;
        Market__c market = [select id,Name from Market__c where Market_Id__c=:u.MRKT_ID__c];
    /*Step3: query the Market which is relationship to the Task and place in
    the MRKT_ID in the where criteria to bring up the correct BroadCast Message*/        
        return [Select t.Id,t.Subject, t.Status, t.Priority, 
                    t.IsClosed, t.Description, t.OwnerId,t.ActivityDate 
                            From Task t where Whatid=:market.Id
                            and t.isClosed = false];
        //if (fullBroadList.isEmpty()) {
                              /*){
/*Step4: fill in the List for fullBroadList from the subquery ..separating the
subquery within the main query
                for(Task tk :m.Tasks){
                    fullBroadList.add(tk);
//Step5: Get total number of Task
                bnumLeft = fullBroadList.size();
                totalb=bnumLeft;
                this.objectIdb = ((Task) fullBroadList[0]).id;
                }
            }
        }

        displayBroadMessageList.clear();
        Integer z = y + PAGESIZE;
        if (z > bnumLeft )
        z = bnumLeft ;

        for (Integer i=y; i< z; i++)
        displayBroadMessageList.add(fullBroadList.get(i));
        return displayBroadMessageList;
        */
    }
    
/* Personal Messages Assigned to the User*/    
    public List<Task> getTasks() {
      return [Select t.Id,t.Subject, t.Status, t.Priority, 
                t.IsClosed, t.Description, t.OwnerId,
                t.ActivityDate 
                From Task t
                where t.isClosed = false and 
                t.OwnerId =:UserInfo.getUserId()];
      }

   public PageReference deleteMessage(){
     Task tsk = new Task (Id=tskToClose,Status='Completed');
     update tsk;
     return null;
       
   }
    static testMethod void testmyMessage(){
        Task t1;
      PageReference sigpage = new PageReference('apex/MyMessage');
      Test.setCurrentPage(sigpage);
        TestDataHelper testData = new TestDataHelper();
        Task mktTask = testData.createMarketTask();
        User usr = testData.createUser('USR1','Z1','Standard Platform User');
        Task usrTsk= testData.createTaskForUser(usr);
        MyMessageController ctlr = new MyMessageController ();
        
        System.runAs(usr){
      System.assert(ctlr.getbroadcast().size()==1);            
      System.assert(ctlr.getTasks().size()==1);
      ctlr.tskToClose=usrTsk.Id;
      ctlr.deleteMessage();
      Task tsk = [select Status from Task where Id=:usrTsk.Id];
      System.assertEquals(tsk.Status,'Completed');           
        }
    }


}
			                            	