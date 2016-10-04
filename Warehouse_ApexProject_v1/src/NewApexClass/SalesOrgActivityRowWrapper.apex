public class SalesOrgActivityRowWrapper {
    private static String UP = 'UP';
    private static String DOWN = 'DOWN';
    private static String NOT_APPLICABLE = '-NA-';
    private Boolean reverseTrend = false;

    public Sales_Activity_Row__c dataRec {get; set;}
    /*Zishan 8/20/09 Added in revTrend Boolean to constructor*/
    public SalesOrgActivityRowWrapper(Sales_Activity_Row__c row,Boolean revTrend){
        this(row,true,revTrend);
    }
    
    public SalesOrgActivityRowWrapper(Sales_Activity_Row__c row,Boolean calcPct, Boolean revTrend){
        this.dataRec = row; 
        this.dataRec = row;
        this.reverseTrend=revTrend;
        if(calcPct){    
            row.LdtTitle1_AMT__c=getPctLdrship();
            row.LdtTitle2_AMT__c=getPctNonLdrship();
        }   
    }
        public Boolean getReverseTrend(){
        return this.reverseTrend;   
    }
    public String getPCUpDownInd(){
        if(this.dataRec.Data_Type__c=='Currency'){
            if(this.dataRec.PC_Amt__c == null || this.dataRec.CC_Amt__c==null){
                return NOT_APPLICABLE;  
            }else if(this.dataRec.CC_Amt__c>this.dataRec.PC_Amt__c){
                return UP;
            }else if(this.dataRec.CC_Amt__c<this.dataRec.PC_Amt__c){
                return DOWN;
            }
        }
        if(this.dataRec.Data_Type__c=='Number'){
            if(this.dataRec.PC_Cnt__c == null || this.dataRec.CC_Cnt__c==null){
                return NOT_APPLICABLE;  
            }else if(this.dataRec.CC_Cnt__c>this.dataRec.PC_Cnt__c){
                return UP;
            }else if(this.dataRec.CC_Cnt__c<this.dataRec.PC_Cnt__c){
                return DOWN;
            }
        }
        return NOT_APPLICABLE;
    }   

    public String getSPPYUpDownInd(){
        if(this.dataRec.Data_Type__c=='Currency'){
            if(this.dataRec.SPPY_Amt__c == null || this.dataRec.CC_Amt__c==null){
                return NOT_APPLICABLE;  
            }else if(this.dataRec.CC_Amt__c>this.dataRec.SPPY_Amt__c){
                return UP;
            }else if(this.dataRec.CC_Amt__c<this.dataRec.SPPY_Amt__c){
                return DOWN;
            }
        }if(this.dataRec.Data_Type__c=='Number'){
            if(this.dataRec.SPPY_Cnt__c == null || this.dataRec.CC_Cnt__c==null){
                return NOT_APPLICABLE;  
            }else if(this.dataRec.CC_Cnt__c>this.dataRec.SPPY_Cnt__c){
                return UP;
            }else if(this.dataRec.CC_Cnt__c<this.dataRec.SPPY_Cnt__c){
                return DOWN;
            }
        }
        return NOT_APPLICABLE;
    }   

    public String getPlanUpDownInd(){
        if(this.dataRec.Data_Type__c=='Currency'){
            if(this.dataRec.Plan_Amt__c == null || this.dataRec.CC_Amt__c==null){
                return NOT_APPLICABLE;  
            }else if(this.dataRec.CC_Amt__c>this.dataRec.Plan_Amt__c){
                return UP;
            }else if(this.dataRec.CC_Amt__c<this.dataRec.Plan_Amt__c){
                return DOWN;
            }
        }if(this.dataRec.Data_Type__c=='Number'){
            if(this.dataRec.Plan_Cnt__c == null || this.dataRec.CC_Cnt__c==null){
                return NOT_APPLICABLE;  
            }else if(this.dataRec.CC_Cnt__c>this.dataRec.Plan_Cnt__c){
                return UP;
            }else if(this.dataRec.CC_Cnt__c<this.dataRec.Plan_Cnt__c){
                return DOWN;
            }
        }
        return NOT_APPLICABLE;
    }   

    public Double getPctLdrship(){
        
        if(this.dataRec.Data_Type__c != 'Text'){
            Double total = getTotalLdrNonLdr();
            if(total >0){
                if(this.dataRec.Ldr_Amt__c!=null && this.dataRec.Data_Type__c =='Currency'){
                    return (this.dataRec.Ldr_Amt__c/total)*100;
                }else if(this.dataRec.Ldr_Cnt__c!=null && this.dataRec.Data_Type__c =='Number'){
                    return (this.dataRec.Ldr_Cnt__c/total)*100;
                }
            }
        }
        return null;
    }
    
    public Double getPctNonLdrship(){
        if(this.dataRec.Data_Type__c != 'Text'){
            Double total = getTotalLdrNonLdr();
            if(total >0){
                if(this.dataRec.NonLdr_Amt__c!=null&&this.dataRec.Data_Type__c =='Currency'){
                    return (this.dataRec.NonLdr_Amt__c/total)*100;
                }else if(this.dataRec.NonLdr_Cnt__c!=null&&this.dataRec.Data_Type__c =='Number'){
                    return (this.dataRec.NonLdr_Cnt__c/total)*100;
                }
            }
        }
        return null;
    }
    
    private Decimal getTotalLdrNonLdr(){
        Decimal ldrVal,nonLdrVal;
        ldrVal = 0.0;
        nonLdrVal = 0.0;
        if(this.dataRec.Data_Type__c =='Currency'){
            ldrVal = this.dataRec.Ldr_Amt__c;
            nonLdrVal = this.dataRec.NonLdr_Amt__c;
        }
        if(this.dataRec.Data_Type__c =='Number'){
            ldrVal = this.dataRec.Ldr_Cnt__c;
            nonLdrVal = this.dataRec.NonLdr_Cnt__c;
        }
        return (ldrVal!=null?ldrVal:0.0) + (nonLdrVal!=null?nonLdrVal:0.0);
    }
    
    public static testmethod void testSlsOrgRowWrapper(){
    /*Zishan added in 8/20/09 wrap = new SalesOrgActivityRowWrapper(row,true); from wrap = new SalesOrgActivityRowWrapper(row);*/
        Sales_Activity_Row__c row;
        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=10.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
        SalesOrgActivityRowWrapper wrap;
        wrap = new SalesOrgActivityRowWrapper(row,true);
        System.assert(wrap.getReverseTrend()==true);
        System.assert(wrap.getPCUpDownInd()=='DOWN');   
        System.assert(wrap.getSPPYUpDownInd()=='UP');   
        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=14.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='UP'); 
        System.assert(wrap.getSPPYUpDownInd()=='UP');   
        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,PC_Amt__c=11.0,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='DOWN');   
        System.assert(wrap.getSPPYUpDownInd()=='DOWN'); 
        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,PC_Amt__c=4.0,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='UP'); 
        System.assert(wrap.getSPPYUpDownInd()=='DOWN'); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=10.0,PC_Cnt__c=11.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='DOWN');   
        System.assert(wrap.getSPPYUpDownInd()=='UP');   
        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=14.0,PC_Cnt__c=11.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='UP'); 
        System.assert(wrap.getSPPYUpDownInd()=='UP');   
        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,PC_Cnt__c=11.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='DOWN');   
        System.assert(wrap.getSPPYUpDownInd()=='DOWN'); 
        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,PC_Cnt__c=4.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()=='UP'); 
        System.assert(wrap.getSPPYUpDownInd()=='DOWN'); 


        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=null,Plan_Cnt__c=null,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=100.0,Plan_Cnt__c=null,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=null,Plan_Cnt__c=40.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,Plan_Cnt__c=4.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()=='UP');   

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,Plan_Cnt__c=40.0,SPPY_Cnt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()=='DOWN'); 


        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=null,Plan_Amt__c=null,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=100.0,Plan_Amt__c=null,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=null,Plan_Amt__c=40.0,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,Plan_Amt__c=4.0,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()=='UP');   

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,Plan_Amt__c=40.0,SPPY_Amt__c=8.0);
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPlanUpDownInd()=='DOWN'); 



        row  = new Sales_Activity_Row__c(Data_Type__c='Text');
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==null);  
        System.assert(wrap.getPctNonLdrship()==null);   

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,Plan_Amt__c=40.0,SPPY_Amt__c=8.0,
                                         Ldr_Amt__c=10.0,NonLdr_Amt__c=10.0);
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==50.0);  
        System.assert(wrap.getPctNonLdrship()==50.0);   

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,Plan_Amt__c=40.0,SPPY_Amt__c=8.0,
                                         Ldr_Amt__c=10.0,NonLdr_Amt__c=0.0);
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==100.0); 
        System.assert(wrap.getPctNonLdrship()==0.0);    

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency',CC_Amt__c=6.0,Plan_Amt__c=40.0,SPPY_Amt__c=8.0,
                                         Ldr_Amt__c=0.0,NonLdr_Amt__c=10.0);
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==0.0);   
        System.assert(wrap.getPctNonLdrship()==100.0);  



        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,Plan_Cnt__c=40.0,SPPY_Cnt__c=8.0,
                                         Ldr_Cnt__c=10.0,NonLdr_Cnt__c=10.0);
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==50.0);  
        System.assert(wrap.getPctNonLdrship()==50.0);   

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,Plan_Cnt__c=40.0,SPPY_Cnt__c=8.0,
                                         Ldr_Cnt__c=10.0,NonLdr_Cnt__c=0.0);
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==100.0); 
        System.assert(wrap.getPctNonLdrship()==0.0);    

        row  = new Sales_Activity_Row__c(Data_Type__c='Number',CC_Cnt__c=6.0,Plan_Cnt__c=40.0,SPPY_Cnt__c=8.0,
                                         Ldr_Cnt__c=0.0,NonLdr_Cnt__c=10.0);
    
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPctLdrship()==0.0);   
        System.assert(wrap.getPctNonLdrship()==100.0);  
        row  = new Sales_Activity_Row__c(Data_Type__c='Number');
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()==NOT_APPLICABLE);   
        System.assert(wrap.getSPPYUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Currency');
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()==NOT_APPLICABLE);   
        System.assert(wrap.getSPPYUpDownInd()==NOT_APPLICABLE); 

        row  = new Sales_Activity_Row__c(Data_Type__c='Text',CC_Txt__c='');
        wrap = new SalesOrgActivityRowWrapper(row,false);
        System.assert(wrap.getPCUpDownInd()==NOT_APPLICABLE);   
        System.assert(wrap.getSPPYUpDownInd()==NOT_APPLICABLE); 

    }
    
}
			                            	