public class DrilldownController {
  
  private static String BASE_SOQL=
                  'Select MRKT_ACCT_KEY__c,'+ 
                  '    LDRSHP_TITL_LVL_NR__c, Id,'+ 
                  '    DWNLN_GENRTN_LVL_CNT__c, ACCT_NR__c,'+
                  '    ActionItem_ORD_NOT_SUBMITTED__c,'+
                  '    UPLN_GENRTN_1_ACCT_NR__c,'+
                  '    UPLN_GENRTN_2_ACCT_NR__c,'+
                  '    UPLN_GENRTN_3_ACCT_NR__c,'+
                  '    UPLN_GENRTN_1_FULL_NM__c,'+
                  '    UPLN_GENRTN_2_FULL_NM__c,'+
                  '    UPLN_GENRTN_3_FULL_NM__c,'+
                  '    UPLN_GENRTN_1_PHON_NR__c,'+  
                  '    UPLN_GENRTN_2_PHON_NR__c,'+  
                  '    UPLN_GENRTN_3_PHON_NR__c,'+  
                  '    Representative__r.Birthday__c,'+
                  '    Representative__r.LOA_NR__c,'+
                  '    Representative__r.REP_RNSTMT_CMPGN_NR__c,'+
                  '    Personal_Sales__r.OPERTNL_CMPGN_NR__c,'+
                  '    Personal_Sales__r.BAL_DUE_AMT__c,'+
                  '    Personal_Sales__r.PAST_DUE_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_HOLD_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_UND_MIN__c,'+
                  '    Personal_Sales__r.ActionItem_ORD_DEFAULT__c,'+
                  '    Personal_Sales__r.ActionItem_AWRD_SLS_MIN__c,'+
                  '    Personal_Sales__r.ActionItem_NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.ActionItem_PAST_DUE_AMT__c,'+
                  '    Personal_Sales__r.ORD_HOLD_AMT__c,'+
                  '    Personal_Sales__c,Group_Sales__c,'+
                  '    Personal_Sales__r.AWRD_SLS_AMT__c,'+
                  '    Personal_Sales__r.NC_AWRD_SLS_AMT__c,'+
                  '    Personal_Sales__r.AVG_AWRD_SLS_AMT__c,'+    
                  '    Personal_Sales__r.ORD_SRCE_DESC_TXT__c, '+
                  '    Personal_Sales__r.MULT_ORD_CNT__c, '+
                  '    Personal_Sales__r.CUST_CNT__c, '+
                  '    Personal_Sales__r.RTURN_NET_SLS_AMT__c,'+                  
                  '    Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c,'+
                  '    Personal_Sales__r.MY_BUS_MRKT_TAG_1_AMT__c,'+
                  '    Personal_Sales__r.MY_BUS_MRKT_TAG_3_TXT__c,'+
                  '    Personal_Sales__r.MY_BUS_MRKT_TAG_4_TXT__c,'+
                  '    Personal_Sales__r.LAST_PYMT_RECVD_DT__c,'+
                  '    Personal_Sales__r.LAST_PYMT_RECVD_AMT__c,'+
                  '    Personal_Sales__r.PAST_DUE_CMPGN_CNT__c,'+
                  '    Personal_Sales__r.RTURN_AWRD_SLS_AMT__c,'+
                  '    Personal_Sales__r.Percent_of_Current_Net_Sales__c,'+
                  '    Personal_Sales__r.Percent_of_YTD_Net_Sales__c,'+
                  '    Personal_Sales__r.YTD_NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.AVG_MULT_ORD_AMT__c,'+
                  '    Personal_Sales__r.YTD_AWRD_SLS_AMT__c,'+
                  '    Personal_Sales__r.NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.NC_NET_SLS_AMT__c,'+
                  '    Personal_Sales__r.BRCHR_CNT__c,'+
                  '    Personal_Sales__r.DEMO_ITEM_ORDRD_CNT__c,'+  
                  '    Personal_Sales__r.PENDNG_ORD_CNT__c,'+                  
                  '    Personal_Sales__r.PENDNG_ORD_AMT__c,'+    
                  '    Personal_Sales__r.MLPLN_CLOSD_IND__c,'+
                  '    Personal_Sales__r.NC_PRSNL_QLFR_SLS_AMT__c,'+
                  '    Personal_Sales__r.PRSNL_QLFR_SLS_AMT__c,'+              
                  '    Representative__c,'+
                  '    Representative__r.Name,'+
                  '    Representative__r.ACCT_NR__c,'+
                  '    Representative__r.Email,'+
                  '    Representative__r.FirstName,'+
                  '    Representative__r.LastName,'+
                  '    Representative__r.LDRSHP_TITL_LVL_NBR__c,'+
                  '    Representative__r.MRKT_ACCT_KEY__c,'+
                  '    Representative__r.MRKT_TOP_SLR_LANG_KEY__c,'+
                  '    Representative__r.TERR_IND__c,'+
                  '    Representative__r.SLS_ZONE_CD__c,'+
                  '    Representative__r.Phone,'+
                  '    Representative__r.PATD_CERTFCTN_IND__c,'+
                  '    Representative__r.LDRSHP_LOA_NR__c,'+
                  '    Representative__r.CMPGN_OF_UDATE_NR__c,'+
                  '    Representative__r.LDRSHP_PRGRM_IND__c,'+
                  '    Representative__r.INACTV_CMPGN_CNT__c,'+
                  '    Representative__r.PATD_CERTFCTN_LVL_P_IND__c,'+
                  '    Representative__r.PATD_CERTFCTN_LVL_A_IND__c,'+
                  '    Representative__r.PATD_CERTFCTN_LVL_T_IND__c,'+
                  '    Representative__r.PATD_CERTFCTN_LVL_D_IND__c,'+
                  '    Representative__r.REP_APPT_CMPGN_NR__c,'+
                  '    Representative__r.REP_RMOVL_CMPGN_NR__c,'+
                  '    Representative__r.BirthDate,'+
                  '    Representative__r.REP_APPT_DT__c,'+
                  '    Representative__r.LDRSHP_TITL_PROMTD_IND__c,'+
                  '    Representative__r.LDRSHP_TAR_IND__c,'+
                  '    Representative__r.LDRSHP_CTT_IND__c,'+
                  '    Personal_sales__r.FRST_ORD_IND__c,'+
                  '    Group_Sales__r.TOTAL_TAR_CNT__c,'+
                  '    Group_Sales__r.TOTAL_CTT_CNT__c,'+
                  '    Group_Sales__r.TOTAL_PRMOTD_CNT__c,'+
                  '    Group_Sales__r.CC_TOTAL_ORD_RCVD__c,'+
                  '    Group_Sales__r.CC_GRP_APPT_CNT__c,'+
                  '    Group_Sales__r.CC_NEW_REP_1ST_ORD_CNT__c,'+
                  '    Group_Sales__r.CC_GRP_RNSTMT_CNT__c,'+
                  '    Group_Sales__r.CC_GRP_RMOVL_CNT__c,'+
                  '    Group_Sales__r.CC_GRP_INHRTD_CNT__c,'+
                  '    Group_Sales__r.TOTAL_GENRTN_1_STF_CNT__c,'+
                  '    Group_Sales__r.GENRTN_1_GRP_TITL_CHNG_CNT__c,'+
                  '    Group_Sales__r.GENRTN_1_GRP_AWRD_SLS_AMT__c,'+  
                  '    Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c,'+
                  '    Group_Sales__r.GENRTN_1_GRP_ORD_RCVD_CNT__c,'+
                  '    Group_Sales__r.TOTAL_GRP_ADDS_CNT__c,'+
                  '    Group_Sales__r.TOTAL_GRP_TITL_CHNG_CNT__c,'+
                  //'    Group_Sales__r.LDRSHP_SLS_AIDS_CNT__c,'+
                  '    Group_Sales__r.CC_GRP_AVG_CUST_CNT__c'+
                  ' From   Genealogy__c '+
                  ' Where MRKT_ID__c=:mktId ';

  
  public Map<String,String> colsToDisplay {get; private set;}
  private String reportSoql;
  private MarketTagUtils mktTags;
  public String repAcctNbr {get; set;}
  public List<String> zoneList {get; private set;}
  public Report_Config__c rptCfg {get; private set;}
  public String mktTag1Label {get; set;}
  public String mktTag3Label {get; set;}
  //Changed by Sabyasachi Maji on 09/08/2009
  public String mktTag4Label {get; set;}
  public List<DrilldownReportRow> reportRows {get; set;}
  public String currSort {get; set;}
  public String currMailPlan {get; set;}
  public String currTitle {get; set;}
  public String zoneFilter {get; set;}
  public String usrSort {get; set;}
  public boolean IsAscending {get; set;}
  public boolean pageError {get; set;}
  public Market__c market {get ; private set;}

  //public List<MailPlan_Order_Oppty__c> mailPlans {get; private set;}
  public List<String> mailPlans {get; set;}
  public Map<String,String> nextMplnsToClose {get; set;}
  public Integer nbrOfMailPlns {get; private set;}

  public Search_Criteria__c srchCrit {get; set;}
  public String userProfile {get; private set;}
  public User currUsr {get; private set;}
  public String printAcctNbrs {get; private set;}
  public Boolean printSelected {get; set;}
  public String recCnt {get; set;}
  public String sellCmpgn {get; set;}
  private MarketLeaderTitleUtils ldrTitlUtils;
  private MarketSellerStsUtils sellStsUtils;
  private static Map<String,String> filter1Crit;
  private Leader_Title__c usrTitle {get; private set;}
  public List<Leader_Title__c> ldrTitles {get; private set;}
  private Contact usrContact {get; private set;}
  public Integer startRow {get; set;}
  public Integer endRow {get; set;}
  public Integer pageNbr {get; private set;}
  public Boolean zoneSelErr {get; private set;}
  public static Integer MAX_ROWS_PER_PAGE=100;
  public static String USE_SELLING_CMPGN='1';
  static{
    filter1Crit = new Map<String,String>();
    filter1Crit.put('0',' AND (Representative__r.LDRSHP_TITL_LVL_NBR__c=\'0\')');
    filter1Crit.put('1',' AND (Representative__r.LDRSHP_TITL_LVL_NBR__c=\'1\')');
    filter1Crit.put('2',' AND (Representative__r.LDRSHP_TITL_LVL_NBR__c=\'2\')');
    filter1Crit.put('3',' AND (Representative__r.LDRSHP_TITL_LVL_NBR__c=\'3\')');
    filter1Crit.put('4',' AND (Representative__r.LDRSHP_TITL_LVL_NBR__c=\'4\')');
    filter1Crit.put('-2',' AND (Representative__r.LDRSHP_TITL_LVL_NBR__c=\'-2\')');
    filter1Crit.put('All','');
  }
  
  public PageReference init(){
    try{
    if(pageError==null){
      pageError=false;
    }
    if(this.recCnt ==null){
      this.recCnt = ApexPages.currentPage().getParameters().get('recCnt');
    }
    if(this.sellCmpgn ==null){
      this.sellCmpgn = ApexPages.currentPage().getParameters().get('sellCmpgn');
    }
    if(recCnt !=null && recCnt!=''){
      Double nbrVal = Double.valueOf(recCnt);
      this.recCnt = String.valueOf(nbrVal.intValue());  
    }
    String next3MPlans = ApexPages.currentPage().getParameters().get('mplan');
    currUsr = [Select   Name,MRKT_TAG_1_HDR_TXT__c, MRKT_ID__c, MLPLN_CD__c, USER_CNTRY_CD__c,
                LastName, LanguageLocaleKey, FirstName,MRKT_ID_ACCT_NR_KEY__c,
                DFALT_ZONE_CD__c, DFALT_DIV_NM__c,ACCT_NR__c 
          From User
          where Id = :UserInfo.getUserId()];
    this.userProfile = [select Name from Profile where Id = :UserInfo.getProfileId()].Name;

    if(userProfile == 'Avon Leader'){
      usrContact = [  select   Name,LDRSHP_TITL_LVL_NBR__c,MRKT_TOP_SLR_LANG_KEY__c,
                          MLPLN_CD__c 
                      from Contact 
                      where MRKT_ACCT_KEY__c=:currUsr.MRKT_ID_ACCT_NR_KEY__c];
      System.debug('>>>>>>>>>>>>>>>>>>>>>>>> User Contact:'+usrContact);
      
    }
    if(this.ldrTitlUtils == null){
      ldrTitlUtils = new MarketLeaderTitleUtils();
      if(userProfile == 'Avon Leader'){
        usrTitle = ldrTitlUtils.initializeAndRetTitle(currUsr,usrContact.LDRSHP_TITL_LVL_NBR__c);
      }else{
        ldrTitles = ldrTitlUtils.initializeAndRetList(currUsr);
      }
    }
    if(this.sellStsUtils ==null){
      sellStsUtils = new MarketSellerStsUtils();
      sellStsUtils.initialize(currUsr);
    }
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>> curr Usr : '+ currUsr);            
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>> userProfile : '+ userProfile);            
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>> usrTitle : '+ usrTitle);            
    if(userProfile == 'Avon Zone Manager'){
      if(this.zoneList ==null){
        this.zoneFilter = currUsr.DFALT_ZONE_CD__c;
      }
    }else if(userProfile == 'Avon Division Manager'){
      if(this.zoneList ==null){
        zoneList = new List<String>();
        if(currUsr.DFALT_ZONE_CD__c !=null){
          //zoneList.add(currUsr.DFALT_ZONE_CD__c);
          this.zoneFilter=currUsr.DFALT_ZONE_CD__c; 
        }else{
          this.zoneFilter = 'All';
        }
        for(Sales_Organization__c slsOrg :[  Select SLS_ZONE_CD__c, SLS_DIV_NM__c 
                          From Sales_Organization__c
                          where SLS_ORG_LVL_NR__c='Z'
                          and  SLS_DIV_NM__c = :currUsr.DFALT_DIV_NM__c
                          and Market__r.Market_Id__c = :currUsr.MRKT_ID__c]){
          zoneList.add(slsOrg.SLS_ZONE_CD__c);                  
        }
      }
    }

    if(this.srchCrit == null && this.userProfile=='Avon Leader'){
      this.srchCrit = new Search_Criteria__c();
      this.srchCrit.Generation_Filter__c='1st Generation';
    }

    this.market = [
                Select  SPPY_CMPGN_NR__c, PREV_1_CMPGN_NR__c, Name, Action_Item_Mail_Plans__c,
                    Market_Id__c, Mail_Plan_Enabled__c, CURRNT_CMPGN_RMN_DAY_CNT__c, 
                    CMPGN_STRT_DT__c, CMPGN_NR__c, NEXT_1_CMPGN_NR__c,CMPGN_END_DT__c,
                    LAST_UPDT_DT__c
                From   Market__c  
                where  Market_Id__c =:currUsr.MRKT_ID__c];

    if(this.mktTags ==null){
      List<String> mktTagSubjAreas = new List<String>();
      mktTagSubjAreas.add('Ldr-My Business');
      mktTags= new MarketTagUtils();
      mktTags.initialize(mktTagSubjAreas,currUsr.LanguageLocaleKey);
      this.mktTag1Label = mktTags.getLabel('Ldr-My Business', 'Market Tag 1');
      this.mktTag3Label = mktTags.getLabel('Ldr-My Business', 'Market Tag 3');
      //Changed by Sabyasachi Maji on 09/08/2009
      this.mktTag4Label = mktTags.getLabel('Ldr-My Business', 'Market Tag 4');    
    }
    
    
    //Date currDate = System.today();
    nextMplnsToClose = new Map<String,String>();
    if(this.market.Mail_Plan_Enabled__c && this.mailPlans == null){
      String mailPlansAdded='';
      this.mailPlans = new List<String>();
      Date currDt = Date.today();
      nbrOfMailPlns = Integer.valueOf(this.market.Action_Item_Mail_Plans__c+'');
      Date endDt = getMailPlanEndDt(nbrOfMailPlns);
      //Default the Filter to the next X mail plans that are closing
      System.debug('>>>>>>>>>>>>>>>>>>> Next 3 Mail Plans Start:'+currDt+',End:'+endDt);        
      for(MailPlan_Order_Oppty__c mailPlan:[  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                              MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                              CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                              CMPGN_NR__c ,MLPLN_END_DT__c
                          From   MailPlan_Order_Oppty__c  
                          where  MRKT_ID__c = :this.market.Market_Id__c
                          order by MLPLN_CD__c asc])
      {
          if(!mailPlansAdded.contains(mailPlan.MLPLN_CD__c)){
            this.mailPlans.add(mailPlan.MLPLN_CD__c);
            mailPlansAdded +=mailPlan.MLPLN_CD__c+',';
          }
          //Check if the mail plan is closing in the next 3 days
          if(  mailPlan.MLPLN_END_DT__c>currDt && 
            mailPlan.MLPLN_END_DT__c<=endDt && 
            !nextMplnsToClose.containsKey(mailPlan.MLPLN_CD__c))
          {
            nextMplnsToClose.put(mailPlan.MLPLN_CD__c,mailPlan.MLPLN_CD__c);
            
          }
      }
      System.debug('>>>>>>>>>>>>>>>>>>> Next 3 mail plans to close: '+nextMplnsToClose);        
    }
    if(this.rptCfg == null){
      String reportId = ApexPages.currentPage().getParameters().get('rptId');
      rptCfg = [  Select   Order_Criteria__c, Rep_Criteria__c,Ldr_Smry_Criteria__c, 
                Report_Type__c, Report_Id__c, Columns_To_Display__c,
                Include_Removed_Reps__c,Default_Sort__c,Default_Title_Filter__c,
                Next_N_Mail_Plans__c
            From   Report_Config__c
            where Report_Id__c=:reportId];
      if(rptCfg.Next_N_Mail_Plans__c && this.userProfile=='Avon Leader' && this.market.Mail_Plan_Enabled__c){
        this.currMailPlan = 'Closing Next';
      }  
            
      IsAscending = true;
      if(rptCfg.Default_Sort__c==null){
        this.currSort = 'Representative__r.LastName';
      }else{
        this.currSort = rptCfg.Default_Sort__c;
      }
      this.currTitle = rptCfg.Default_Title_Filter__c;
      if(this.currTitle == null && (this.userProfile=='Avon Zone Manager'|| this.userProfile=='Avon Division Manager')){
        this.srchCrit = new Search_Criteria__c(Zone_Div_Title_Filter__c='3');
        this.currTitle='3';
      }
      
      createSoqlForReport();
      initializeColumnsToDisplay();
    }
    this.repAcctNbr = ApexPages.currentPage().getParameters().get('repAcctNbr');
    if(repAcctNbr == null || repAcctNbr == ''){
      this.repAcctNbr =   this.currUsr.ACCT_NR__c;
    }    
    
    if(  this.userProfile=='Avon Division Manager' && 
      (this.zoneFilter==null || this.zoneFilter=='All'))
    {
      zoneSelErr=true;
      return null;
      if(startRow==null){
        startRow=1;
      }
      if(endRow==null){
        endRow=MAX_ROWS_PER_PAGE;  
      }
      
    }else{
      zoneSelErr=false;
    }
    
    getRecords();
        if(printSelected ==null){
            printSelected=false;
        }
    return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
  }
  
    public PageReference next(){
      try{
      pageError=false;
      startRow=endRow+1;
      endRow +=MAX_ROWS_PER_PAGE;
        getRecords();
        pageNbr++;
        return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
    }
    public PageReference previous(){
    try{
      pageError=false;
      startRow-=MAX_ROWS_PER_PAGE;
      endRow-=MAX_ROWS_PER_PAGE;
        getRecords();
        pageNbr--;
        return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
    }
  
  
  public PageReference sortReport(){
    try{
      pageError=false;
    System.debug('>>>>>>>>>>>>>>>>>>>> usrSort = '+this.usrSort+',currSort='+this.currSort);
    if(this.currSort == this.usrSort){
      IsAscending = !IsAscending;
    }else{
      IsAscending = true;
      this.currSort = this.usrSort;  
    }
    this.startRow=null;
    this.endRow=null;
    this.pageNbr=1;
    createSoqlForReport();
    getRecords();        
    printSelected=false;
    
    return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
    
  }
  public PageReference filterRecords(){
    try{
      pageError=false;
    if(  this.userProfile=='Avon Division Manager' && 
      (this.zoneFilter==null || this.zoneFilter=='All'))
    {
      zoneSelErr=true;
      return null;
      if(startRow==null){
        startRow=1;
      }
      if(endRow==null){
        endRow=MAX_ROWS_PER_PAGE;  
      }
      
    }
    zoneSelErr=false;
    System.debug('>>>>>>>>>>>>>>>>>>>> zoneFilter= '+this.zoneFilter);
    System.debug('>>>>>>>>>>>>>>>>>>>> usrMailPlan= '+this.currMailPlan+',this.srchCrit='+this.srchCrit);
    System.debug('>>>>>>>>>>>>>>>>>>>> currTitle= '+this.currTitle);
    createSoqlForReport();
    this.startRow=null;
    this.endRow=null;
    this.pageNbr=1;
    getRecords();
    printSelected=false;
    return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
    
  }
  
  
  public PageReference printSelected(){
    try{
      pageError=false;
    printAcctNbrs = getSelectedAcctNbrs(false);
    printSelected=true;
    return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
      
  }
  
  public PageReference emailSelected(){
    try{
      pageError=false;
    String acctNbrs;
    if(this.srchCrit.Generation_Filter__c =='1st Generation'){
      acctNbrs = getSelectedAcctNbrs(true); 
    }else{
      acctNbrs = getSelectedAcctNbrs(true); 
    }
    
    //System.debug('>>>>>>>>>>>>>>>>>>>>>> acctNbrs:'+acctNbrs);
    if(acctNbrs.length()>0){
      PageReference emailRep = Page.EmailReps;
      emailRep.getParameters().put('acctNbr',acctNbrs);
      String retUrl = '/apex/DrilldownReport?retPgId='+
              ApexPages.currentPage().getParameters().get('retPgId')+
              '&rptId='+this.rptCfg.Report_Id__c;
      emailRep.getParameters().put('retUrl',EncodingUtil.urlEncode(retUrl,'UTF-8'));
      emailRep.getParameters().put('rptName',EncodingUtil.urlEncode(this.rptCfg.Report_Type__c,'UTF-8'));
      emailRep.setRedirect(false);
      return emailRep;    
    }
    return null;
    }catch(Exception ex){
      pageError=true;
      return null;
    }
        
  }

  private void getRecords(){
    String critRepAcctNbr = this.repAcctNbr;
    reportRows = new List<DrilldownReportRow>();
    Boolean oddRow = true;
    if(startRow==null){
      startRow=1;
    }
    if(endRow==null){
      endRow=MAX_ROWS_PER_PAGE;  
    }
    if(pageNbr ==null){
      pageNbr=1;
    }
    String slsOrgCd = this.zoneFilter;
    String zonesToLook = this.zoneFilter;
    String mktId = this.market.Market_Id__c;
    Integer recCount=1;
    String mailPlnCd = this.currMailPlan;    
    DrilldownReportRow rptRow;
    String genNbr;
    String cmpgnNbr = this.market.CMPGN_NR__c;
    String prevCmpgnNbr = this.market.PREV_1_CMPGN_NR__c;
    String nextCmpgnNbr = String.valueOf(this.market.NEXT_1_CMPGN_NR__c);
    
    String cmpgnNbrLast2 = cmpgnNbr;
    if(cmpgnNbrLast2!=null && cmpgnNbrLast2.length()>2){
      cmpgnNbrLast2 = cmpgnNbrLast2.substring(cmpgnNbrLast2.length()-2);
    }
    if(nextCmpgnNbr!=null && nextCmpgnNbr.length()>2){
      nextCmpgnNbr = nextCmpgnNbr.substring(nextCmpgnNbr.length()-2);
    }
    List<String> mailPlnToClose = this.nextMplnsToClose.values();
    Double minToEarn = 0.0;
    if(userProfile=='Avon Leader'){
      if(this.srchCrit.Generation_Filter__c=='1st Generation'){
        minToEarn = this.usrTitle.GENRTN_1_MIN_ORD_AMT__c;
      }else if(this.srchCrit.Generation_Filter__c=='2nd Generation'){
        minToEarn = this.usrTitle.GENRTN_2_MIN_ORD_AMT__c;
      }else if(this.srchCrit.Generation_Filter__c=='3rd Generation'){
        minToEarn = this.usrTitle.GENRTN_3_MIN_ORD_AMT__c;
      }  
    }
    
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>nextMplnsToClose='+nextMplnsToClose);
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>minToEarn='+minToEarn);
    // Changed by Snehashis Ghosh  on 08/28/09
    System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>getReords SOQL='+this.reportSoql);
    for(Genealogy__c downline: Database.query(this.reportSoql)){
      //System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>ROW='+downline);
          //System.debug('>>>>>>>>>>>>>>>> startRow:'+startRow+',endRow:'+endRow+',recCount='+recCount);
      rptRow = new DrilldownReportRow(critRepAcctNbr,downline,oddRow);
      rptRow.title = ldrTitlUtils.getLeaderTitle(downline.Representative__r.LDRSHP_TITL_LVL_NBR__c);
      rptRow.sellerSts = sellStsUtils.getSellerStatus(downline.Representative__r.MRKT_TOP_SLR_LANG_KEY__c);
      if(userProfile == 'Avon Leader'){
        genNbr = rptRow.getDownlineGenNbr();
        if(rptRow.row.Personal_Sales__r !=null){
          rptRow.row.Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c=minToEarn;
        }
      }
      if(rptRow.row.Personal_Sales__r.MLPLN_CLOSD_IND__c=='Y' && rptRow.row.Personal_Sales__r!=null){
        rptRow.row.Personal_Sales__r.OPERTNL_CMPGN_NR__c=nextCmpgnNbr;
      }else if(rptRow.row.Personal_Sales__r!=null){
        rptRow.row.Personal_Sales__r.OPERTNL_CMPGN_NR__c=cmpgnNbrLast2;
      }
      if(recCount<startRow){
        recCount++;
        continue;
      }else{
        this.reportRows.add(rptRow);
        oddRow = !oddRow;
        recCount++;
      }
      
            if(recCount == (endRow+1)){
              System.debug('>>>>>>>>>>>>>>>>> Total rows per page reached.Breaking out now....');
              break;
          }
      
    }
    
  }
  private String getSelectedAcctNbrs(Boolean returnUplines){
    String tempStr = '';
    Map<String,String> acctNbrs = new Map<String,String>();
    String repAcctNbr,tempVal;
    //Group them by the correct upline
    System.debug('>>>>>>>>>>>>>> getSelectedAcctNbrs:reportRows='+reportRows);
    for(DrilldownReportRow rptRow: this.reportRows){
      
      if(rptRow.selected){
        tempStr+=rptRow.row.Representative__r.MRKT_ACCT_KEY__c+',';
      }
    }
    /*if(returnUplines){
      tempStr='';
      for(String key: acctNbrs.keySet()){
        tempStr+= key+':'+acctNbrs.get(key)+',';  
      }
    }*/
    return tempStr;
  }  
  private void createSoqlForReport(){
    reportSoql = BASE_SOQL;
    System.debug('>>>>>>>>>>>>>>>> USER PROFILE:'+this.userProfile);
    if(!this.rptCfg.Include_Removed_Reps__c){
      reportSoql+=' and Representative__r.REP_OMS_STUS_CD__c=\'1\' ';
    }
    if(rptCfg.Order_Criteria__c != null && rptCfg.Order_Criteria__c != ''){
      reportSoql+=' and '+rptCfg.Order_Criteria__c;
    }
    if(rptCfg.Rep_Criteria__c != null && rptCfg.Rep_Criteria__c != ''){
      reportSoql+=' and '+rptCfg.Rep_Criteria__c;
    }
    if(rptCfg.Ldr_Smry_Criteria__c != null && rptCfg.Ldr_Smry_Criteria__c != ''){
      reportSoql+=' and '+rptCfg.Ldr_Smry_Criteria__c;
    }
    
    if(this.userProfile == 'Avon Leader')
    {
      /*if(this.srchCrit.Generation_Filter__c == null){
        this.srchCrit.Generation_Filter__c = '1st Generation';
      }*/
      if(this.srchCrit.Generation_Filter__c == '1st Generation'){
        reportSoql+=' and (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr) ';
      }
      else if(this.srchCrit.Generation_Filter__c == '2nd Generation'){
        reportSoql+=' and (UPLN_GENRTN_2_ACCT_NR__c=:critRepAcctNbr) ';
      }
      else{
        reportSoql+=' and (UPLN_GENRTN_3_ACCT_NR__c=:critRepAcctNbr) ';
      }
      /*else{
        reportSoql+=' and (UPLN_GENRTN_1_ACCT_NR__c=:critRepAcctNbr OR '+
              '      UPLN_GENRTN_2_ACCT_NR__c=:critRepAcctNbr OR '+
              '     UPLN_GENRTN_3_ACCT_NR__c=:critRepAcctNbr) ';
        
      }*/
    }
    if(this.userProfile == 'Avon Zone Manager' || this.userProfile == 'Avon Division Manager')
    {
        
      reportSoql +=' and Representative__r.SLS_ZONE_CD__c =:zonesToLook';
      reportSoql+=filter1Crit.get(this.currTitle);
    }
    if(this.market.Mail_Plan_Enabled__c){
      if(this.currMailPlan == 'Closing Next'){
        reportSoql+=' and Representative__r.MLPLN_CD__c in :mailPlnToClose';
      }else if(this.currMailPlan !=null && this.currMailPlan!='-None-' && this.currMailPlan!=''){
        reportSoql+=' and Representative__r.MLPLN_CD__c=:mailPlnCd';
      }
    }
    if(this.currSort !=null && this.currSort !='' ){
      reportSoql +=' order by '+currSort;
      if(IsAscending){
        reportSoql += ' asc';
      }else{
        reportSoql += ' desc';
      }  
    }
    System.debug('>>>>>>>>>>>>>>>>>>> SOQL :'+this.reportSoql);
    
  }
  /*
  private String isOrderBelowMin(DrilldownReportRow rptRow){
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.MRKT_ACCT_KEY='+rptRow.row.MRKT_ACCT_KEY__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.NET_SLS_AMT__c='+rptRow.row.Personal_Sales__r.NET_SLS_AMT__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.AWRD_SLS_AMT__c='+rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.NC_AWRD_SLS_AMT__c='+rptRow.row.Personal_Sales__r.NC_AWRD_SLS_AMT__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.minToEarn='+rptRow.minToEarn);
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
  private String isOrderBelowMinMailPlan(DrilldownReportRow rptRow){
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.MRKT_ACCT_KEY='+rptRow.row.MRKT_ACCT_KEY__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.NET_SLS_AMT__c='+rptRow.row.Personal_Sales__r.NET_SLS_AMT__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.AWRD_SLS_AMT__c='+rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.Personal_Sales__e.NC_AWRD_SLS_AMT__c='+rptRow.row.Personal_Sales__r.NC_AWRD_SLS_AMT__c);
    System.debug('>>>>>>>>>>>> isOrderBelowMin: rptRow.minToEarn='+rptRow.minToEarn);
    if(rptRow.row.Personal_Sales__c ==null){
      //System.debug('>>>>>>>>>>>> isOrderBelowMin: Condition 1');
      return '-na-';  
    }else if(rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c ==null){
      return '-na-';
    }else{
      Double netSales = (rptRow.row.Personal_Sales__r.MLPLN_CLOSD_IND__c=='Y'?rptRow.row.Personal_Sales__r.NC_NET_SLS_AMT__c:rptRow.row.Personal_Sales__r.NET_SLS_AMT__c);
      Double awardSales= (rptRow.row.Personal_Sales__r.MLPLN_CLOSD_IND__c=='Y'?rptRow.row.Personal_Sales__r.NC_AWRD_SLS_AMT__c:rptRow.row.Personal_Sales__r.AWRD_SLS_AMT__c);
      
      if(netSales>0 && awardSales>=0 && awardSales < rptRow.minToEarn){
        //System.debug('>>>>>>>>>>>> isOrderBelowMin: Condition 3');
        return 'Y';
      }else if(netSales>0 && awardSales>=0 && awardSales >= rptRow.minToEarn)
      {
        //System.debug('>>>>>>>>>>>> isOrderBelowMin: Condition 4');
        return 'N';
      
      }else{
        return '-na-';  
      }
    }
  }
  */

  private void initializeColumnsToDisplay(){
    colsToDisplay = new Map<String,String>();
    for(String colApiName: this.rptCfg.Columns_To_Display__c.split('\n')){
      colsToDisplay.put(colApiName.trim(),colApiName.trim());
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
  
  public Boolean getIsLOA_NREnabled(){ return IsColEnabled('Representative__r.LOA_NR__c'); } 
  public Boolean getIsREP_RNSTMT_CMPGN_NREnabled(){ return IsColEnabled('Representative__r.REP_RNSTMT_CMPGN_NR__c'); } 
  public Boolean getIsBAL_DUE_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.BAL_DUE_AMT__c'); } 
  public Boolean getIsPAST_DUE_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.PAST_DUE_AMT__c'); } 
  public Boolean getIsMRKT_TOP_SLR_LANG_KEYEnabled(){ return IsColEnabled('Representative__r.MRKT_TOP_SLR_LANG_KEY__c'); } 
  public Boolean getIsORD_SRCE_DESC_TXTEnabled(){ return IsColEnabled('Personal_Sales__r.ORD_SRCE_DESC_TXT__c'); } 
  public Boolean getIsAWRD_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.AWRD_SLS_AMT__c'); } 
  public Boolean getIsMIN_PRSNL_SLS_REQD_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c'); } 
  public Boolean getIsMULT_ORD_CNTEnabled(){ return IsColEnabled('Personal_Sales__r.MULT_ORD_CNT__c'); } 
  public Boolean getIsCUST_CNTEnabled(){ return IsColEnabled('Personal_Sales__r.CUST_CNT__c'); } 
  public Boolean getIsRTURN_NET_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.RTURN_NET_SLS_AMT__c'); } 
  public Boolean getIsTERR_INDEnabled(){ return IsColEnabled('Representative__r.TERR_IND__c'); } 
  public Boolean getIsORD_HOLD_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.ORD_HOLD_AMT__c'); } 
  public Boolean getIsSLS_ZONE_CDEnabled(){ return IsColEnabled('Representative__r.SLS_ZONE_CD__c'); } 
  public Boolean getIsMY_BUS_MRKT_TAG_1_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.MY_BUS_MRKT_TAG_1_AMT__c'); } 
  public Boolean getIsMY_BUS_MRKT_TAG_3_TXTEnabled(){ return IsColEnabled('Personal_Sales__r.MY_BUS_MRKT_TAG_3_TXT__c'); }
  //Changed by Sabyasachi Maji on 09/08/2009
  public Boolean getIsMY_BUS_MRKT_TAG_4_TXTEnabled(){ return IsColEnabled('Personal_Sales__r.MY_BUS_MRKT_TAG_4_TXT__c'); } 
  public Boolean getIsLAST_PYMT_RECVD_DTEnabled(){ return IsColEnabled('Personal_Sales__r.LAST_PYMT_RECVD_DT__c'); } 
  public Boolean getIsLAST_PYMT_RECVD_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.LAST_PYMT_RECVD_AMT__c'); } 
  public Boolean getIsPAST_DUE_CMPGN_CNTEnabled(){ return IsColEnabled('Personal_Sales__r.PAST_DUE_CMPGN_CNT__c'); } 
  public Boolean getIsRTURN_AWRD_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.RTURN_AWRD_SLS_AMT__c'); } 
  public Boolean getIsPercent_of_Current_Net_SalesEnabled(){ return IsColEnabled('Personal_Sales__r.Percent_of_Current_Net_Sales__c'); } 
  public Boolean getIsPercent_of_YTD_Net_SalesEnabled(){ return IsColEnabled('Personal_Sales__r.Percent_of_YTD_Net_Sales__c'); } 
  public Boolean getIsCC_TOTAL_ORD_RCVDEnabled(){ return IsColEnabled('Group_Sales__r.CC_TOTAL_ORD_RCVD__c'); } 

  public Boolean getIsLDRSHP_TITL_LVL_NREnabled(){ return IsColEnabled('Representative__r.LDRSHP_TITL_LVL_NR__c'); } 
  public Boolean getIsTOTAL_TAR_CNTEnabled(){ return IsColEnabled('Group_Sales__r.TOTAL_TAR_CNT__c'); } 
  public Boolean getIsCMPGN_OF_UDATE_NREnabled(){ return IsColEnabled('Representative__r.CMPGN_OF_UDATE_NR__c'); } 
  public Boolean getIsTOTAL_CTT_CNTEnabled(){ return IsColEnabled('Group_Sales__r.TOTAL_CTT_CNT__c'); } 
  public Boolean getIsTOTAL_PRMOTD_CNTEnabled(){ return IsColEnabled('Group_Sales__r.TOTAL_PRMOTD_CNT__c'); } 
  public Boolean getIsCC_GRP_APPT_CNTEnabled(){ return IsColEnabled('Group_Sales__r.CC_GRP_APPT_CNT__c'); } 
  public Boolean getIsCC_NEW_REP_1ST_ORD_CNTEnabled(){ return IsColEnabled('Group_Sales__r.CC_NEW_REP_1ST_ORD_CNT__c'); } 
  public Boolean getIsCC_GRP_RNSTMT_CNTEnabled(){ return IsColEnabled('Group_Sales__r.CC_GRP_RNSTMT_CNT__c'); } 
  public Boolean getIsCC_GRP_RMOVL_CNTEnabled(){ return IsColEnabled('Group_Sales__r.CC_GRP_RMOVL_CNT__c'); } 
  public Boolean getIsCC_GRP_INHRTD_CNTEnabled(){ return IsColEnabled('Group_Sales__r.CC_GRP_INHRTD_CNT__c'); } 
  public Boolean getIsTOTAL_GENRTN_1_STF_CNTEnabled(){ return IsColEnabled('Group_Sales__r.TOTAL_GENRTN_1_STF_CNT__c'); } 
  public Boolean getIsGENRTN_1_GRP_TITL_CHNG_CNTEnabled(){ return IsColEnabled('Group_Sales__r.GENRTN_1_GRP_TITL_CHNG_CNT__c'); } 
  public Boolean getIsAVG_AWRD_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.AVG_AWRD_SLS_AMT__c'); } 
  public Boolean getIsCC_GRP_AVG_CUST_CNTEnabled(){ return IsColEnabled('Group_Sales__r.CC_GRP_AVG_CUST_CNT__c'); } 
  public Boolean getIsLDRSHP_PRGRM_INDEnabled(){ return IsColEnabled('Representative__r.LDRSHP_PRGRM_IND__c'); } 
  public Boolean getIsINACTV_CMPGN_CNTEnabled(){ return IsColEnabled('Representative__r.INACTV_CMPGN_CNT__c'); } 

  public Boolean getIsCC_GRP_AWRD_SLS_AMTEnabled(){ return IsColEnabled('Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c'); } 
  public Boolean getIsGENRTN_1_GRP_ORD_RCVD_CNTEnabled(){ return IsColEnabled('Group_Sales__r.GENRTN_1_GRP_ORD_RCVD_CNT__c'); } 
  public Boolean getIsTOTAL_GRP_ADDS_CNTEnabled(){ return IsColEnabled('Group_Sales__r.TOTAL_GRP_ADDS_CNT__c'); } 
  public Boolean getIsPATD_CERTFCTN_INDEnabled(){ return IsColEnabled('Representative__r.PATD_CERTFCTN_IND__c'); } 
  public Boolean getIsLDRSHP_LOA_NREnabled(){ return IsColEnabled('Representative__r.LDRSHP_LOA_NR__c'); } 

  public Boolean getIsPATD_CERTFCTN_LVL_P_INDEnabled(){ return IsColEnabled('Representative__r.PATD_CERTFCTN_LVL_P_IND__c'); } 
  public Boolean getIsPATD_CERTFCTN_LVL_A_INDEnabled(){ return IsColEnabled('Representative__r.PATD_CERTFCTN_LVL_A_IND__c'); } 
  public Boolean getIsPATD_CERTFCTN_LVL_T_INDEnabled(){ return IsColEnabled('Representative__r.PATD_CERTFCTN_LVL_T_IND__c'); } 
  public Boolean getIsPATD_CERTFCTN_LVL_D_INDEnabled(){ return IsColEnabled('Representative__r.PATD_CERTFCTN_LVL_D_IND__c'); } 
  public Boolean getIsYTD_NET_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.YTD_NET_SLS_AMT__c'); } 
  public Boolean getIsAVG_MULT_ORD_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.AVG_MULT_ORD_AMT__c'); } 
  public Boolean getIsYTD_AWRD_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.YTD_AWRD_SLS_AMT__c'); } 
  public Boolean getIsREP_BRTH_DTEnabled(){return IsColEnabled('Representative__r.Birthdate'); } 
  public Boolean getIsREP_APPT_DTEnabled(){ return IsColEnabled('Representative__r.REP_APPT_DT__c'); } 
  public Boolean getIsNET_SLS_AMTEnabled(){ return IsColEnabled('Personal_Sales__r.NET_SLS_AMT__c'); }
  public Boolean getIsOPERTNL_CMPGN_NREnabled(){ return IsColEnabled('Personal_Sales__r.OPERTNL_CMPGN_NR__c'); }
  public Boolean getIsBRCHR_CNTEnabled(){ return IsColEnabled('Personal_Sales__r.BRCHR_CNT__c'); }
  public Boolean getIsDEMO_ITEM_ORDRD_CNTEnabled() { return IsColEnabled('Personal_Sales__r.DEMO_ITEM_ORDRD_CNT__c');}
  public Boolean getIsMIN_TO_EARN_AMTEnabled() { return IsColEnabled('Runtime.MIN_TO_EARN_AMT__c');}
  public Boolean getIsBirthdayEnabled() { return IsColEnabled('Representative__r.Birthday__c');}
  public Boolean getIsTOTAL_GRP_TITL_CHNG_CNTEnabled() {return IsColEnabled('Group_Sales__r.TOTAL_GRP_TITL_CHNG_CNT__c');}
  public Boolean getIsPENDNG_ORD_CNTEnabled() {return IsColEnabled('Personal_Sales__r.PENDNG_ORD_CNT__c');}
  public Boolean getIsPENDNG_ORD_AMTEnabled() {return IsColEnabled('Personal_Sales__r.PENDNG_ORD_AMT__c');}
  public Boolean getIsLDRSHP_SLS_AIDS_CNTEnabled() {return IsColEnabled('Group_Sales__r.LDRSHP_SLS_AIDS_CNT__c');}
  public Boolean getIsREP_APPT_CMPGN_NREnabled() {return IsColEnabled('Representative__r.REP_APPT_CMPGN_NR__c');}
  public Boolean getIsREP_RMOVL_CMPGN_NREnabled() {return IsColEnabled('Representative__r.REP_RMOVL_CMPGN_NR__c');}
  public Boolean getIsLDRSHP_TITL_PROMTD_INDEnabled() {return IsColEnabled('Representative__r.LDRSHP_TITL_PROMTD_IND__c');}
  public Boolean getIsLDRSHP_TAR_INDEnabled() {return IsColEnabled('Representative__r.LDRSHP_TAR_IND__c');}
  public Boolean getIsLDRSHP_CTT_INDEnabled() {return IsColEnabled('Representative__r.LDRSHP_CTT_IND__c');}
  //changed by Snehashis Ghosh on 09 Sep 2009
  public Boolean getIsFIRST_ORD_INDEnabled() {return IsColEnabled('Personal_sales__r.FRST_ORD_IND__c');}
  public Boolean getIsNC_PRSNL_QLFR_SLS_AMTEnabled() {return IsColEnabled('Personal_Sales__r.NC_PRSNL_QLFR_SLS_AMT__c');}
  public Boolean getIsPRSNL_QLFR_SLS_AMTEnabled() {return IsColEnabled('Personal_sales__r.PRSNL_QLFR_SLS_AMT__c');}

  private Boolean IsColEnabled(String apiName){
    try{
      if(this.colsToDisplay!=null){
        return this.colsToDisplay.containsKey(apiName);
      }
      return false;
    }catch(Exception ex){
      pageError=true;
      return false;
    }
  }
  
  public Integer getColCount(){
    return this.colsToDisplay.size();  
  }
  
  public List<String> getDisplayColumns(){
    List<String> retList = new List<String>();
    for(String colName: this.rptCfg.Columns_To_Display__c.split('\n')){
      retList.add(colName.trim());  
    }
    return retList;
  }

  public static testmethod void testDrilldown(){
    DrilldownController ctlr = new DrilldownController();
    TestDataHelper testData = new TestDataHelper();
    String repAcctId = '12345';
    User testUsr = testData.createLeaderUser(repAcctId);
    testData.createMailPlans();
    testData.market.Mail_Plan_Enabled__c = true;
    update testData.market;
    List<Report_Config__c> rptCfg = testData.createReportConfig();
    List<Genealogy__c> geneData = testData.createDownlineData(repAcctId,5,testUsr.Id);
    List<Genealogy__c> geneData1 = testData.create2ndGenDownlineData(repAcctId,'123450', 2);
    PageReference pageRef = Page.DrilldownReport;
    pageRef.getParameters().put('rptId',rptCfg[0].Report_Id__c);
    Test.setCurrentPageReference(pageRef);
    PageReference tempPageRef;
    System.runAs(testUsr){
      ctlr.init();
      System.assert(ctlr.getDisplayColumns().size()==2);
      System.assert(ctlr.getIsLOA_NREnabled()==true);
      System.assert(ctlr.getIsREP_RNSTMT_CMPGN_NREnabled()==false);
      System.assert(ctlr.getIsBAL_DUE_AMTEnabled()==true);
      System.assert(ctlr.getIsPAST_DUE_AMTEnabled()==false);
      System.assert(ctlr.getIsMRKT_TOP_SLR_LANG_KEYEnabled()==false);
      System.assert(ctlr.getIsORD_SRCE_DESC_TXTEnabled()==false);
      System.assert(ctlr.getIsAWRD_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsMIN_PRSNL_SLS_REQD_AMTEnabled()==false);
      System.assert(ctlr.getIsMULT_ORD_CNTEnabled()==false);
      System.assert(ctlr.getIsCUST_CNTEnabled()==false);
      System.assert(ctlr.getIsRTURN_NET_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsTERR_INDEnabled()==false);
      System.assert(ctlr.getIsORD_HOLD_AMTEnabled()==false);
      System.assert(ctlr.getIsSLS_ZONE_CDEnabled()==false);
      System.assert(ctlr.getIsMY_BUS_MRKT_TAG_1_AMTEnabled()==false);
      System.assert(ctlr.getIsMY_BUS_MRKT_TAG_3_TXTEnabled()==false);
      System.assert(ctlr.getIsLAST_PYMT_RECVD_DTEnabled()==false);
      System.assert(ctlr.getIsLAST_PYMT_RECVD_AMTEnabled()==false);
      System.assert(ctlr.getIsPAST_DUE_CMPGN_CNTEnabled()==false);
      System.assert(ctlr.getIsRTURN_AWRD_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsPercent_of_Current_Net_SalesEnabled()==false);
      System.assert(ctlr.getIsPercent_of_YTD_Net_SalesEnabled()==false);
      System.assert(ctlr.getIsCC_TOTAL_ORD_RCVDEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_TITL_LVL_NREnabled()==false);
      System.assert(ctlr.getIsTOTAL_TAR_CNTEnabled()==false);
      System.assert(ctlr.getIsCMPGN_OF_UDATE_NREnabled()==false);
      System.assert(ctlr.getIsTOTAL_CTT_CNTEnabled()==false);
      System.assert(ctlr.getIsTOTAL_PRMOTD_CNTEnabled()==false);
      System.assert(ctlr.getIsCC_GRP_APPT_CNTEnabled()==false);
      System.assert(ctlr.getIsCC_NEW_REP_1ST_ORD_CNTEnabled()==false);
      System.assert(ctlr.getIsCC_GRP_RNSTMT_CNTEnabled()==false);
      System.assert(ctlr.getIsCC_GRP_RMOVL_CNTEnabled()==false);
      System.assert(ctlr.getIsCC_GRP_INHRTD_CNTEnabled()==false);
      System.assert(ctlr.getIsTOTAL_GENRTN_1_STF_CNTEnabled()==false);
      System.assert(ctlr.getIsGENRTN_1_GRP_TITL_CHNG_CNTEnabled()==false);
      System.assert(ctlr.getIsAVG_AWRD_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsCC_GRP_AVG_CUST_CNTEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_PRGRM_INDEnabled()==false);
      System.assert(ctlr.getIsINACTV_CMPGN_CNTEnabled()==false);
      System.assert(ctlr.getIsCC_GRP_AWRD_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsGENRTN_1_GRP_ORD_RCVD_CNTEnabled()==false);
      System.assert(ctlr.getIsTOTAL_GRP_ADDS_CNTEnabled()==false);
      System.assert(ctlr.getIsPATD_CERTFCTN_INDEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_LOA_NREnabled()==false);
      System.assert(ctlr.getIsPATD_CERTFCTN_LVL_P_INDEnabled()==false);
      System.assert(ctlr.getIsPATD_CERTFCTN_LVL_A_INDEnabled()==false);
      System.assert(ctlr.getIsPATD_CERTFCTN_LVL_T_INDEnabled()==false);
      System.assert(ctlr.getIsPATD_CERTFCTN_LVL_D_INDEnabled()==false);
      System.assert(ctlr.getIsYTD_NET_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsAVG_MULT_ORD_AMTEnabled()==false);
      System.assert(ctlr.getIsYTD_AWRD_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsREP_BRTH_DTEnabled()==false);
      System.assert(ctlr.getIsNET_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsOPERTNL_CMPGN_NREnabled()==false);
      System.assert(ctlr.getIsCUST_CNTEnabled()==false);
      System.assert(ctlr.getIsBRCHR_CNTEnabled()==false);
      System.assert(ctlr.getIsDEMO_ITEM_ORDRD_CNTEnabled()==false);
      System.assert(ctlr.getIsMIN_TO_EARN_AMTEnabled()==false);
      System.assert(ctlr.getIsBirthdayEnabled()==false);
      System.assert(ctlr.getIsPENDNG_ORD_CNTEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_SLS_AIDS_CNTEnabled()==false);
      System.assert(ctlr.getIsPENDNG_ORD_AMTEnabled()==false);
      System.assert(ctlr.getIsREP_APPT_CMPGN_NREnabled()==false);
      System.assert(ctlr.getIsREP_RMOVL_CMPGN_NREnabled()==false); 
      System.assert(ctlr.getIsREP_RNSTMT_CMPGN_NREnabled()==false);
      System.assert(ctlr.getIsTOTAL_GRP_TITL_CHNG_CNTEnabled()==false);
      System.assert(ctlr.getIsREP_APPT_DTEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_TITL_PROMTD_INDEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_TAR_INDEnabled()==false);
      System.assert(ctlr.getIsLDRSHP_CTT_INDEnabled()==false);
      System.assert(ctlr.getIsNC_PRSNL_QLFR_SLS_AMTEnabled()==false);
      System.assert(ctlr.getIsPRSNL_QLFR_SLS_AMTEnabled()==false);
            ctlr.getColCount()   ;
      
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows);
      //ctlr.reportRows[0].selected=true;
      tempPageRef =ctlr.printSelected();
      //System.debug('>>>>>>>>>>>>>>>> print Url:'+tempPageRef.getUrl());
      tempPageRef =ctlr.emailSelected();
      //System.debug('>>>>>>>>>>>>>>>> email Url:'+tempPageRef.getUrl());
      ctlr.usrSort='Representative__r.LastName';
      ctlr.sortReport();
      System.assert(!ctlr.IsAscending);  
      ctlr.sortReport();
      System.assert(ctlr.IsAscending);  
      
      ctlr.currMailPlan='M0';
      ctlr.srchCrit.Generation_Filter__c='2nd Generation';
      ctlr.filterRecords();  
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
      //ctlr.reportRows[0].selected=true;
      //tempPageRef =ctlr.emailSelected();
      //System.debug('>>>>>>>>>>>>>>>> email Url:'+tempPageRef.getUrl());
      ctlr.srchCrit.Generation_Filter__c='3rd Generation';
      ctlr.filterRecords();
      
      System.debug('>>>>>>>>>>>>>>>>>>> ORDERS REPORT TESTS >>>>>>>>>>>>>>>>>');
      pageRef.getParameters().put('rptId',rptCfg[3].Report_Id__c);
      Test.setCurrentPageReference(pageRef);
      ctlr = new DrilldownController();
      ctlr.init();
      ctlr.next();
      ctlr.previous();  
      ctlr.srchCrit.Generation_Filter__c='2nd Generation';
      ctlr.filterRecords();  
    }

    ctlr = new DrilldownController();
    pageRef = Page.DrilldownReport;
    pageRef.getParameters().put('rptId',rptCfg[1].Report_Id__c);
    Test.setCurrentPageReference(pageRef);
    System.runAs(testUsr){
      ctlr.init();
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
    }    

    pageRef = Page.DrilldownReport;
    pageRef.getParameters().put('rptId',rptCfg[2].Report_Id__c);
    pageRef.getParameters().put('recCnt','2.0');
    Test.setCurrentPageReference(pageRef);
    System.runAs(testUsr){
      ctlr.init();
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
    }    

    System.debug('>>>>>>>>>>>>>>>>>>>>>> ZONE USER');
    testUsr = testData.createZoneUser('Z'+repAcctId);
    pageRef = Page.DrilldownReport;
    pageRef.getParameters().put('rptId',rptCfg[3].Report_Id__c);
    Test.setCurrentPageReference(pageRef);
    ctlr = new DrilldownController();
    System.runAs(testUsr){
      ctlr.init();
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
      /*ctlr.reportRows[0].selected=true;
      tempPageRef =ctlr.printSelected();
      System.debug('>>>>>>>>>>>>>>>> print Url:'+tempPageRef.getUrl());
      tempPageRef =ctlr.emailSelected();
      System.debug('>>>>>>>>>>>>>>>> email Url:'+tempPageRef.getUrl());
      ctlr.usrSort='Representative__r.LastName';
      ctlr.sortReport();
      System.assert(ctlr.IsAscending);  
      ctlr.sortReport();  
      System.assert(!ctlr.IsAscending);
      ctlr.currMailPlan='M0';
      ctlr.srchCrit.Generation_Filter__c='2nd Generation';
      ctlr.filterRecords();  
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
      */
    }

    System.debug('>>>>>>>>>>>>>>>>>>>>>> DIVISION USER');
    testUsr = testData.createDivUser('D'+repAcctId);
    ctlr = new DrilldownController();
    System.runAs(testUsr){
      ctlr.init();
      System.assert(ctlr.zoneSelErr==true);
      System.assert(ctlr.reportRows ==null);
      ctlr.filterRecords();
      ctlr.zoneFilter='XZ1';
      ctlr.filterRecords();
      System.assert(ctlr.zoneSelErr==false);
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
      /*
      ctlr.reportRows[0].selected=true;
      tempPageRef =ctlr.printSelected();
      System.debug('>>>>>>>>>>>>>>>> print Url:'+tempPageRef.getUrl());
      tempPageRef =ctlr.emailSelected();
      System.debug('>>>>>>>>>>>>>>>> email Url:'+tempPageRef.getUrl());
      ctlr.usrSort='Representative__r.LastName';
      ctlr.sortReport();
      System.assert(ctlr.IsAscending);  
      ctlr.sortReport();  
      System.assert(!ctlr.IsAscending);
      ctlr.currMailPlan='M0';
      ctlr.srchCrit.Generation_Filter__c='2nd Generation';
      ctlr.filterRecords();  
      System.debug('>>>>>>>>>>>>>> Downline rows:'+ctlr.reportRows.size());
      */
    }

  }
}
			                            	