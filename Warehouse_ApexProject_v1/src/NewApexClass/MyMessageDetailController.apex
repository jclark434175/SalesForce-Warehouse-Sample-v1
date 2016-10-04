public class MyMessageDetailController{
  public Task taskDetail {get; set;}
  public String msgType {get; set;}
    public MyMessageDetailController() {

    }
    public PageReference init() {
        taskDetail =
            [Select t.Subject, t.Status, t.Priority, 
            t.IsClosed, t.Description, t.OwnerId,t.ActivityDate 
            From Task t where t.isClosed = false 
            And Id=:ApexPages.currentPage().getParameters().get('id')
            ];
    this.msgType = ApexPages.currentPage().getParameters().get('msgType');
    
    return null;
    }
    /*
    public Task getTaskDetail() {
        String id = ApexPages.currentPage().getParameters().get('id');
        return tsk;
    }
    */
    
    public static testmethod void testMyTaskDetail(){
      TestDataHelper testData = new TestDataHelper();
      Task tsk = testData.createMarketTask();
      PageReference pageRef = Page.MyMessageDetail;
      pageRef.getParameters().put('id',tsk.Id);
      Test.setCurrentPageReference(pageRef);
      MyMessageDetailController ctlr = new MyMessageDetailController();
      ctlr.init();
      System.assert(ctlr.taskDetail.Id == tsk.Id);  
    }
}
			                            	