public class MarketActivityChartController {

  public String chartCurrent {get; set;} 
  public String chartPrior {get; set;} 
  public String ldrLbl {get; set;} 
  public String nonLdrLbl {get; set;} 
  public String salesTitle {get; set;} 
  public String repTitle {get; set;} 
  public String ordersTitle {get; set;} 
  public Sales_Org_Activity__c salesOrgActivity {get; set;}
  
  public String salesChartData {get; set;}
  public String ordersChartData {get; set;}
  public String repChartData {get; set;}
  
  public String getInitialize(){
    createChartData(salesOrgActivity.LDRSHP_NET_SLS_AMT__c,
            salesOrgActivity.TRAD_NET_SLS_AMT__c,
            salesOrgActivity.PC_LDRSHP_NET_SLS_AMT__c,
            salesOrgActivity.PC_TRAD_NET_SLS_AMT__c,
            'Sales');
    createChartData(salesOrgActivity.LDRSHP_ORD_CNT__c,
            salesOrgActivity.TRAD_ORD_CNT__c,
            salesOrgActivity.PC_LDRSHP_ORD_CNT__c,
            salesOrgActivity.PC_TRAD_ORD_CNT__c,
            'Orders');
    createChartData(salesOrgActivity.LDRSHP_STF_CNT__c,
            salesOrgActivity.TRAD_STF_CNT__c,
            salesOrgActivity.PC_LDRSHP_STF_CNT__c,
            salesOrgActivity.PC_TRAD_STF_CNT__c,
            'Reps');
    System.debug('>>>>>>>>>>>>>> salesChartData :'+this.salesChartData);
    System.debug('>>>>>>>>>>>>>> repChartData :'+this.repChartData);
    System.debug('>>>>>>>>>>>>>> ordersChartData :'+this.ordersChartData);
    return '';
  }
  
  private void createChartData(Decimal ccLdrVal,Decimal ccNonLdrVal,Decimal pcLdrVal,Decimal pcNonLdrVal,String chartType){
    GoogleViz viz = new GoogleViz();
    System.debug('>>>>>>>>>>>>>>>>> ccLdrVal='+ccLdrVal);
    System.debug('>>>>>>>>>>>>>>>>> ccNonLdrVal='+ccNonLdrVal);
    System.debug('>>>>>>>>>>>>>>>>> pcLdrVal='+pcLdrVal);
    System.debug('>>>>>>>>>>>>>>>>> pcNonLdrVal='+pcNonLdrVal);
    String valToAssign;
    viz.cols = new List<GoogleViz.col> {
      new GoogleViz.Col('col1', 'Campaign', 't'),
      new GoogleViz.Col('col2', this.ldrLbl, 'n'),
      new GoogleViz.Col('col3', this.nonLdrLbl, 'n')
    };
    GoogleViz.row r;

    r = new GoogleViz.row();
    r.cells.add ( new GoogleViz.cell(this.chartCurrent)); 
    r.cells.add ( new GoogleViz.cell(ccLdrVal)); 
    r.cells.add ( new GoogleViz.cell(ccNonLdrVal));
    viz.addRow( r );

    r = new GoogleViz.row(); 
    r.cells.add ( new GoogleViz.cell(this.chartPrior)); 
    r.cells.add ( new GoogleViz.cell(pcLdrVal)); 
    r.cells.add ( new GoogleViz.cell(pcNonLdrVal)); 
    viz.addRow( r );
    System.debug('>>>>>>>>>>>>>>>>>viz data:'+viz.toJSONString());
    if(chartType == 'Sales'){
      this.salesChartData = viz.toJSONString();
    }else if (chartType == 'Orders'){
      this.ordersChartData= viz.toJSONString();
    }else if (chartType == 'Reps'){
      this.repChartData= viz.toJSONString();
    } 
  }
  
  public static testmethod void testMktChart(){
    MarketActivityChartController ctlr = new MarketActivityChartController();
    String mktIdKey = 'TEST123456';
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createZoneUser('123456');
    testData.createMarket();
    List<Sales_Org_Activity__c> data = testData.createMktActivity(testUsr,'Avon Zone Manager',testUsr.Id);  
    ctlr.chartCurrent = 'Current';  
    ctlr.chartPrior= 'Prior';
    ctlr.ldrLbl = 'Leader';
    ctlr.nonLdrLbl='NonLeader';
    ctlr.repTitle='Title';
    ctlr.salesTitle='Sales';
    ctlr.ordersTitle='Orders';
    ctlr.salesOrgActivity = data[0];
    System.runAs(testUsr){
      ctlr.getInitialize();
      System.debug('>>>>>>>>>>>>>>>>>> Market Activity Chart: Sales Data:'+ctlr.salesChartData);
      System.debug('>>>>>>>>>>>>>>>>>> Market Activity Chart: Rep Data:'+ctlr.repChartData);
      System.debug('>>>>>>>>>>>>>>>>>> Market Activity Chart: Orders Data:'+ctlr.ordersChartData);
      //System.assert(ctlr.salesChartData=='{cols: [{id: "col1", label: "Campaign", type: "t"},{id: "col2", label: "Leader", type: "n"},{id: "col3", label: "NonLeader", type: "n"}], rows: [[{v: "Current"},{v: 10.0},{v: 10.0}],[{v: "Prior"},{v: 10.0},{v: 10.0}]]}');
      //System.assert(ctlr.repChartData=='{cols: [{id: "col1", label: "Campaign", type: "t"},{id: "col2", label: "Leader", type: "n"},{id: "col3", label: "NonLeader", type: "n"}], rows: [[{v: "Current"},{v: 10.0},{v: 10.0}],[{v: "Prior"},{v: 10.0},{v: 10.0}]]}');
      //System.assert(ctlr.ordersChartData=='{cols: [{id: "col1", label: "Campaign", type: "t"},{id: "col2", label: "Leader", type: "n"},{id: "col3", label: "NonLeader", type: "n"}], rows: [[{v: "Current"},{v: 10.0},{v: 10.0}],[{v: "Prior"},{v: 10.0},{v: 10.0}]]}');
    }
    
  }
}
			                            	