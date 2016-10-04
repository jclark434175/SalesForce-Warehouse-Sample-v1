public class ZoneDivMobileHelper {

  public static Map<String,String> FIELD_MAPPING = new Map<String,String>();
  static{
FIELD_MAPPING.put('Orders_Not_Submitted__c','DWNLN_NON_LDR_NO_ORD_CNT__c,DWNLN_NON_LDR_NO_ORD_CNT__c,UQ_TITL_1_NO_ORD_CNT__c,TITL_1_NO_ORD_CNT__c,TITL_2_NO_ORD_CNT__c,TITL_3_NO_ORD_CNT__c,TITL_4_NO_ORD_CNT__c,TITL_5_NO_ORD_CNT__c,NON_LDRSHP_NO_ORD_CNT__c');
FIELD_MAPPING.put('Orders_On_Hold__c','DWNLN_NON_LDR_HOLD_ORD_CNT__c,DWNLN_NON_LDR_HOLD_ORD_CNT__c,UQ_TITL_1_HOLD_ORD_CNT__c,TITL_1_HOLD_ORD_CNT__c,TITL_2_HOLD_ORD_CNT__c,TITL_3_HOLD_ORD_CNT__c,TITL_4_HOLD_ORD_CNT__c,TITL_5_HOLD_ORD_CNT__c,NON_LDRSHP_HOLD_ORD_CNT__c');
FIELD_MAPPING.put('Orders_Under_Minimum__c','DWNLN_NON_LDR_UND_MIN_CNT__c,DWNLN_NON_LDR_UND_MIN_CNT__c,UQ_TITL_1_UND_MIN_CNT__c,TITL_1_UND_MIN_CNT__c,TITL_2_UND_MIN_CNT__c,TITL_3_UND_MIN_CNT__c,TITL_4_UND_MIN_CNT__c,TITL_5_UND_MIN_CNT__c');
FIELD_MAPPING.put('Orders_Achieving_Minimum__c','DWNLN_NON_LDR_ABV_MIN_CNT__c,DWNLN_NON_LDR_ABV_MIN_CNT__c,UQ_TITL_1_ABV_MIN_CNT__c,TITL_1_ABV_MIN_CNT__c,TITL_2_ABV_MIN_CNT__c,TITL_3_ABV_MIN_CNT__c,TITL_4_ABV_MIN_CNT__c,TITL_5_ABV_MIN_CNT__c');
                      
FIELD_MAPPING.put('Pending_Orders__c','NON_LDRSHP_PEND_ORD_CNT__c,LDRSHP_PEND_ORD_CNT__c');
FIELD_MAPPING.put('Orders_with_Multiples__c','DWNLN_NON_LDR_MULT_ORD_CNT__c,DWNLN_NON_LDR_MULT_ORD_CNT__c,UQ_TITL_1_MULT_ORD_CNT__c,TITL_1_MULT_ORD_CNT__c,TITL_2_MULT_ORD_CNT__c,TITL_3_MULT_ORD_CNT__c,TITL_4_MULT_ORD_CNT__c,TITL_5_MULT_ORD_CNT__c,NON_LDRSHP_MULT_ORD_CNT__c');
          
FIELD_MAPPING.put('Total_Orders_Received__c','DWNLN_NON_LDR_ORD_CNT__c,DWNLN_NON_LDR_ORD_CNT__c,UQ_TITL_1_ORD_CNT__c,TITL_1_ORD_CNT__c,TITL_2_ORD_CNT__c,TITL_3_ORD_CNT__c,TITL_4_ORD_CNT__c,TITL_5_ORD_CNT__c,NON_LDRSHP_ORD_CNT__c');
FIELD_MAPPING.put('Return_Orders__c','LDRSHP_RTURN_CNT__c,NON_LDRSHP_RTURN_CNT__c');
FIELD_MAPPING.put('Customers_Served__c','LDRSHP_CUST_CNT__c');
FIELD_MAPPING.put('Average_Customers__c','AVG_CUST_CNT__c');

FIELD_MAPPING.put('Demonstration_Items_Purchased__c','LDRSHP_DEMO_ITEM_CNT__c');
FIELD_MAPPING.put('Brochures_Purchased__c','LDRSHP_BRCHR_CNT__c');
FIELD_MAPPING.put('Sales_Tools_Purchased__c','LDRSHP_SLS_AIDS_CNT__c');
FIELD_MAPPING.put('Total_Award_Sales__c','DWNLN_NON_LDR_AWRD_SLS_AMT__c,DWNLN_NON_LDR_AWRD_SLS_AMT__c,UQ_TITL_1_AWRD_SLS_AMT__c,TITL_1_AWRD_SLS_AMT__c,TITL_2_AWRD_SLS_AMT__c,TITL_3_AWRD_SLS_AMT__c,TITL_4_AWRD_SLS_AMT__c,TITL_5_AWRD_SLS_AMT__c');
FIELD_MAPPING.put('Award_Sales_Below_Minimum__c','BLW_MIN_LDRSHP_AWRD_SLS_AMT__c');
FIELD_MAPPING.put('Net_Sales__c','DWNLN_NON_LDR_NET_SLS_AMT__c,DWNLN_NON_LDR_NET_SLS_AMT__c,UQ_TITL_1_NET_SLS_AMT__c,TITL_1_NET_SLS_AMT__c,TITL_2_NET_SLS_AMT__c,TITL_3_NET_SLS_AMT__c,TITL_4_NET_SLS_AMT__c,TITL_5_NET_SLS_AMT__c');
FIELD_MAPPING.put('Average_Order_with_Multiples__c','AVG_MULT_ORD_AMT__c');
FIELD_MAPPING.put('Return_Net_Sales__c','UQ_TITL_1_RTURN_AMT__c,UQ_TITL_1_RTURN_AMT__c,TITL_1_RTURN_AMT__c,TITL_2_RTURN_AMT__c,TITL_3_RTURN_AMT__c,TITL_4_RTURN_AMT__c,TITL_5_RTURN_AMT__c,DWNLN_NON_LDR_RTURN_AMT__c');
FIELD_MAPPING.put('Total_Sales__c','TITL_1_AWRD_SLS_AMT__c,TITL_1_AWRD_SLS_AMT__c,PC_TITL_1_AWRD_SLS_AMT__c,TITL_2_AWRD_SLS_AMT__c,PC_TITL_2_AWRD_SLS_AMT__c,TITL_3_AWRD_SLS_AMT__c,PC_TITL_3_AWRD_SLS_AMT__c,TITL_4_AWRD_SLS_AMT__c,PC_TITL_4_AWRD_SLS_AMT__c,TITL_5_AWRD_SLS_AMT__c,PC_TITL_5_AWRD_SLS_AMT__c,DWNLN_NON_LDR_AWRD_SLS_AMT__c,NON_LDRSHP_AWRD_SLS_AMT__c,PC_DWNLN_NON_LDR_AWRD_SLS_AMT__c,PC_NON_LDRSHP_AWRD_SLS_AMT__c');
FIELD_MAPPING.put('Balance_Due__c','TITL_1_BAL_DUE_AMT__c,TITL_1_BAL_DUE_AMT__c,TITL_2_BAL_DUE_AMT__c,TITL_3_BAL_DUE_AMT__c,TITL_4_BAL_DUE_AMT__c,TITL_5_BAL_DUE_AMT__c,NON_LDRSHP_BAL_DUE_AMT__c,DWNLN_NON_LDR_BAL_DUE_AMT__c ');
FIELD_MAPPING.put('Past_Due__c','NON_LDRSHP_PAST_DUE_AMT__c,NON_LDRSHP_PAST_DUE_AMT__c,TITL_5_PAST_DUE_AMT__c,TITL_4_PAST_DUE_AMT__c,TITL_3_PAST_DUE_AMT__c,TITL_2_PAST_DUE_AMT__c,TITL_1_PAST_DUE_AMT__c,DWNLN_NON_LDR_PAST_DUE_AMT__c');
FIELD_MAPPING.put('Bad_Debt__c','TITL_1_BAD_DEBT_AMT__c,TITL_1_BAD_DEBT_AMT__c,TITL_2_BAD_DEBT_AMT__c,TITL_3_BAD_DEBT_AMT__c,TITL_4_BAD_DEBT_AMT__c,TITL_5_BAD_DEBT_AMT__c,NON_LDRSHP_BAD_DEBT_AMT__c,DWNLN_NON_LDR_BAD_DEBT_AMT__c');
FIELD_MAPPING.put('Titles_At_Risk__c','PC_TITL_1_TAR_CNT__c,PC_TITL_1_TAR_CNT__c,PC_TITL_2_TAR_CNT__c,PC_TITL_3_TAR_CNT__c,PC_TITL_4_TAR_CNT__c,PC_TITL_5_TAR_CNT__c');
FIELD_MAPPING.put('Close_To_Next_Level__c','PC_TITL_1_CTT_CNT__c,PC_TITL_1_CTT_CNT__c,PC_TITL_2_CTT_CNT__c,PC_TITL_3_CTT_CNT__c,PC_TITL_4_CTT_CNT__c,PC_TITL_5_CTT_CNT__c');
FIELD_MAPPING.put('Promoted__c','TITL_1_TITL_PROMTD_CNT__c,TITL_1_TITL_PROMTD_CNT__c,TITL_2_TITL_PROMTD_CNT__c,TITL_3_TITL_PROMTD_CNT__c,TITL_4_TITL_PROMTD_CNT__c,TITL_5_TITL_PROMTD_CNT__c');
FIELD_MAPPING.put('Additions__c','TITL_1_APPT_CNT__c,TITL_1_APPT_CNT__c,TITL_1_RNSTMT_CNT__c,TITL_2_APPT_CNT__c,TITL_2_RNSTMT_CNT__c,TITL_3_APPT_CNT__c,TITL_3_RNSTMT_CNT__c,TITL_4_APPT_CNT__c,TITL_4_RNSTMT_CNT__c,TITL_5_APPT_CNT__c,TITL_5_RNSTMT_CNT__c,ZONE_MGR_APPT_CNT__c,ZONE_MGR_RNSTMT_CNT__c');
FIELD_MAPPING.put('Removals__c','TITL_1_RMOVL_CNT__c,TITL_1_RMOVL_CNT__c,TITL_2_RMOVL_CNT__c,TITL_3_RMOVL_CNT__c,TITL_4_RMOVL_CNT__c,TITL_5_RMOVL_CNT__c,ZONE_MGR_RMOVL_CNT__c');
FIELD_MAPPING.put('Potential_Inactive__c','INACTV_1_CMPGN_TITL_1_CNT__c,INACTV_1_CMPGN_TITL_1_CNT__c,INACTV_2_CMPGN_TITL_1_CNT__c,INACTV_3_CMPGN_TITL_1_CNT__c,INACTV_1_CMPGN_TITL_2_CNT__c,INACTV_2_CMPGN_TITL_2_CNT__c,INACTV_3_CMPGN_TITL_2_CNT__c,INACTV_1_CMPGN_TITL_3_CNT__c,INACTV_2_CMPGN_TITL_3_CNT__c,INACTV_3_CMPGN_TITL_3_CNT__c,INACTV_1_CMPGN_TITL_4_CNT__c,INACTV_2_CMPGN_TITL_4_CNT__c,INACTV_3_CMPGN_TITL_4_CNT__c,INACTV_1_CMPGN_TITL_5_CNT__c,INACTV_2_CMPGN_TITL_5_CNT__c,INACTV_3_CMPGN_TITL_5_CNT__c,INACTV_1_CMPGN_DWNLN_NON_LDR_C__c,INACTV_1_CMPGN_NON_LDRSHP_CNT__c,INACTV_2_CMPGN_DWNLN_NON_LDR_C__c,INACTV_2_CMPGN_NON_LDRSHP_CNT__c,INACTV_3_CMPGN_DWNLN_NON_LDR_C__c,INACTV_3_CMPGN_NON_LDRSHP_CNT__c');
FIELD_MAPPING.put('PATD_Certified__c','TITL_1_PATD_CNT__c,TITL_1_PATD_CNT__c,TITL_2_PATD_CNT__c,TITL_3_PATD_CNT__c,TITL_4_PATD_CNT__c,TITL_5_PATD_CNT__c');
FIELD_MAPPING.put('Not_PATD_Certified__c','TITL_1_WO_PATD_CNT__c,TITL_1_WO_PATD_CNT__c,TITL_2_WO_PATD_CNT__c,TITL_3_WO_PATD_CNT__c,TITL_4_WO_PATD_CNT__c,TITL_5_WO_PATD_CNT__c');
FIELD_MAPPING.put('Sales_Status__c','TITL_1_TOP_SLR_CNT__c,TITL_1_TOP_SLR_CNT__c,TITL_2_TOP_SLR_CNT__c,TITL_3_TOP_SLR_CNT__c,TITL_4_TOP_SLR_CNT__c,TITL_5_TOP_SLR_CNT__c,DWNLN_NON_LDR_TOP_SLR_CNT__c,NON_LDRSHP_TOP_SLR_CNT__c');
FIELD_MAPPING.put('Aniversaries__c','TITL_1_ANNIV_CNT__c,TITL_1_ANNIV_CNT__c,TITL_2_ANNIV_CNT__c,TITL_3_ANNIV_CNT__c,TITL_4_ANNIV_CNT__c,TITL_5_ANNIV_CNT__c,NON_LDRSHP_ANNIV_CNT__c');
FIELD_MAPPING.put('Birthdays__c','TITL_1_BRTHDY_CNT__c,TITL_1_BRTHDY_CNT__c,TITL_2_BRTHDY_CNT__c,TITL_3_BRTHDY_CNT__c,TITL_4_BRTHDY_CNT__c,TITL_5_BRTHDY_CNT__c,NON_LDRSHP_BRTHDY_CNT__c');    
FIELD_MAPPING.put('PC_Orders_Not_Submitted__c','PC_LDRSHP_NO_ORD_CNT__c,PC_NON_LDRSHP_NO_ORD_CNT__c');
FIELD_MAPPING.put('PC_Orders_Under_Minimum__c','PC_LDRSHP_UND_MIN_CNT__c');
FIELD_MAPPING.put('PC_Orders_Achieving_Minimum__c','PC_LDRSHP_ABV_MIN_CNT__c');
FIELD_MAPPING.put('PC_Pending_Orders__c','PC_LDRSHP_PEND_ORD_CNT__c,PC_NON_LDRSHP_PENDNG_ORD_CNT__c');
FIELD_MAPPING.put('PC_Orders_with_Multiples__c','PC_LDRSHP_MULT_ORD_CNT__c,PC_NON_LDRSHP_MULT_ORD_CNT__c');
FIELD_MAPPING.put('PC_Total_Orders_received__c','PC_LDRSHP_ORD_CNT__c,PC_NON_LDRSHP_ORD_CNT__c');
FIELD_MAPPING.put('PC_Returns__c','PC_LDRSHP_RTURN_CNT__c,PC_NON_LDRSHP_RTURN_CNT__c');
FIELD_MAPPING.put('PC_Customers__c','PC_LDRSHP_CUST_CNT__c');
FIELD_MAPPING.put('PC_Average_Customers__c','PREV_CMPGN_AVG_CUST_CNT__c');
FIELD_MAPPING.put('PC_Brochures__c','PC_LDRSHP_BRCHR_CNT__c');
FIELD_MAPPING.put('PC_Total_Award_Sales__c','PC_LDRSHP_AWRD_SLS_AMT__c');
FIELD_MAPPING.put('PC_Award_Sales_Below_Minimum__c','PC_BLW_MIN_LDRSHP_AWRD_SLS_AMT__c');
FIELD_MAPPING.put('PC_Net_Sales__c','PC_LDRSHP_NET_SLS_AMT__c');
FIELD_MAPPING.put('PC_Average_Order_with_Multiples__c','PC_AVG_MULT_ORD_AMT__c');
FIELD_MAPPING.put('PC_Return_Sales__c','PC_LDRSHP_RTURN_AMT__c');
            
  }
  public static Mobile_Sales_Org_Leadership__c createMobileData(Sales_Org_Leadership__c slsOrg){
    
    Mobile_Sales_Org_Leadership__c mblRec = new Mobile_Sales_Org_Leadership__c(
                            MRKT_ID_ZONE_CD_KEY__c=slsOrg.MRKT_ID_ZONE_CD_KEY__c,
                            Name=slsOrg.SLS_ORG_CD__c,
                            CurrencyIsoCode=slsOrg.CurrencyIsoCode);
    for(String key: FIELD_MAPPING.keySet()){
      mblRec.put(key,getFieldValue(FIELD_MAPPING.get(key),slsOrg));
    }
    return mblRec;
  }
  
  private static Decimal getFieldValue(String colFlds,SObject currRec){
    Decimal totVal = null;

    //System.debug('>>>>>>>>>>>>>>> colFlds'+colFlds);
    String tempFld;
    for(String fldName: colFlds.split(',')){
      tempFld = fldName.trim();
      if(currRec.get(tempFld)!=null){
        if(totVal==null){
          totVal=0.0;
        }
        totVal+=(Decimal)currRec.get(tempFld);
      }
    }
    return totVal;
  }

  public static testmethod void testMobileSlsOrgLdr(){
    TestDataHelper testData = new TestDataHelper();
    String zone = 'XZ1';
    User zoneUsr = testData.createZoneUser('XZ1');
    List<Sales_Org_Leadership__c> slsLdrList = testData.createSlsLdrActivity(zoneUsr, 'Avon Zone Manager',zoneUsr.Id);
    List<Mobile_Sales_Org_Leadership__c> mobileRecs= [  select Id,Name 
                              from Mobile_Sales_Org_Leadership__c 
                              where MRKT_ID_ZONE_CD_KEY__c=:slsLdrList[0].MRKT_ID_ZONE_CD_KEY__c];
    System.assert(mobileRecs.size()==1);
  }  
}
			                            	