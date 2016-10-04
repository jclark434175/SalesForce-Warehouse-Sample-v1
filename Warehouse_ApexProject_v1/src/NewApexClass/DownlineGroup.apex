public class DownlineGroup {

  public List<MyDownLineClass> downlines { get; private set; }
  
  public DownlineGroup(){
    //downlines = new  List<Campaign_Order_Detail__c>();
    downlines = new List<MyDownLineClass>();
  }

  public Integer getDownlineCount(){
    return this.downLines.size();
  }
  
  public static testmethod void testDownlineGroup(){
    DownlineGroup grp = new DownlineGroup();
    System.assert(grp.getDownlineCount() == 0);
    grp.downlines.add(new MyDownlineClass(new Genealogy__c(),'test','test'));
    System.assert(grp.getDownlineCount() == 1);    
  }
}
			                            	