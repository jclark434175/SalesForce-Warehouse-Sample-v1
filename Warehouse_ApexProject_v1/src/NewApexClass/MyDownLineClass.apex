public class MyDownLineClass {
        
        public Genealogy__c genealogy {get; private set;}
        public Boolean selected { get; set; }
        public Integer achievementFlag { get; private set; } // 0 = no orders; 1 = under_quota; 2 = over_quota
        public Integer downlinesFlag { get; private set; } // 0 = no downlines; 1 = 1 downline; 2 = 2 downlines;
        public String ldrTitle {get; set;}
        public String sellerSts {get; set;}
        public String genNbr {get; set;}
        public Decimal minToEarn {get; set;}
        //private transient Leader_Title__c currLdr;
        public MyDownlineClass( Genealogy__c gene,String title,String sellSts,
                                Decimal minToEarn) {
            this(gene,title,sellSts);

            // determine quota achievement
            achievementFlag=1;
            if(minToEarn!=null){
                if(gene.Personal_Sales__c ==null ||gene.Personal_Sales__r.NET_SLS_AMT__c <=0 ){
                    System.debug('Personal sales null or Net_Sales Amt <=0');
                    achievementFlag = 1; // no current orders
                }else if(   
                    gene.Personal_Sales__r.AWRD_SLS_AMT__c > 0 && 
                    gene.Personal_Sales__r.AWRD_SLS_AMT__c < minToEarn)
                {
                    System.debug('0<AWRD_SLS_AMT<minToEarn');
                    achievementFlag = 2; // quota not achieved
                }else if(gene.Personal_Sales__r.AWRD_SLS_AMT__c >= minToEarn){
                    System.debug('0<minToEarn>AWRD_SLS_AMT');
                    achievementFlag = 3; // quota achieved
                }
            }
            //Zishan added currRepGene.Group_Sales__r.Genrtn_1_Grp_Awrd_SLS_AMT 07/30/09
          
            If(gene.LDRSHP_TITL_LVL_NR__c !=-2 && gene.Group_Sales__r!=null )
            {
                System.Debug('Before Updating to 0.0: ' + gene.MLdr_GRP_AWRD_SLS_AMT__c);
                gene.MLdr_GRP_AWRD_SLS_AMT__c=0.0;
                if(gene.Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c!=null)
                {
                    gene.MLdr_GRP_AWRD_SLS_AMT__c +=gene.Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c;
                }
                System.Debug('After adding Group Sales : ' + gene.MLdr_GRP_AWRD_SLS_AMT__c);
                if(gene.Personal_Sales__r.AWRD_SLS_AMT__c!=null)
                {
                    gene.MLdr_GRP_AWRD_SLS_AMT__c +=gene.Personal_Sales__r.AWRD_SLS_AMT__c;
                }
                System.Debug('After adding Personal Sales : ' + gene.MLdr_GRP_AWRD_SLS_AMT__c);
            }  
        } 
        public MyDownlineClass( Genealogy__c gene,String title,String sellSts,
                                Leader_Title__c ldrTitle,String repAcctNbr) {
            
            this.genealogy = gene;
            this.selected = false;
            selected = false;
            this.ldrTitle = title;
            this.sellerSts = sellSts;
            
            setGenerationNbr(repAcctNbr);
            if(repAcctNbr!=null){
                if(repAcctNbr == genealogy.UPLN_GENRTN_1_ACCT_NR__c){
                    this.minToEarn=ldrTitle.GENRTN_1_MIN_ORD_AMT__c;
                }else if(repAcctNbr == genealogy.UPLN_GENRTN_2_ACCT_NR__c){
                    this.minToEarn=ldrTitle.GENRTN_2_MIN_ORD_AMT__c;
                }else if(repAcctNbr == genealogy.UPLN_GENRTN_3_ACCT_NR__c){
                    this.minToEarn=ldrTitle.GENRTN_3_MIN_ORD_AMT__c;
                }else{
                    this.minToEarn=ldrTitle.GENRTN_3_MIN_ORD_AMT__c;
                }
            }
            /*
            System.debug('>>>>>>>>>>>>>>>> gene.Personal_Sales__c='+gene.Personal_Sales__c); 
            System.debug('>>>>>>>>>>>>>>>> minToEarn='+this.minToEarn);
            System.debug('>>>>>>>>>>>>>>>> Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c='+gene.Personal_Sales__r.MIN_PRSNL_SLS_REQD_AMT__c);
            System.debug('>>>>>>>>>>>>>>>> Personal_Sales__r.NET_SLS_AMT__c='+gene.Personal_Sales__r.NET_SLS_AMT__c);
            System.debug('>>>>>>>>>>>>>>>> Personal_Sales__r.AWRD_SLS_AMT__c='+gene.Personal_Sales__r.AWRD_SLS_AMT__c);
            System.debug('>>>>>>>>>>>>>>>> Representative__r.LDRSHP_TITL_LVL_NBR__c='+gene.Representative__r.LDRSHP_TITL_LVL_NBR__c);
            System.debug('>>>>>>>>>>>>>>>> DWNLN_GENRTN_LVL_CNT__c='+gene.DWNLN_GENRTN_LVL_CNT__c);
            */
            // determine quota achievement
 

            achievementFlag=1;
            if(minToEarn!=null){
                if(gene.Personal_Sales__c ==null ||gene.Personal_Sales__r.NET_SLS_AMT__c <=0 ){
                    //System.debug('Personal sales null or Net_Sales Amt <=0');
                    achievementFlag = 1; // no current orders
                }else if(   
                    gene.Personal_Sales__r.AWRD_SLS_AMT__c > 0 && 
                    gene.Personal_Sales__r.AWRD_SLS_AMT__c < minToEarn)
                {
                    //System.debug('0<NET_SLS_AMT<minToEarn');
                    achievementFlag = 2; // quota not achieved
                }else if(gene.Personal_Sales__r.AWRD_SLS_AMT__c >= minToEarn){
                    //System.debug('0<minToEarn<NET_SLS_AMT');
                    achievementFlag = 3; // quota achieved
                }
            }
            /*
            If there's no leadership title, they are considered non-leaders
            */
            if(gene.Representative__r.LDRSHP_TITL_LVL_NBR__c == '-2' || gene.DWNLN_GENRTN_LVL_CNT__c==0){
                downlinesFlag = 0;//Non-leader or Leader with no downlines
            }else if (gene.DWNLN_GENRTN_LVL_CNT__c == 1){
                downlinesFlag = 1;//Has 1 generation below them 
            }else if(gene.DWNLN_GENRTN_LVL_CNT__c==2){
                downlinesFlag = 2;//Has 2 generations below them
            }else if(gene.DWNLN_GENRTN_LVL_CNT__c>=3){
                downlinesFlag = 3;//Has 3 or more generation below them
            }
            
            if(gene.LDRSHP_TITL_LVL_NR__c !=-2 && gene.Group_Sales__r!=null )
            {
                System.Debug('Before Updating to 0.0: ' + gene.MLdr_GRP_AWRD_SLS_AMT__c);
                gene.MLdr_GRP_AWRD_SLS_AMT__c=0.0;
                if(gene.Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c!=null)
                {
                    gene.MLdr_GRP_AWRD_SLS_AMT__c +=gene.Group_Sales__r.CC_GRP_AWRD_SLS_AMT__c;
                }
                System.Debug('After adding Group Sales : ' + gene.MLdr_GRP_AWRD_SLS_AMT__c);
                if(gene.Personal_Sales__r.AWRD_SLS_AMT__c!=null)
                {
                    gene.MLdr_GRP_AWRD_SLS_AMT__c +=gene.Personal_Sales__r.AWRD_SLS_AMT__c;
                }
                System.Debug('After adding Personal Sales : ' + gene.MLdr_GRP_AWRD_SLS_AMT__c);
            }  
           
            System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+this.downlinesFlag+',ACH:'+this.achievementFlag);
        
        }
        public MyDownlineClass(Genealogy__c gene,String title,String sellSts) {
            this(gene,title,sellSts,null,null);
        }

        public void setGenerationNbr(String repAcctNbr){
            if(repAcctNbr!=null){
                if(repAcctNbr == genealogy.UPLN_GENRTN_1_ACCT_NR__c){
                    this.genNbr='I';    
                }else if(repAcctNbr == genealogy.UPLN_GENRTN_2_ACCT_NR__c){
                    this.genNbr='II';   
                }else if(repAcctNbr == genealogy.UPLN_GENRTN_3_ACCT_NR__c){
                    this.genNbr='III';  
                }else{
                    this.genNbr='III+'; 
                }
            }
          
        }
        
        
        public static testmethod void testDownlineClass(){
            String mktIdKey = 'U123456';
            MyDownlineClass downline; 
            TestDataHelper testData = new TestDataHelper();
            User testUsr = testData.createLeaderUser('U123456');
            List<My_Business__c> myBusList = testData.createMyBusinessData('12345678',UserInfo.getUserId());
            List<Leader_Downline_Summary__c> ldrSmryData = testData.createLdrSmryData('12345678',UserInfo.getUserId());
            Contact ct = new Contact();
            My_Business__c myBus= new My_Business__c(AWRD_SLS_AMT__c=0,MIN_PRSNL_SLS_REQD_AMT__c=8);
            Genealogy__c gene = new Genealogy__c(UPLN_GENRTN_1_ACCT_NR__c='UP1',UPLN_GENRTN_2_ACCT_NR__c='UP2',
                                                 UPLN_GENRTN_3_ACCT_NR__c='UP3',DWNLN_GENRTN_LVL_CNT__c=0);
            Leader_Title__c ldrTitle = new Leader_Title__c(GENRTN_1_MIN_ORD_AMT__c=10.0,GENRTN_2_MIN_ORD_AMT__c=10.0,GENRTN_3_MIN_ORD_AMT__c=10.0);

            gene.Personal_Sales__r=myBus;
            gene.Personal_sales__c=myBusList[0].Id;
            
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==1);
            
               
            gene.Personal_Sales__r = myBus;
            gene.Personal_sales__c=myBusList[0].Id;
            gene.Representative__r = ct;
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==1);
            
            gene.Personal_Sales__r.AWRD_SLS_AMT__c=10.0;
            
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==3);


            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP2');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==3);
            
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP3');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==3);
            
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP3+');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==3);
            
            gene.Representative__r.LDRSHP_TITL_LVL_NBR__c='1';
            gene.DWNLN_GENRTN_LVL_CNT__c=1;
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==1);
            System.assert(downline.achievementFlag==3);

            gene.DWNLN_GENRTN_LVL_CNT__c=2;
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==2);
            System.assert(downline.achievementFlag==3);

            gene.DWNLN_GENRTN_LVL_CNT__c=3;
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==3);
            System.assert(downline.achievementFlag==3);

            gene.Personal_Sales__r.AWRD_SLS_AMT__c=10;
            ldrTitle.GENRTN_1_MIN_ORD_AMT__c = 11.0;
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==3);
            System.assert(downline.achievementFlag==2);


            gene = new Genealogy__c(UPLN_GENRTN_1_ACCT_NR__c='UP1',UPLN_GENRTN_2_ACCT_NR__c='UP2',
                                                 UPLN_GENRTN_3_ACCT_NR__c='UP3',DWNLN_GENRTN_LVL_CNT__c=0);
            myBus= new My_Business__c(AWRD_SLS_AMT__c=0,MIN_PRSNL_SLS_REQD_AMT__c=8);
            gene.Personal_Sales__r=myBus;
            gene.Personal_sales__c=myBusList[0].Id;
            
            downline = new MyDownlineClass(gene,'Title','SellerSts',ldrTitle,'UP1');
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==1);
            
               
            gene.Personal_Sales__r = myBus;
            gene.Personal_sales__c=myBusList[0].Id;
            gene.Representative__r = ct;

            downline = new MyDownlineClass(gene,'Title','SellerSts',10.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==1);
            
               
            gene.Personal_Sales__r = myBus;
            gene.Personal_sales__c=myBusList[0].Id;
            gene.Representative__r = ct;
            downline = new MyDownlineClass(gene,'Title','SellerSts',10.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==1);
            
            gene.Personal_Sales__r.AWRD_SLS_AMT__c=10.0;
            
            downline = new MyDownlineClass(gene,'Title','SellerSts',10.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==0);
            System.assert(downline.achievementFlag==3);
            
            gene.Representative__r.LDRSHP_TITL_LVL_NBR__c='1';
            gene.DWNLN_GENRTN_LVL_CNT__c=1;
            downline = new MyDownlineClass(gene,'Title','SellerSts',10.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==1);
            System.assert(downline.achievementFlag==3);

            gene.DWNLN_GENRTN_LVL_CNT__c=2;
            downline = new MyDownlineClass(gene,'Title','SellerSts',10.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==2);
            System.assert(downline.achievementFlag==3);

            gene.DWNLN_GENRTN_LVL_CNT__c=3;
            downline = new MyDownlineClass(gene,'Title','SellerSts',10.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==3);
            System.assert(downline.achievementFlag==3);

            gene.Personal_sales__c=myBusList[0].Id;
            gene.Representative__r = ct;
            gene.Group_Sales__r=ldrSmryData[0];
            gene.Group_Sales__c=ldrSmryData[0].Id;
            gene.Personal_Sales__r.AWRD_SLS_AMT__c=10;
            ldrTitle.GENRTN_1_MIN_ORD_AMT__c = 11.0;
            downline = new MyDownlineClass(gene,'Title','SellerSts',11.0);
            //System.debug('%%%%%%%%%%%%%%%%%%% DWN:'+downline.downlinesFlag+',ACH:'+downline.achievementFlag);
            System.assert(downline.downlinesFlag==3);
            System.assert(downline.achievementFlag==2);
            //System.assert(gene.MLdr_GRP_AWRD_SLS_AMT__c==110.0);
            
        }
}
			                            	