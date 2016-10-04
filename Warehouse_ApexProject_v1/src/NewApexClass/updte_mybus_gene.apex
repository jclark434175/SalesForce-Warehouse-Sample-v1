public class updte_mybus_gene{
 /*   public static void updatemybusgene(My_Business__c[] mybus){
        List<Genealogy__c> geneToUpdate = new List<Genealogy__c>();
        for (My_Business__c mb:mybus) {
            Genealogy__c gene = null;
            //Find the Genealogy associated with the MyBusiness
            gene = [SELECT Id, MRKT_ACCT_KEY__c, Personal_Sales__c 
                   FROM Genealogy__c WHERE MRKT_ACCT_KEY__c = :mb.MRKT_ACCT_KEY__c];
            gene.Personal_Sales__c = mb.Id;
            geneToUpdate.add(gene);
        
        }
    update geneToUpdate;
    }
    public static void updateldrgene(Leader_Downline_Summary__c[] ldrs){
        List<Genealogy__c> geneToUpdte = new List<Genealogy__c>();
        for (Leader_Downline_Summary__c lds:ldrs) {
            Genealogy__c gen = null;
            //Find the Genealogy associated with the MyBusiness
            gen = [SELECT Id, MRKT_ACCT_KEY__c, Group_Sales__c 
                   FROM Genealogy__c WHERE MRKT_ACCT_KEY__c = :lds.MRKT_ACCT_KEY__c];
            gen.Group_Sales__c = lds.Id;
            geneToUpdte.add(gen);
        
        }
    update geneToUpdte; 
    }
    static testMethod void updtegnetest(){
         
        My_Business__c b = new My_Business__c();
            b.CurrencyISOCode='USD';
            b.MRKT_ACCT_KEY__c ='ZZ12345678';
        insert b;

        Leader_Downline_Summary__c l = new Leader_Downline_Summary__c();
            l.CurrencyIsoCode='USD';
            l.MRKT_ACCT_KEY__c='ZZ12345678';
        insert l;
        Genealogy__c g = new Genealogy__c();
            g.MRKT_ACCT_KEY__c='ZZ12345678';
            g.CurrencyIsoCode='USD';
        insert g;  
        
        System.Debug('Personal' + g.Personal_Sales__c + '-' + b.id);  
 
        System.AssertEquals(g.Personal_Sales__c,b.id);
        System.AssertEquals(g.Group_Sales__c,[Select id from
            Leader_Downline_Summary__c where id=:l.id].id);

    }*/
    
}
			                            	