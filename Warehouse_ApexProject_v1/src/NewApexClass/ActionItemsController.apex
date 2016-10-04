public class ActionItemsController {
  
  public String repAcctNbr {get; set;}
  public Boolean isZoneUser {get; set;}
  public Integer itemsToDisplay {get; set;}
  private User currUser;
  public Market__c market {get; set;}
  public SObject summaryObj {get; set;} 
  public List<ActionItem> orderActionItems;
  public List<ActionItem> salesActionItems;
  public List<ActionItem> busActionItems;
  private Map<String,ActionItem> allActionItems;
  public String userProfile {get; private set;}
  private Boolean initalized =false;
  public Integer nbrMplans {get; private set;}
   
  private static String BASE_SOQL=
                  'Select MRKT_ACCT_KEY__c,'+ 
                  '    LDRSHP_TITL_LVL_NR__c, Id,'+ 
                  '    DWNLN_GENRTN_LVL_CNT__c, ACCT_NR__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_HOLD_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_UND_MIN__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_DEFAULT__c,'+
                  '    Personal_Sales__r.ActionItem_AWRD_SLS_MIN__c,'+
                  '    Personal_Sales__r.ActionItem_NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_PAST_DUE_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_ABV_MIN__c,'+  
                  '    Personal_Sales__r.ActionItem_RTRN_NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_PENDNG_ORD_CNT__c,'+  
                  '    ActionItem_ORD_NOT_SUBMITTED__c,'+
                  '    Personal_Sales__c,Group_Sales__c,'+
                  '    Personal_Sales__r.NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.AWRD_SLS_AMT__c,'+
                  '    Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c,'+
                  '    Representative__r.Name,'+
                  '    Representative__r.LDRSHP_TITL_LVL_NBR__c,'+
                  '    Representative__r.MRKT_TOP_SLR_LANG_KEY__c,'+
                  '    Representative__r.Phone, '+
                  '    Representative__r.ANNIV_WITHIN_10_DAYS__c,'+
                  '    UPLN_GENRTN_1_ACCT_NR__c,'+  
                  '    UPLN_GENRTN_2_ACCT_NR__c,'+  
                  '    UPLN_GENRTN_3_ACCT_NR__c '+  
                  'From   Genealogy__c '+
                  'Where  MRKT_ID__c=:mktId '+
                  'and  (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr OR '+
                  '     UPLN_GENRTN_3_ACCT_NR__c=:critRepAcctNbr OR '+
                  '     UPLN_GENRTN_2_ACCT_NR__c=:critRepAcctNbr) ' +
                  'and  Representative__r.REP_OMS_STUS_CD__c=\'1\' ';
  
  public String getInitialize(){
    orderActionItems = new List<ActionItem>();
    salesActionItems = new List<ActionItem>();
    busActionItems = new List<ActionItem>();
    allActionItems = new Map<String,ActionItem>();
    List<Market_Action_Items__c> dwnLnBasedActions = new List<Market_Action_Items__c>();
    List<Market_Action_Items__c> smryBasedActions = new List<Market_Action_Items__c>();
    Leader_Title__c usrTitle;
    MarketLeaderTitleUtils ldrTitlUtils;
    ActionItem dispItem;
    
    if(this.market == null){
      this.currUser = [select LanguageLocaleKey,MRKT_ID__c,ACCT_NR__c,MRKT_ID_ACCT_NR_KEY__c
               from User 
                where Id=:UserInfo.getUserId()];
      this.userProfile = [select Name from Profile where Id = :UserInfo.getProfileId()].Name;

      this.market = [  Select   Mail_Plan_Enabled__c,
                  Market_Id__c,Name,Id,
                  Action_Item_Mail_Plans__c,
                  OPERTNL_CMPGN_CMPLTN_PCT__c
                  From Market__c 
              where  Market_Id__c=:currUser.MRKT_ID__c];
            
    }
    System.debug('^^^^^^^^^^^^^^^^^^^^^^ userProfile='+this.userProfile);
    if(this.userProfile =='Avon Leader')
    {
      Contact usrContact = [  select   Name,LDRSHP_TITL_LVL_NBR__c,MRKT_TOP_SLR_LANG_KEY__c,
                          MLPLN_CD__c 
                      from Contact 
                      where MRKT_ACCT_KEY__c=:currUser.MRKT_ID_ACCT_NR_KEY__c];
      System.debug('>>>>>>>>>>>>>>>>>>>>>>>> User Contact:'+usrContact);
      ldrTitlUtils = new MarketLeaderTitleUtils();
      usrTitle = ldrTitlUtils.initializeAndRetTitle(currUser,usrContact.LDRSHP_TITL_LVL_NBR__c);
      
      for(Market_Action_Items__c item:[  Select  Action_Item__r.Zone_Or_Leader__c, Threshold__c, 
                        Action_Item__r.Smry_Criteria_Fld__c, Report__r.Report_Id__c, 
                        Action_Item__r.Order_Criteria_Fld__c,Action_Item__r.Rep_Criteria_Fld__c,
                        Action_Item__r.Genealogy_Criteria_Fld__c,Action_Item__r.Default__c,
                        Priority__c, Market__c, Campaign_Stage__c, 
                        Action_Item__r.Action_Item_Type__c,Action_Item__r.Category__c,
                        Action_Item__r.Subject_Area__c,Action_Item__r.Datatype__c
                    From   Market_Action_Items__c
                    where  Market__c=:this.market.Id
                    and    Action_Item__r.Zone_Or_Leader__c = 'Leader'
                    order by Action_Item__r.Subject_Area__c,Priority__c asc])
      {
        if(item.Action_Item__r.Action_Item_Type__c=='Downline'){
          dwnLnBasedActions.add(item);
        }
        if(item.Action_Item__r.Action_Item_Type__c=='Summary')
        {
          smryBasedActions.add(item);
        }
        
        dispItem=new ActionItem(item.Action_Item__r.Category__c,false,
                    item.Action_Item__r.Default__c,item.Report__r.Report_Id__c,
                    this.market.Market_Id__c);

        dispItem.Priority = item.Priority__c;
        
        if(item.Action_Item__r.Subject_Area__c=='Orders'){
          orderActionItems.add(dispItem);
        }
        if(item.Action_Item__r.Subject_Area__c=='Sales'){
          salesActionItems.add(dispItem);
        }
        if(item.Action_Item__r.Subject_Area__c=='Current Business'){
          busActionItems.add(dispItem);
        }
        allActionItems.put(item.Action_Item__r.Subject_Area__c+':'+item.Action_Item__r.Category__c,dispItem);
      }
    }else if(this.userProfile =='Avon Zone Manager' || this.userProfile =='Avon Division Manager'){
      for(Market_Action_Items__c item:[  Select  Action_Item__r.Zone_Or_Leader__c, Threshold__c, 
                        Action_Item__r.Smry_Criteria_Fld__c, Report__r.Report_Id__c, 
                        Action_Item__r.Order_Criteria_Fld__c,Action_Item__r.Rep_Criteria_Fld__c,
                        Action_Item__r.Genealogy_Criteria_Fld__c,Action_Item__r.Default__c,
                        Priority__c, Market__c, Campaign_Stage__c, 
                        Action_Item__r.Action_Item_Type__c,Action_Item__r.Category__c,
                        Action_Item__r.Subject_Area__c,Action_Item__r.Datatype__c
                    From   Market_Action_Items__c
                    where  Market__c=:this.market.Id
                    and    Action_Item__r.Zone_Or_Leader__c = 'Zone'
                    order by Action_Item__r.Subject_Area__c,Priority__c asc])
      {
        
        /*
        for Zone Manager and above, all action items are Summary Based
        */
        smryBasedActions.add(item);
        if(item.Action_Item__r.Default__c){
          dispItem=new ActionItem(item.Action_Item__r.Category__c,true,true,item.Report__r.Report_Id__c,this.market.Market_Id__c);
        }else{
          dispItem=new ActionItem(item.Action_Item__r.Category__c,false,false,item.Report__r.Report_Id__c,this.market.Market_Id__c);
        }
        dispItem.Priority = item.Priority__c;
        
        if(item.Action_Item__r.Subject_Area__c=='Orders'){
          orderActionItems.add(dispItem);
        }
        if(item.Action_Item__r.Subject_Area__c=='Sales'){
          salesActionItems.add(dispItem);
        }
        if(item.Action_Item__r.Subject_Area__c=='Current Business'){
          busActionItems.add(dispItem);
        }
        allActionItems.put(item.Action_Item__r.Subject_Area__c+':'+item.Action_Item__r.Category__c,dispItem);
      }
      
    }
    String critRepAcctNbr = this.repAcctNbr;
    //For Downline Base Action Items
    My_Business__c prsnlOrder;
    String fldValue;
    String actItemKey;
    SObject objToEval;
    String mailPlansToLook = '';
    if(this.market.Mail_Plan_Enabled__c && this.userProfile == 'Avon Leader'){
      this.nbrMplans = Integer.valueOf(this.market.Action_Item_Mail_Plans__c+'');
      Date dtCritStart = System.today();
      Date dtCritEnd = getMailPlanEndDt(nbrMplans);
      String tempMlplans = '';
      System.debug('Looking for Mail Plans between '+dtCritStart+' and '+dtCritEnd);
      for(MailPlan_Order_Oppty__c mailPlan: [ Select   MLPLN_CD__c, MLPLN_END_DT__c
                          From   MailPlan_Order_Oppty__c  
                          where  Market__c = :this.market.Id
                          and   MLPLN_END_DT__c > :dtCritStart
                          and   MLPLN_END_DT__c <= :dtCritEnd])
      {
        if(!mailPlansToLook.contains(mailPlan.MLPLN_CD__c)){
          mailPlansToLook +='\''+mailPlan.MLPLN_CD__c+'\',';
        }
      }
      if(mailPlansToLook.length()>0){
        mailPlansToLook =mailPlansToLook.substring(0,mailPlansToLook.length()-1);
      }
      System.debug('>>>>>>> mails plans to look:'+mailPlansToLook);
      if(dwnLnBasedActions.size()>0){
        System.debug('>>>>>>>>>>>>> inside Downline based Action items');
        String actItmSoql = BASE_SOQL;
        if(this.market.Mail_Plan_Enabled__c){
          actItmSoql +=' and Representative__r.MLPLN_CD__c in ('+mailPlansToLook+') ';
          
        }
        System.debug('>>>>>>SOQL='+actItmSoql);
        String mktId = this.market.Market_Id__c;
        for(Genealogy__c downline:Database.query(actItmSoql)){
          prsnlOrder = downline.Personal_Sales__r;
          //System.debug('>>>>>>>>>>>>>>>>downline='+downline);
          for(Market_Action_Items__c actItem : dwnLnBasedActions){
            //System.debug('>>>>>Order_Criteria_Fld__c='+actItem.Action_Item__r.Order_Criteria_Fld__c);
            //System.debug('>>>>>Rep_Criteria_Fld__c='+actItem.Action_Item__r.Rep_Criteria_Fld__c);
            //System.debug('>>>>>Genealogy_Criteria_Fld__c='+actItem.Action_Item__r.Genealogy_Criteria_Fld__c);
            actItemKey = actItem.Action_Item__r.Subject_Area__c+':'+actItem.Action_Item__r.Category__c;
            dispItem = allActionItems.get(actItemKey);
            //System.debug('>>>>>dispItem = '+dispItem);
            //System.debug('>>>>>downline.Personal_Sales__c = '+downline.Personal_Sales__c);
            if(actItemKey=='Orders:Orders / Sales under minimum'){
              if(isOrderBelowMin(usrTitle,downline)=='Y'){
                dispItem.isDisplayed = true;
                dispItem.incrementCount();
              }
            } else if (actItemKey=='Sales:Minimum Order Size'){
              if(isOrderBelowMin(usrTitle,downline)=='N'){
                dispItem.isDisplayed = true;
                dispItem.incrementCount();
              }
            }else{
              if(  downline.Personal_Sales__r!=null &&
                actItem.Action_Item__r.Order_Criteria_Fld__c!=null && 
                actItem.Action_Item__r.Order_Criteria_Fld__c !='')
              {
                fldValue = (String)downline.Personal_Sales__r.get(actItem.Action_Item__r.Order_Criteria_Fld__c);
                if(fldValue == 'TRUE'){
                  if(actItemKey=='Orders:Orders Not submitted'){
                    System.debug('>>>>>downline.MRKT_ACCT_KEY__c = '+downline.MRKT_ACCT_KEY__c);
                    System.debug('>>>>>fldValue = '+fldValue);
                  }
                  dispItem.isDisplayed = true;
                  dispItem.incrementCount();
                }
              }
            }
            /*if(actItem.Action_Item__r.Rep_Criteria_Fld__c!=null && actItem.Action_Item__r.Rep_Criteria_Fld__c !=''){
              fldValue = (String)downline.Representative__r.get(actItem.Action_Item__r.Rep_Criteria_Fld__c);
              System.debug('>>>>>fldValue = '+fldValue);
              if(fldValue == 'TRUE'){
                dispItem.isDisplayed = true;
                dispItem.incrementCount();
              }
              
            }
            if(actItem.Action_Item__r.Genealogy_Criteria_Fld__c!=null && actItem.Action_Item__r.Genealogy_Criteria_Fld__c !=''){
              fldValue = (String)downline.get(actItem.Action_Item__r.Genealogy_Criteria_Fld__c);
              System.debug('>>>>>fldValue = '+fldValue);
              if(fldValue == 'TRUE'){
                dispItem = allActionItems.get(actItemKey);
                dispItem.isDisplayed = true;
                dispItem.incrementCount();
              }
              
            }*/
            
          }
        }
      }
    }
    Decimal fldVal;
    if(smryBasedActions.size()>0){
      //System.debug('>>>>>>>>>>>>Summary Object'+this.summaryObj);
      //System.debug('>>>>>>>>>>>>All Aciton Items:'+this.allActionItems);
      if(this.summaryObj !=null){
        for(Market_Action_Items__c actItem : smryBasedActions){
          //System.debug('>>>>>Smry_Criteria_Fld__c='+actItem.Action_Item__r.Smry_Criteria_Fld__c);
          //System.debug('>>>>>Threshold__c='+actItem.Threshold__c);
          fldVal = getFieldValue(this.summaryObj,actItem.Action_Item__r.Smry_Criteria_Fld__c);
          actItemKey = actItem.Action_Item__r.Subject_Area__c+':'+actItem.Action_Item__r.Category__c;
          dispItem = allActionItems.get(actItemKey);
          //System.debug('>>>>>actItemKey                             = '+actItemKey);
          //System.debug('>>>>>fldVal                                 = '+fldVal);
          //System.debug('>>>>>Threshold__c                           = '+actItem.Threshold__c);
          //System.debug('>>>>>market.OPERTNL_CMPGN_CMPLTN_PCT__c     = '+this.market.OPERTNL_CMPGN_CMPLTN_PCT__c);
           //System.debug('>>>>>actItem.Campaign_Stage__c              = '+actItem.Campaign_Stage__c);
          if(!actItem.Action_Item__r.Default__c){
            
            //System.debug('>>>>>dispItem = '+dispItem);
            //fldVal = getFieldValue(this.summaryObj,actItem.Action_Item__r.Smry_Criteria_Fld__c);
            if(fldVal >= actItem.Threshold__c && this.market.OPERTNL_CMPGN_CMPLTN_PCT__c >= actItem.Campaign_Stage__c){
              dispItem.IsDisplayed = true;
            }
          }
          dispItem.setRecCountCnt(fldVal);            
          //System.debug('>>>>>>>>>>>>>>>>>> Action Item:'+dispItem);
        }
      }
    }
    
    /*
      For Markets that don't have mail plans the downline based
      action items are same as summary action items. 
    */
    //System.debug('>>>>>>>> MAIL_PLAN_ENABLED='+this.market.Mail_Plan_Enabled__c);
    //System.debug('>>>>>>>> dwnLnBasedActions.size()='+dwnLnBasedActions.size());
    //System.debug('>>>>>>>> this.userProfile='+this.userProfile);
    if(!this.market.Mail_Plan_Enabled__c && this.userProfile == 'Avon Leader'){
      for(Market_Action_Items__c actItem : dwnLnBasedActions){
        //System.debug('>>>>>Smry_Criteria_Fld__c='+actItem.Action_Item__r.Smry_Criteria_Fld__c);
        //System.debug('>>>>>Threshold__c='+actItem.Threshold__c);
        fldVal = getFieldValue(this.summaryObj,actItem.Action_Item__r.Smry_Criteria_Fld__c);
        actItemKey = actItem.Action_Item__r.Subject_Area__c+':'+actItem.Action_Item__r.Category__c;
        dispItem = allActionItems.get(actItemKey);
        //System.debug('>>>>>actItemKey                             = '+actItemKey);
        //System.debug('>>>>>fldVal                                 = '+fldVal);
        //System.debug('>>>>>Threshold__c                           = '+actItem.Threshold__c);
        //System.debug('>>>>>market.OPERTNL_CMPGN_CMPLTN_PCT__c     = '+this.market.OPERTNL_CMPGN_CMPLTN_PCT__c);
        //System.debug('>>>>>actItem.Campaign_Stage__c              = '+actItem.Campaign_Stage__c);
        if(!actItem.Action_Item__r.Default__c){
//              actItemKey = actItem.Action_Item__r.Subject_Area__c+':'+actItem.Action_Item__r.Category__c;
          
          //System.debug('>>>>>dispItem = '+dispItem);
          //System.debug('>>>>>fldVal                                 = '+fldVal);
          //System.debug('>>>>>Threshold__c                           = '+actItem.Threshold__c);
          //System.debug('>>>>>market.OPERTNL_CMPGN_CMPLTN_PCT__c     = '+this.market.OPERTNL_CMPGN_CMPLTN_PCT__c);
          if(fldVal >= actItem.Threshold__c && this.market.OPERTNL_CMPGN_CMPLTN_PCT__c >= actItem.Campaign_Stage__c){
            dispItem.IsDisplayed = true;
          }
        }
        if(actItem.Action_Item__r.Datatype__c=='Currency'){
          dispItem.setRecCountAmt(fldVal);
        }else{
          dispItem.setRecCountCnt(fldVal);            
        }
      }
    }
    //initalized=true;
    return '';  
  }
  
  public List<ActionItem> getOrderActionItems(){
    System.debug('>>>>>>>>>>>>>> ORDER ACTION ITEMS ALL:');
    System.debug('>>>>>>>>>>>>>>'+this.orderActionItems);
    return getTopActionItems(this.orderActionItems);
  }
  public List<ActionItem> getSalesActionItems(){
    System.debug('>>>>>>>>>>>>>> SALES ACTION ITEMS ALL:');
    System.debug('>>>>>>>>>>>>>>'+this.salesActionItems);
    return getTopActionItems(this.salesActionItems);
  }
  public List<ActionItem> getBusActionItems(){
    System.debug('>>>>>>>>>>>>>> C-BUSINESS ACTION ITEMS ALL:');
    System.debug('>>>>>>>>>>>>>>'+this.busActionItems);
    return getTopActionItems(this.busActionItems);
  }
  
  private List<ActionItem> getTopActionItems(List<ActionItem> actItemList){

    List<ActionItem> tempList = new List<ActionItem>();
    Integer nbrItemsDisplayed = 0;
    if(actItemList != null){
      for(ActionItem item:actItemList){
        if(tempList.size()==this.itemsToDisplay){
          break;
        }else if(item.IsDisplayed && !item.IsDefault){
          System.debug('>>>>>>>>>> adding Action Item:'+item+' to Display List');
          tempList.add(item);
        }    
      }  
    }
    System.debug('>>>>>>>>>>>>>> Temp List after adding Displayed Action Items:'+tempList);
    if(tempList.size()<this.itemsToDisplay){
      if(actItemList != null){
        for(ActionItem item:actItemList){
          if(tempList.size()==this.itemsToDisplay){
            break;
          }else if(item.IsDefault){
            System.debug('>>>>>>>>>> adding Action Item:'+item+' to Display List');
            tempList.add(item);
          }    
        }
      }  
    }
    System.debug('>>>>>>>>>>>>>> Temp List after adding default Action Items:'+tempList);
    return tempList;
  } 
  
  private Decimal getFieldValue(Sobject currRec,String colFlds){
    Decimal totVal = 0.0;
    System.debug('>>>>>>>>>>>>>>> colFlds'+colFlds);
    String tempFld;
    if(colFlds!=null){
      for(String fldName: colFlds.split('\n')){
        tempFld = fldName.trim();
        totVal+=(currRec.get(tempFld)!=null?(Decimal)currRec.get(tempFld):0.0);
      }
    }
    return totVal;
  }

  private String isOrderBelowMin(Leader_Title__c ldrTitle,Genealogy__c downline){
    //System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.AWRD_SLS_AMT__c='+rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c);
    //System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.minToEarn='+rptRow.minToEarn);
    DrilldownReportRow rptRow = new DrilldownReportRow(currUser.ACCT_NR__c,downline,false);
    String genNbr = rptRow.getDownlineGenNbr();
    if(genNbr == 'I'){
      rptRow.minToEarn = ldrTitle.GENRTN_1_MIN_ORD_AMT__c;  
    }  
    else if(genNbr == 'II'){
      rptRow.minToEarn = ldrTitle.GENRTN_2_MIN_ORD_AMT__c;  
    }  
    else if(genNbr == 'III'){
      rptRow.minToEarn = ldrTitle.GENRTN_3_MIN_ORD_AMT__c;  
    }  
    /*System.debug('>>>>>>>>>>>> ldrTitle.GENRTN_1_MIN_ORD_AMT__c='+ldrTitle.GENRTN_1_MIN_ORD_AMT__c+
           ',ldrTitle.GENRTN_2_MIN_ORD_AMT__c='+ldrTitle.GENRTN_2_MIN_ORD_AMT__c+','+
           'ldrTitle.GENRTN_3_MIN_ORD_AMT__c='+ldrTitle.GENRTN_3_MIN_ORD_AMT__c);
    System.debug('>>>>>>>>>>>> genNbr='+genNbr);
    */
    if(rptRow.row.Personal_Sales__c ==null){
      //System.debug('>>>>>>>>>>>> isOrderBelowMin: Condition 1');
      return '-na-';  
    }else if(rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c ==null){
      return '-na-';
    }else if(rptRow.row.Personal_Sales__r.NET_SLS_AMT__c>0 &&
         rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c>=0 && 
         rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c < rptRow.minToEarn){
      //System.debug('>>>>>>>>>>>> isOrderBelowMin: Condition 3');
      return 'Y';
    }else if(rptRow.row.Personal_Sales__r.NET_SLS_AMT__c>0 &&
         rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c>=0 && 
         rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c >= rptRow.minToEarn)
    {
      //System.debug('>>>>>>>>>>>> isOrderBelowMin: Condition 4');
      return 'N';
    }else{
      return '-na-';
    }
  }

  public Date getMailPlanEndDt(Integer nbrDays){
    Date currDt = Date.today();
    Date retDt=currDt;
    for(Integer idx=0;idx<nbrDays;idx++){
      retDt=getNextWorkingDate(retDt);  
    }
    return retDt;
  }
  /*
    Get the next working day that does not fall on a weekend
  */
  public Date getNextWorkingDate(Date startDt){
    Date weekStart = startDt.toStartOfWeek();
    Date retDt;
    if(weekStart.daysBetween(startDt) == 5){
      //If Friday, look ahead 3 days so that you look at Monday
      retDt=startDt.addDays(3);
    }else if(weekStart.daysBetween(startDt) == 6){
      //If Saturday, look ahead 3 days so that you look at Monday
      retDt=startDt.addDays(2);
    }else{
      //Otherwise look ahead 1 day only
      retDt=startDt.addDays(1);
    }
    return retDt;
    
  }

  public static testmethod void testActionItemsWithoutMPlans(){
  
    ActionItemsController ctlr = new ActionItemsController();
    String mktIdKey = 'U123456';
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createLeaderUser('U123456');
    testData.createDownlineData('U123456',2,testUsr.Id);
    testData.createActionItems();
    testData.createMarketActionItems();
    /*List<Genealogy__c> tempGeneData = [Select MRKT_ACCT_KEY__c, Personal_Sales__c,Group_Sales__c,Representative__r.MLPLN_CD__c 
                      From  Genealogy__c 
                      Where  (UPLN_GENRTN_1_ACCT_NR__c='U123456' OR    
                          UPLN_GENRTN_3_ACCT_NR__c='U123456' OR   
                          UPLN_GENRTN_2_ACCT_NR__c='U123456') 
                      and Representative__r.MLPLN_CD__c in ('M4','M3','M2','M1','M0')];
    
    System.debug('############################tempGeneData##############################');
    System.debug('tempGeneData='+tempGeneData);*/
    List<Leader_Downline_Summary__c> ldrData = testData.createLdrSmryData(testUsr.MRKT_ID_ACCT_NR_KEY__c,testUsr.Id);
    ctlr.summaryObj = ldrData[0];
    testData.market.Mail_Plan_Enabled__c=false;
    update testData.market;
    System.runAs(testUsr){
      ctlr.repAcctNbr=mktIdKey;
      ctlr.getInitialize();
      ctlr.getOrderActionItems();
      ctlr.getSalesActionItems();
      ctlr.getBusActionItems();
    }

  }  
  public static testmethod void testActionItemsWithMPlans(){
  
    ActionItemsController ctlr = new ActionItemsController();
    String mktIdKey = 'U123456';
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createLeaderUser('U123456');
    testData.createDownlineData('U123456',2,testUsr.Id);
    testData.createActionItems();
    testData.createMarketActionItems();
    /*List<Genealogy__c> tempGeneData = [Select MRKT_ACCT_KEY__c, Personal_Sales__c,Group_Sales__c,Representative__r.MLPLN_CD__c 
                      From  Genealogy__c 
                      Where  (UPLN_GENRTN_1_ACCT_NR__c='U123456' OR    
                          UPLN_GENRTN_3_ACCT_NR__c='U123456' OR   
                          UPLN_GENRTN_2_ACCT_NR__c='U123456') 
                      and Representative__r.MLPLN_CD__c in ('M4','M3','M2','M1','M0')];
    
    System.debug('############################tempGeneData##############################');
    System.debug('tempGeneData='+tempGeneData);*/
    List<Leader_Downline_Summary__c> ldrData = testData.createLdrSmryData(testUsr.MRKT_ID_ACCT_NR_KEY__c,testUsr.Id);
    ctlr.summaryObj = ldrData[0];
    System.runAs(testUsr){
      ctlr.repAcctNbr=mktIdKey;
      ctlr.getInitialize();
      ctlr.getOrderActionItems();
      ctlr.getSalesActionItems();
      ctlr.getBusActionItems();
    }

    testData.market.Mail_Plan_Enabled__c=false;
    update testData.market;
    System.runAs(testUsr){
      ctlr.repAcctNbr=mktIdKey;
      ctlr.getInitialize();
      ctlr.getOrderActionItems();
      ctlr.getSalesActionItems();
      ctlr.getBusActionItems();
    }
    
    testUsr = testData.createZoneUser('Z123456');
    List<Sales_Org_Leadership__c> slsLdrData = testData.createSlsLdrActivity(testUsr, 'Avon Zone Manager',testUsr.Id);
    
    ctlr = new ActionItemsController();
    ctlr.summaryObj=slsLdrData[0];
    System.runAs(testUsr){
      //ctlr.repAcctNbr=mktIdKey;
      ctlr.getInitialize();
      ctlr.getOrderActionItems();
      ctlr.getSalesActionItems();
      ctlr.getBusActionItems();
    }
    
  }
  /*
  public SObject getSummaryObj(){
    return this.summaryObj;  
  }
  public void setSummaryObj(SObject obj){
    System.debug('>>>>>>>>>>>>>>>> setSummaryObj called with param:'+obj);
    this.summaryObj = obj;  
  }
  */
}
			                            	