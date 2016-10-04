public class MyBusinessRowWrapper {
  private static String UP = 'UP';
  private static String DOWN = 'DOWN';
  private static String NOT_APPLICABLE = '-NA-';
  private Boolean reverseTrend = false;
  
  public My_Business_Row__c myBusRec {get; set;}
  public MyBusinessRowWrapper(My_Business_Row__c row){
    this(row,false);  
  }
  public MyBusinessRowWrapper(My_Business_Row__c row,Boolean revTrend){
    this.myBusRec = row;
    this.reverseTrend=revTrend;
  }
  public Boolean getReverseTrend(){
    return this.reverseTrend;  
  }
  public String getPCUpDownInd(){
    if(this.myBusRec.Data_Type__c=='Currency'){
      if(this.myBusRec.PC_Amt__c == null || this.myBusRec.CC_Amt__c==null){
        return NOT_APPLICABLE;  
      }else if(this.myBusRec.CC_Amt__c>this.myBusRec.PC_Amt__c){
        return UP;
      }else if(this.myBusRec.CC_Amt__c<this.myBusRec.PC_Amt__c){
        return DOWN;
      }
    }if(this.myBusRec.Data_Type__c=='Number'){
      if(this.myBusRec.PC_Cnt__c == null || this.myBusRec.CC_Cnt__c==null){
        return NOT_APPLICABLE;  
      }else if(this.myBusRec.CC_Cnt__c>this.myBusRec.PC_Cnt__c){
        return UP;
      }else if(this.myBusRec.CC_Cnt__c<this.myBusRec.PC_Cnt__c){
        return DOWN;
      }
    }else{
      return NOT_APPLICABLE;
    }
    return NOT_APPLICABLE;
  }  
  public String getSPPYUpDownInd(){
    if(this.myBusRec.Data_Type__c=='Currency'){
      if(this.myBusRec.CC_Amt__c == null || this.myBusRec.SPPY_Amt__c==null){
        return NOT_APPLICABLE;  
      }else if(this.myBusRec.CC_Amt__c>this.myBusRec.SPPY_Amt__c){
        return UP;
      }else if(this.myBusRec.CC_Amt__c<this.myBusRec.SPPY_Amt__c){
        return DOWN;
      }
    }if(this.myBusRec.Data_Type__c=='Number'){
      if(this.myBusRec.CC_Cnt__c == null || this.myBusRec.SPPY_Cnt__c==null){
        return NOT_APPLICABLE;  
      }else if(this.myBusRec.CC_Cnt__c>this.myBusRec.SPPY_Cnt__c){
        return UP;
      }else if(this.myBusRec.CC_Cnt__c<this.myBusRec.SPPY_Cnt__c){
        return DOWN;
      }
    }else{
      return NOT_APPLICABLE;
    }
    return NOT_APPLICABLE;
    
  }  
  
  public static testmethod void testMyBusRowWrapper(){
    My_Business_Row__c row;
    row  = new My_Business_Row__c(Data_Type__c='Currency',CC_Amt__c=10.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
    MyBusinessRowWrapper wrap;
    wrap = new MyBusinessRowWrapper(row,true);
    System.assert(wrap.getReverseTrend()==true);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getReverseTrend()==false);
    System.assert(wrap.getPCUpDownInd()=='DOWN');  
    System.assert(wrap.getSPPYUpDownInd()=='UP');  
    row  = new My_Business_Row__c(Data_Type__c='Currency',CC_Amt__c=14.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='UP');  
    System.assert(wrap.getSPPYUpDownInd()=='UP');  
    row  = new My_Business_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='DOWN');  
    System.assert(wrap.getSPPYUpDownInd()=='DOWN');  
    row  = new My_Business_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,PC_Amt__c=4.0,SPPY_Amt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='UP');  
    System.assert(wrap.getSPPYUpDownInd()=='DOWN');  

    row  = new My_Business_Row__c(Data_Type__c='Number',CC_Cnt__c=10.0,PC_Cnt__c=11.0,SPPY_Cnt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='DOWN');  
    System.assert(wrap.getSPPYUpDownInd()=='UP');  
    row  = new My_Business_Row__c(Data_Type__c='Number',CC_Cnt__c=14.0,PC_Cnt__c=11.0,SPPY_Cnt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='UP');  
    System.assert(wrap.getSPPYUpDownInd()=='UP');  
    row  = new My_Business_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,PC_Cnt__c=11.0,SPPY_Cnt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='DOWN');  
    System.assert(wrap.getSPPYUpDownInd()=='DOWN');  
    row  = new My_Business_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,PC_Cnt__c=4.0,SPPY_Cnt__c=8.0);
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()=='UP');  
    System.assert(wrap.getSPPYUpDownInd()=='DOWN');  

    row  = new My_Business_Row__c(Data_Type__c='Number');
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()==NOT_APPLICABLE);  
    System.assert(wrap.getSPPYUpDownInd()==NOT_APPLICABLE);  

    row  = new My_Business_Row__c(Data_Type__c='Currency');
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()==NOT_APPLICABLE);  
    System.assert(wrap.getSPPYUpDownInd()==NOT_APPLICABLE);  

    row  = new My_Business_Row__c(Data_Type__c='Text',CC_Txt__c='');
    wrap = new MyBusinessRowWrapper(row);
    System.assert(wrap.getPCUpDownInd()==NOT_APPLICABLE);  
    System.assert(wrap.getSPPYUpDownInd()==NOT_APPLICABLE);  

  }

}
			                            	