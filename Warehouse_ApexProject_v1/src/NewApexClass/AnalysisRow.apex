public class AnalysisRow {
  public My_Business_Row__c busRec {get; set;}
  public String reportId {get; set;}
  public Boolean oddRow {get; set;}
  public AnalysisRow (My_Business_Row__c rec,String rptId){
    this.busRec = rec;
    this.reportId = rptId;
  }
  public AnalysisRow (My_Business_Row__c rec,String rptId,Boolean oddRow){
    this.busRec = rec;
    this.reportId = rptId;
    this.oddRow = oddRow;
  }
  
  public static testmethod void testAnalysisRow(){
    My_Business_Row__c row  = new My_Business_Row__c(  Data_Type__c='Currency',
                    CC_Amt__c=10.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
    AnalysisRow aRow = new AnalysisRow(row,'1',true);
    aRow = new AnalysisRow(row,'1');
  }
}
			                            	