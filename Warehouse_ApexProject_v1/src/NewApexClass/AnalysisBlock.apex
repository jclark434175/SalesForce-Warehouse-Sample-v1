public class AnalysisBlock {

  public String blockName {get; set;}
  public Boolean col1Enabled {get; set;}
  public Boolean col2Enabled {get; set;}
  public Boolean col3Enabled {get; set;}
  public Boolean col4Enabled {get; set;}
  public Boolean displayTotals {get; set;}
  public String reportId {get; set;}
  
  public List<AnalysisRow> blockRows {get; set;}
  
  public My_Business_Row__c totals {get; set;}
  
  public void addBlockRow(AnalysisRow row){
    if(blockRows == null){
      blockRows = new List<AnalysisRow>();  
    }
    if(this.displayTotals && totals == null){
      totals = new My_Business_Row__c(CurrencyISOCode=row.busRec.CurrencyISOCode,
                      CC_Amt__c=0.0,CC_Cnt__c=0.0,
                      PC_Amt__c=0.0,PC_Cnt__c=0.0,
                      NC_Amt__c=0.0,NC_Cnt__c=0.0,
                      SPPY_Amt__c=0.0,SPPY_Cnt__c=0.0,
                      Data_Type__c=row.busRec.Data_Type__c);
      if(row.reportId!=null){
        this.reportId = row.reportId;
      }                
    }
    System.debug('>>>>>>>>>>>>>>>>>>>>> TOTAL :'+this.totals);
    if(this.displayTotals){
      totals.CC_Amt__c +=(row.busRec.CC_Amt__c!=null?row.busRec.CC_Amt__c:0.0);  
      totals.PC_Amt__c +=(row.busRec.PC_Amt__c!=null?row.busRec.PC_Amt__c:0.0);  
      totals.NC_Amt__c +=(row.busRec.NC_Amt__c!=null?row.busRec.NC_Amt__c:0.0);  
      totals.SPPY_Amt__c +=(row.busRec.SPPY_Amt__c!=null?row.busRec.SPPY_Amt__c:0.0);  

      totals.CC_Cnt__c +=(row.busRec.CC_Cnt__c!=null?row.busRec.CC_Cnt__c:0.0);  
      totals.PC_Cnt__c +=(row.busRec.PC_Cnt__c!=null?row.busRec.PC_Cnt__c:0.0);  
      totals.NC_Cnt__c +=(row.busRec.NC_Cnt__c!=null?row.busRec.NC_Cnt__c:0.0);  
      totals.SPPY_Cnt__c +=(row.busRec.SPPY_Cnt__c!=null?row.busRec.SPPY_Cnt__c:0.0);  
    }
    blockRows.add(row);
  }
  
  public static testmethod void testAnalysisBlock(){
    My_Business_Row__c row;
    row  = new My_Business_Row__c(  Data_Type__c='Currency',
                    CC_Amt__c=10.0,PC_Amt__c=10.0,SPPY_Amt__c=10.0,NC_Amt__c=10.0);
    AnalysisBlock aBlock = new AnalysisBlock();
    aBlock.displayTotals=false;      
    AnalysisRow aRow = new AnalysisRow(row,'1',true);
    aBlock.addBlockRow(aRow);
    System.assert(aBlock.totals == null);
    
    aBlock = new AnalysisBlock();
    aBlock.displayTotals=true;      
    aRow = new AnalysisRow(row,'1',true);
    aBlock.addBlockRow(aRow);
    System.assert(aBlock.totals != null);    
    System.assert(aBlock.totals.CC_Amt__c == 10.0);    
    System.assert(aBlock.totals.PC_Amt__c == 10.0);    
    System.assert(aBlock.totals.NC_Amt__c == 10.0);    
    System.assert(aBlock.totals.SPPY_Amt__c == 10.0);    
    row  = new My_Business_Row__c(  Data_Type__c='Number',
                    CC_Cnt__c=10.0,PC_Cnt__c=10.0,SPPY_Cnt__c=10.0,NC_Cnt__c=10.0);
    aBlock = new AnalysisBlock();
    aBlock.displayTotals=true;      
    aRow = new AnalysisRow(row,'1',true);
    aBlock.addBlockRow(aRow);
    System.assert(aBlock.totals != null);    
    System.assert(aBlock.totals.CC_Cnt__c == 10.0);    
    System.assert(aBlock.totals.PC_Cnt__c == 10.0);    
    System.assert(aBlock.totals.NC_Cnt__c == 10.0);    
    System.assert(aBlock.totals.SPPY_Cnt__c == 10.0);    

    row  = new My_Business_Row__c(  Data_Type__c='Number',
                    CC_Cnt__c=10.0,PC_Cnt__c=10.0,SPPY_Cnt__c=10.0,NC_Cnt__c=10.0);
    aBlock = new AnalysisBlock();
    aBlock.displayTotals=true;      
    aRow = new AnalysisRow(row,null,true);
    aBlock.addBlockRow(aRow);
    System.assert(aBlock.totals != null);    
    System.assert(aBlock.totals.CC_Cnt__c == 10.0);    
    System.assert(aBlock.totals.PC_Cnt__c == 10.0);    
    System.assert(aBlock.totals.NC_Cnt__c == 10.0);    
    System.assert(aBlock.totals.SPPY_Cnt__c == 10.0);    
    
  }
}
			                            	