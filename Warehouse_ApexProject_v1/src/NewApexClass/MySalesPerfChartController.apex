public class MySalesPerfChartController {
  public My_Business_Row__c awardSales {get; set;}
  public My_Business_Row__c netSales {get; set;}
  public String chartCurrent {get; set;}
  public String chartPrior {get; set;}
  public Market__c market {get; set;}
  public String awardSalesLabel {get; set;}
  public String netSalesLabel {get; set;}  
  public String chartData {get; private set;}
  public String getInitialize(){
    GoogleViz chartDataViz = new GoogleViz();
    chartDataViz.cols = new List<GoogleViz.col>();
    chartDataViz.cols.add(new GoogleViz.Col('col1', 'Sales Category', 't'));
    chartDataViz.cols.add(new GoogleViz.Col('col2', chartCurrent, 'n'));
    if(market.My_Bus_PC_Enabled__c){
      chartDataViz.cols.add(new GoogleViz.Col('col3', chartPrior, 'n'));
    }
    System.debug('>>>>>>>>>>>>>>>> awardSales:'+awardSales);
    System.debug('>>>>>>>>>>>>>>>> netSales:'+netSales);
    GoogleViz.row r;
    if(this.awardSales !=null){
      r = new GoogleViz.row();
      r.cells.add ( new GoogleViz.cell(awardSalesLabel)); 
      r.cells.add ( new GoogleViz.cell( (awardSales.CC_Amt__c==null?0.0:awardSales.CC_Amt__c) )); 
      if(market.My_Bus_PC_Enabled__c){
        r.cells.add ( new GoogleViz.cell( (awardSales.PC_Amt__c==null?0.0:awardSales.PC_Amt__c) ));
      } 
      chartDataViz.addRow( r );
    }
    if(this.netSales!=null){
      r = new GoogleViz.row();
      r.cells.add ( new GoogleViz.cell(netSalesLabel)); 
      r.cells.add ( new GoogleViz.cell( (netSales.CC_Amt__c==null?0.0:netSales.CC_Amt__c) )); 
      if(market.My_Bus_PC_Enabled__c){
        r.cells.add ( new GoogleViz.cell( (netSales.PC_Amt__c==null?0.0:netSales.PC_Amt__c) ));
      } 
      chartDataViz.addRow( r );
    }    
    System.debug('>>>>>>>>>>>>>>>>> chartDataViz.toJSONString()='+chartDataViz.toJSONString());
    this.chartData = chartDataViz.toJSONString();
    return '';
  }

  public static testmethod void testMySalesChart(){
    My_Business_Row__c row = new My_Business_Row__c(CC_Amt__c=10,PC_Amt__c=10.0);
    Market__c mkt = new Market__c(My_Bus_PC_Enabled__c=true);
    MySalesPerfChartController ctlr = new MySalesPerfChartController();
    ctlr.market=mkt;
    ctlr.awardSales = row;
    ctlr.netSales = row;
    ctlr.chartCurrent = 'Current';  
    ctlr.chartPrior= 'Prior';
    ctlr.awardSalesLabel ='Award Sales';
    ctlr.netSalesLabel = 'Net Sales';
    ctlr.getInitialize();
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>MySalesChart : chart Data='+ctlr.chartData);
    
    ctlr = new MySalesPerfChartController();
    mkt = new Market__c(My_Bus_PC_Enabled__c=false);
    ctlr.market=mkt;
    ctlr.awardSales = row;
    ctlr.netSales = row;
    ctlr.chartCurrent = 'Current';  
    ctlr.chartPrior= 'Prior';
    ctlr.awardSalesLabel ='Award Sales';
    ctlr.netSalesLabel = 'Net Sales';
    ctlr.getInitialize();
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>MySalesChart : chart Data='+ctlr.chartData);    
    //System.assert(ctlr.chartData=='{cols: [{id: "col1", label: "Sales Category", type: "t"},{id: "col2", label: "Current", type: "n"},{id: "col3", label: "Prior", type: "n"}], rows: [[{v: "Award Sales"},{v: 10.0},{v: 10.0}],[{v: "Net Sales"},{v: 10.0},{v: 10.0}]]}');
  }
}
			                            	