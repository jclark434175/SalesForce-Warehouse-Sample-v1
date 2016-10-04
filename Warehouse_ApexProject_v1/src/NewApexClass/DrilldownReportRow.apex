public class DrilldownReportRow {
  public Genealogy__c row {get; set;}
  public Boolean selected {get; set;}
  public Sales_Organization__c salesOrg {get; set;}
  public String title {get; set;}
  public String sellerSts {get; set;}
  public Decimal minToEarn {get; set;}
  
  private String loggedInRep;
  public Boolean oddRow {get; set;}
  public DrilldownReportRow(String repAcctNbr, Genealogy__c geneRow,Boolean oddRow){
    this.loggedInRep = repAcctNbr;
    this.row = geneRow;
    this.oddRow = oddRow;
    this.selected=false;
  }
  
  public Boolean getIsDirectDownline(){
    if(this.row.UPLN_GENRTN_1_ACCT_NR__c == this.loggedInRep){
      return true;
    }else{
      return false;  
    }
      
  }
  public String getDownlineGenNbr(){
    if(this.row.UPLN_GENRTN_1_ACCT_NR__c == this.loggedInRep){
      return 'I';
    }else if(this.row.UPLN_GENRTN_2_ACCT_NR__c == this.loggedInRep){
      return 'II';  
    }else if (this.row.UPLN_GENRTN_3_ACCT_NR__c == this.loggedInRep){
      return 'III';  
    }else{
      return null;
    }
    
  }
  public String getUplineAcctNbr(){

    if(this.row.UPLN_GENRTN_1_ACCT_NR__c == this.loggedInRep){
      return this.loggedInRep;
    }else if(this.row.UPLN_GENRTN_2_ACCT_NR__c == this.loggedInRep){
      return this.row.UPLN_GENRTN_1_ACCT_NR__c;  
    }else if (this.row.UPLN_GENRTN_3_ACCT_NR__c == this.loggedInRep){
      return this.row.UPLN_GENRTN_2_ACCT_NR__c;  
    }else{
      return this.row.UPLN_GENRTN_1_ACCT_NR__c;
    }
  }
  public String getUplineLdrName(){

    if(this.row.UPLN_GENRTN_1_ACCT_NR__c == this.loggedInRep){
      return '';
    }else if(this.row.UPLN_GENRTN_2_ACCT_NR__c == this.loggedInRep){
      return this.row.UPLN_GENRTN_1_FULL_NM__c;  
    }else if (this.row.UPLN_GENRTN_3_ACCT_NR__c == this.loggedInRep){
      return this.row.UPLN_GENRTN_2_FULL_NM__c;  
    }else{
      return this.row.UPLN_GENRTN_1_FULL_NM__c;
    }
  }

  public String getUplineLdrPhone(){

    if(this.row.UPLN_GENRTN_1_ACCT_NR__c == this.loggedInRep){
      return '';
    }else if(this.row.UPLN_GENRTN_2_ACCT_NR__c == this.loggedInRep){
      return this.row.UPLN_GENRTN_1_PHON_NR__c;  
    }else if (this.row.UPLN_GENRTN_3_ACCT_NR__c == this.loggedInRep){
      return this.row.UPLN_GENRTN_2_PHON_NR__c;  
    }else{
      return this.row.UPLN_GENRTN_1_PHON_NR__c;
    }
  }
  
  public static testmethod void testDrilldownRow(){
    Genealogy__c gene = new Genealogy__c(  UPLN_GENRTN_1_ACCT_NR__c='1',
                        UPLN_GENRTN_2_ACCT_NR__c='2',
                        UPLN_GENRTN_3_ACCT_NR__c='3',
                        UPLN_GENRTN_1_FULL_NM__c='1 Name',
                        UPLN_GENRTN_2_FULL_NM__c='2 Name',
                        UPLN_GENRTN_3_FULL_NM__c='3 Name',
                        UPLN_GENRTN_1_PHON_NR__c='1 Phone',
                        UPLN_GENRTN_2_PHON_NR__c='2 Phone',
                        UPLN_GENRTN_3_PHON_NR__c='3 Phone');
    DrilldownReportRow row = new DrilldownReportRow('3',gene,true);
    System.assert(row.getIsDirectDownline()==false);
    System.assert(row.getUplineLdrName()=='2 Name');  
    System.assert(row.getUplineAcctNbr()=='2');
    System.assert(row.getDownlineGenNbr()=='III');  
    System.assert(row.getUplineLdrPhone()==gene.UPLN_GENRTN_2_PHON_NR__c);  
    row = new DrilldownReportRow('2',gene,true);
    System.assert(row.getIsDirectDownline()==false);
    System.assert(row.getUplineLdrName()=='1 Name');  
    System.assert(row.getUplineAcctNbr()=='1');  
    System.assert(row.getDownlineGenNbr()=='II')  ;
    System.assert(row.getUplineLdrPhone()==gene.UPLN_GENRTN_1_PHON_NR__c);  
    row = new DrilldownReportRow('1',gene,true);
    System.assert(row.getIsDirectDownline()==true);
    System.assert(row.getUplineLdrName()=='');  
    System.assert(row.getUplineAcctNbr()=='1');  
    System.assert(row.getDownlineGenNbr()=='I')  ;
    System.assert(row.getUplineLdrPhone()=='');  

    row = new DrilldownReportRow('5',gene,true);
    System.assert(row.getIsDirectDownline()==false);
    System.assert(row.getUplineLdrName()=='1 Name');  
    System.assert(row.getUplineAcctNbr()=='1');  
    System.assert(row.getDownlineGenNbr()==null)  ;
    System.assert(row.getUplineLdrPhone()=='1 Phone');  

  }
}
			                            	