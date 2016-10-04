public class SiteHeaderController {
  public User currUsr {get; set;}
  public Contact currUsrContact {get; set;}
  public String ldrTitle {get; private set;}
  public String sellerStatus {get; private set;}
  public String mktTagLabel {get; private set;}
  public Market__c market {get; private set;}
  public MailPlan_Order_Oppty__c mailPlan {get; private set;}
  public String userProfile {get; private set;}
  public Sales_Organization__c usrSlsOrg {get; private set;}
  public String mailPlansToClose {get; set;} 
  public ALM_Global_Settings__c globalConfig {get; private set;}
  
  public PageReference init(){
    this.globalConfig = ALM_Global_Settings__c.getValues('ALM Default');
    this.currUsr = [Select   Username,First_Name__c,Last_Name__c,Name,MRKT_TAG_1_HDR_TXT__c, MRKT_ID__c,  USER_CNTRY_CD__c,
                LastName, LanguageLocaleKey, FirstName,MRKT_ID_ACCT_NR_KEY__c,
                DFALT_ZONE_CD__c, DFALT_DIV_NM__c 
            From User
            where Id = :UserInfo.getUserId()];
    this.userProfile = [select Name from Profile where Id = :UserInfo.getProfileId()].Name;
    //System.debug('>>>>>>>>>>>>>>>>>>>>>>>> curr Usr : '+ this.currUsr);            
    this.market = [
                Select  SPPY_CMPGN_NR__c, PREV_1_CMPGN_NR__c, Name, 
                    Market_Id__c, Mail_Plan_Enabled__c, CURRNT_CMPGN_RMN_DAY_CNT__c, 
                    CMPGN_STRT_DT__c, CMPGN_NR__c, CMPGN_END_DT__c,
                    LAST_UPDT_DT__c,GI3_Keep_Alive_URL__c,CURRENT_CAMPAIGN_NR__c,
                    Action_Item_Mail_Plans__c
                From   Market__c  
                where  Market_Id__c =:currUsr.MRKT_ID__c];
    List<Contact> contactList = [  select   Name,LDRSHP_TITL_LVL_NBR__c,MRKT_TOP_SLR_LANG_KEY__c,
                        MLPLN_CD__c,SLS_ZONE_CD__c
                    from Contact 
                    where MRKT_ACCT_KEY__c=:currUsr.MRKT_ID_ACCT_NR_KEY__c];
    List<String> mktTagSubjAreas = new List<String>();
    mktTagSubjAreas.add('User');
    MarketTagUtils mktTags = new MarketTagUtils();
    mktTags.initialize(mktTagSubjAreas,currUsr.LanguageLocaleKey);
    this.mktTagLabel = mktTags.getLabel('User','Market Tag 1');
    List<MailPlan_Order_Oppty__c> mailPlanData;
    System.debug('>>>>>>>>>>>>>>>>>>contactList='+contactList);
    System.debug('>>>>>>>>>>>>>>>>>>userProfile='+this.userProfile);
    System.debug('>>>>>>>>>>>>>>>>>>market.Id='+this.market.Id);
    System.debug('>>>>>>>>>>>>>>>>>>market.Market_Id='+this.market.Market_Id__c);
    System.debug('>>>>>>>>>>>>>>>>>>market.Mail_Plan_Enabled='+this.market.Mail_Plan_Enabled__c);
    if(this.userProfile=='Avon Leader'){
      this.currUsrContact = contactList[0];  
      MarketLeaderTitleUtils ldrTitlUtils = new MarketLeaderTitleUtils();
      ldrTitlUtils.initialize(currUsr,currUsrContact.LDRSHP_TITL_LVL_NBR__c);
      this.ldrTitle = ldrTitlUtils.getLeaderTitle(currUsrContact.LDRSHP_TITL_LVL_NBR__c);
      MarketSellerStsUtils sellStsUtils = new MarketSellerStsUtils();
      sellStsUtils.initialize(currUsr,currUsrContact.MRKT_TOP_SLR_LANG_KEY__c);
      this.sellerStatus = sellStsUtils.getSellerStatus(currUsrContact.MRKT_TOP_SLR_LANG_KEY__c);
      if(this.market.Mail_Plan_Enabled__c){
        mailPlanData = 
            [  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                  MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                  CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                  CMPGN_NR__c ,MLPLN_END_DT__c
              From   MailPlan_Order_Oppty__c  
              where  MLPLN_CD__c = :this.currUsrContact.MLPLN_CD__c
              and   SLS_ZONE_CD__c=:this.currUsrContact.SLS_ZONE_CD__c
              and    Market__c = :this.market.Id
              order by MLPLN_END_DT__c asc];  
        if(mailPlanData[0].MLPLN_END_DT__c>System.today()){
          this.mailPlan=mailPlanData[0];
        }else{
          this.mailPlan=mailPlanData[1];
        }
      }else{
        mailPlanData = 
            [  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                  MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                  CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                  CMPGN_NR__c ,MLPLN_END_DT__c
              From   MailPlan_Order_Oppty__c  
              where  MLPLN_CD__c = :this.currUsrContact.MLPLN_CD__c
              and    Market__c = :this.market.Id
              order by MLPLN_END_DT__c asc];  
        this.mailPlan=mailPlanData[0];
      }      
    }
    if(this.userProfile=='Avon Zone Manager'){
      /*
        Anand: TODO - Need to determine if this IF-ELSE is redundant as 
        in the subsequent lines the mailplan data is again set based
        on market.
      */
      if(this.market.Mail_Plan_Enabled__c){
        mailPlanData = 
            [  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                  MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                  CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                  CMPGN_NR__c ,MLPLN_END_DT__c
              From   MailPlan_Order_Oppty__c  
              where  SLS_ZONE_CD__c=:this.currUsr.DFALT_ZONE_CD__c
              and    Market__c = :this.market.Id
              order by MLPLN_END_DT__c asc];  
        if(mailPlanData[0].MLPLN_END_DT__c>System.today()){
          this.mailPlan=mailPlanData[0];
        }else{
          this.mailPlan=mailPlanData[1];
        }
      }else{
        mailPlanData = 
            [  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                  MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                  CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                  CMPGN_NR__c ,MLPLN_END_DT__c
              From   MailPlan_Order_Oppty__c  
              where  Market__c = :this.market.Id
              order by MLPLN_END_DT__c asc];  
        System.debug('>>>>>>>>>>>>>>> mailPlanData.size:'+mailPlanData.size());
        this.mailPlan=mailPlanData[0];
      }      
    }
    Date currDate = System.today();
    if(this.market.Mail_Plan_Enabled__c){
      Date mPlanEndDt = getMailPlanEndDt(currDate);
      System.debug('Looking for Mail Plans between:'+currDate + '& '+mPlanEndDt);
      /*
        Get all Mail plans that are closing "next day".
      */  
      mailPlanData = 
          [  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                CMPGN_NR__c ,MLPLN_END_DT__c
            From   MailPlan_Order_Oppty__c  
            where  Market__c = :this.market.Id
            and    MLPLN_END_DT__c >:currDate
            and    MLPLN_END_DT__c <=:mPlanEndDt
            order by MLPLN_END_DT__c asc];
    }else{
      currDate = currDate.addDays(1);
      /*
        Get all Mail plans that are closing in the future (should always return 1 record).
      */  
      mailPlanData = 
          [  Select   SLS_ZONE_CD__c, NEXT_MLPLN_TO_CLOS_CD__c, MRKT_ID__c, 
                MLPLN_CD__c, CURRNT_NEXT_CMPGN_PRFX_CD__c, 
                CURRNT_CMPGN_ONLN_RMN_DAY_CNT__c, CURRNT_CMPGN_MAIL_RMN_DAY_CNT__c, 
                CMPGN_NR__c ,MLPLN_END_DT__c
            From   MailPlan_Order_Oppty__c  
            where  Market__c = :this.market.Id
            and    MLPLN_END_DT__c >=:currDate
            order by MLPLN_END_DT__c asc];
    }
    if(mailPlanData.size() == 0){
      //This should never occur. Leave the mail plan related data "null" so that they display empty against
      //the respective fields.  
    }else{
      System.debug('>>>>>>>>>>>>>>>>>>>>>> Mail Plan data = '+mailPlanData);
      mailPlansToClose='';
      for(MailPlan_Order_Oppty__c mailPlan : mailPlanData ){
        if(!mailPlansToClose.contains(mailPlan.MLPLN_CD__c)){
          mailPlansToClose+=mailPlan.MLPLN_CD__c+',';
        }
      }
      System.debug('>>>>>>>>>>>>>>>>>>>>>> mailPlansToClose = '+mailPlansToClose);
      if(mailPlansToClose.length()>0){
        mailPlansToClose = mailPlansToClose.substring(0,mailPlansToClose.length()-1);
      }
      if(this.userProfile !='Avon Leader'){
        //For Zone and Division pick the first mail plan that closes.
        this.mailPlan = mailPlanData[0];
      }
    }
    List<Sales_Organization__c> tempSlsOrg = [  Select   SLS_REGN_NM__c,
                              SLS_ORG_CD__c
                          From   Sales_Organization__c 
                          where  SLS_ORG_CD__c=:this.currUsr.DFALT_DIV_NM__c
                          and   SLS_ORG_LVL_NR__c='D'];
          
    if(tempSlsOrg.size()>0){
      this.usrSlsOrg = tempSlsOrg[0];  
    }                      
    return null;  
  }
  
  public Date getMailPlanEndDt(Date startDt){
    Date weekStart = startDt.toStartOfWeek();
    /*
     Start of Week returns 4 for Europenan locales
     Need to look at  a better way to do this
     For now just assuming UK Locale 
    */
    if(weekStart.daysBetween(startDt) == 4){
      //If Friday, look ahead 3 days so that you look at Monday
      return startDt.addDays(3);
    }else if(weekStart.daysBetween(startDt) == 5){
      //If Saturday, look ahead 3 days so that you look at Monday
      return startDt.addDays(2);
    }else{
      //Otherwise look ahead 1 day only
      return startDt.addDays(1);
    }
  }
  
  public static testmethod void testSiteHeaderController(){
    TestDataHelper testData = new TestDataHelper();
    SiteHeaderController ctlr = new SiteHeaderController();
    String acctNbr = '123456';
    User ldrUsr = testData.createLeaderUser(acctNbr);
    testData.createSalesOrgs();
    Contact ct = testData.createContact(acctNbr,ldrUsr.Id);
    System.runAs(ldrUsr){
      ctlr.init();
    }
    testData.market.Mail_Plan_Enabled__c=false;
    update testData.market;
    
    System.runAs(ldrUsr){
      ctlr.init();
    }
    
    ldrUsr = testData.createZoneUser('Z'+acctNbr);
    System.runAs(ldrUsr){
      ctlr.init();
    }

    Date currDt = Date.newInstance(2009,8,1);
    System.debug('>>>>>>>>>>>>>>>>>>ctlr.getMailPlanEndDt:'+ctlr.getMailPlanEndDt(currDt).day());
    //System.assert(ctlr.getMailPlanEndDt(currDt).day()==2);

    currDt = Date.newInstance(2009,7,31);
    System.debug('>>>>>>>>>>>>>>>>>>ctlr.getMailPlanEndDt:'+ctlr.getMailPlanEndDt(currDt).day());
    //System.assert(ctlr.getMailPlanEndDt(currDt).day()==2);    

    currDt = Date.newInstance(2009,8,2);
    System.debug('>>>>>>>>>>>>>>>>>>ctlr.getMailPlanEndDt:'+ctlr.getMailPlanEndDt(currDt).day());
    //System.assert(ctlr.getMailPlanEndDt(currDt).day()==3);    
        
  }
}
			                            	