public class testbizldrupdategene{
    static testMethod void testbizldrupdategene(){

    Market__c mkt = new Market__c(
                    Name='Test Market',
                    Market_Id__c='XX',
                    ASLF_Timezone_Offset__c=0.0,
                    ASLF_Report_URL__c='http://aslf.report.avon.com'
            );
    insert mkt;
    Profile sysAdm = [select Id,Name from Profile where Name='Avon Leader'];

    User tempUsr = new User(
                 Username='123456789z'+'@avonpoc.com',
                 TimeZoneSidKey='America/New_York',
                 ProfileId=sysAdm.Id,
                 LocaleSidKey='en_US',
                 Last_Name__c='prfName',
                 First_Name__c='Avon Test',
                 Email='123456789z'+'@avonpoc.com',
                 GI3_Email__c='123456789z'+'@avonpoc.com',
                 Alias='test',
                 EmailEncodingKey='ISO-8859-1',
                 LanguageLocaleKey='en_US',
                 IsActive=true, 
                 ACCT_NR__c='123456789',
                 DFALT_DIV_NM__c='D1',
                 DFALT_ZONE_CD__c='Z',
                 MAX_EMAIL_LIMIT__c=10,
                 MLPLN_CD__c='1',
                 MRKT_ID__c=mkt.Market_Id__c,
                 MRKT_ID_ACCT_NR_KEY__c=mkt.Market_Id__c+'123456789z',
                 MRKT_TAG_1_HDR_TXT__c='Some data',
                 USER_CNTRY_CD__c='US');
    insert tempusr;

    User_Sales_Org_Hierarchy__c uo = new User_Sales_Org_Hierarchy__c(  
                    ACCT_NR__c=tempusr.ACCT_NR__c,
                    Market__c=mkt.Id,
                    MRKT_ID__c=mkt.Market_Id__c,
                    SLS_ORG_CD__c='Z1',
                    SLS_ORG_LVL_CD__c='Z');
    insert uo;

    Sales_Organization__c sso = new Sales_Organization__c(
                                Market__c=mkt.id,
                                CurrencyISOCode='USD',
                                MRKT_SLS_ORG_KEY__c='1',
                                MRKT_ID__c='RO',
                                SLS_ORG_LVL_NR__c='Z',
                                SLS_ZONE_CD__c='Z1',
                                SLS_DIV_NM__c='Verde',SLS_ORG_CD__c='Z1');
    insert sso;
      sso.SLS_ORG_LVL_NR__c='D';
      sso.SLS_ZONE_CD__c='Z2';
      sso.SLS_ORG_CD__c=sso.SLS_DIV_NM__c;
    update sso;
    System.debug('**************************************itis' + sso.SLS_ORG_CD__c +'-'+ sso.SLS_DIV_NM__c);
    System.AssertEquals('Verde',sso.SLS_ORG_CD__c);
    //Create Account Record
    Account a = new Account();  
                a.Name ='12321';
                a.CurrencyISOCode='USD';
    insert a;
    //Create Contact Record
    Contact c = new Contact();
                c.LastName='Razza';
                c.AccountId=a.id;
                c.CurrencyIsoCode='USD';
                c.MRKT_ACCT_KEY__c='XX123456789z';
                c.RMOV_FROM_GENLGY_IND__c='N';
    insert c;                            
        //Create Genealogy record first
        Genealogy__c g = new Genealogy__c();
        g.MRKT_ACCT_KEY__c='XX123456789z';
        g.CurrencyIsoCode='USD';
        g.STRT_OF_CMPGN_IND__c='N';
        g.SLS_ZONE_CD__c=uo.SLS_ORG_CD__c;
        g.MRKT_ID__c='XX';
        g.UPLN_GENRTN_1_ACCT_NR__c='123456789z';
        g.Update_Owner__c='Y';
        g.Representative__c=c.id;
    insert g;
        g.STRT_OF_CMPGN_IND__c='Y';
    update g;             
        System.AssertEquals(null,g.Group_sales__c);
        System.AssertEquals(null,g.Personal_sales__c);
        
        //Create My Business Record 
        My_Business__c b = new My_Business__c();
        b.CurrencyISOCode='USD';
        b.MRKT_ACCT_KEY__c =g.MRKT_ACCT_KEY__c;
        b.BAL_DUE_AMT__c=85.00;
        b.PAST_DUE_AMT__c=90;
        b.AWRD_SLS_AMT__c=100;
        b.MLPLN_CLOSD_IND__c='N';
        b.AWRD_SLS_AMT__c=88;
        b.AVG_AWRD_SLS_AMT__c=10;
        b.NET_SLS_AMT__c=11;
        b.MULT_ORD_CNT__c=12;
        b.ORD_HOLD_AMT__c=11;
        b.CUST_CNT__c=13;
        b.RTURN_NET_SLS_AMT__c=10;
        b.LAST_PYMT_RECVD_AMT__c=10;
        b.ERNGS_PD_AMT__c=10;
    insert b;
        b.MLPLN_CLOSD_IND__c='Y';
    update b;
      
        Leader_Downline_Summary__c l = new Leader_Downline_Summary__c();
        l.CurrencyIsoCode='USD';
        l.MRKT_ACCT_KEY__c='XX123456789z';
        l.GENRTN_1_GRP_ORD_UND_MIN_CNT__c=90;
        l.GRP_ORD_UND_MIN_CNT__c=50;  
        l.IN_ZONE_GENRTN_1_GRP_STF_CNT__c =50; 
        l.IN_ZONE_GENRTN_2_GRP_STF_CNT__c =14;
        l.IN_ZONE_GENRTN_3_GRP_STF_CNT__c =10;
        l.OUT_ZONE_GENRTN_1_GRP_STF_CNT__c =10; 
        l.OUT_ZONE_GENRTN_2_GRP_STF_CNT__c =75;
        l.OUT_ZONE_GENRTN_3_GRP_STF_CNT__c=65;
        l.GENRTN_1_GRP_AWRD_SLS_AMT__c =20; 
        l.GENRTN_2_GRP_AWRD_SLS_AMT__c =15; 
        l.GENRTN_3_GRP_AWRD_SLS_AMT__c =14;  
    insert l;
        
        l.GRP_ORD_UND_MIN_CNT__c=55;
    update l;
        g.OwnerId = tempusr.id; 
        g.Group_Sales__c=l.id;   
        g.Personal_Sales__c=b.id;    
    update g;          
        System.AssertEquals(l.id,g.Group_Sales__c); 
        System.AssertEquals(g.Personal_Sales__c,b.id);             
    c.RMOV_FROM_GENLGY_IND__c='Y';
    update c;
        
    }
    
}
			                            	