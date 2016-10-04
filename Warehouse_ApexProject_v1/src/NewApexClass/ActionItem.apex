public class ActionItem {

  public String category {get; set;}
  public Integer recCount1 {get; set;}
  public Boolean isDisplayed {get; set;}
  public Boolean isDefault {get; set;}
  public String reportId {get; set;}
  public String marketCd {get; set;}
  public String Priority {get; set;}
  public My_Business_Row__c counts {get; private set;}
    
  public ActionItem (String category,Boolean display,Boolean dflt,String rptId,String mktCd){
    this.category = category;
    this.isDisplayed = display;
    this.isDefault = dflt;
    this.reportId = rptId;
    this.marketCd = mktCd;
    counts = new My_Business_Row__c();
    this.counts.CC_Cnt__c=0;
    this.counts.CC_Amt__c=0;
  }
  
  public void setRecCountAmt(Decimal cnt){
    this.counts.CC_Amt__c = cnt;
  }
  public void setRecCountCnt(Decimal cnt){
    this.counts.CC_Cnt__c = cnt;
  }
  
  public void incrementCount(){
    //Assumes only "Number" type Action Items will require increment
    if(this.counts.CC_Cnt__c==null){
      this.counts.CC_Cnt__c=0;
    }
    this.counts.CC_Cnt__c++;
  }
  public static testmethod void testActionItems(){
    ActionItem item = new ActionItem('cat1',false,true,'1','12334');
    //System.assert(item.recCount1==0);
    System.assert(item.counts.CC_Cnt__c==0);
    System.assert(item.counts.CC_Amt__c==0);
    item.setRecCountAmt(10.12);  
    System.assert(item.counts.CC_Amt__c==10.12);  
    item.setRecCountCnt(10.0);  
    System.assert(item.counts.CC_Cnt__c==10);  
  }
}
			                            	