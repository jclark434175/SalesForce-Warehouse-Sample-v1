public class MarketTagUtils {
    private Map<String,String> mktTags = new Map<String,String>();
    

    public void initialize(List<String> subjAreas){
        User  currUsr = [select MRKT_ID__c,LanguageLocaleKey from User 
                         where Id=:UserInfo.getUserId()];
        for(Market_Tag_Label__c mktLabel:[  Select  Tag_Name__c, Tag_Label__c, 
                                                    Subject_Area__c, Language__c 
                                             From   Market_Tag_Label__c
                                             where  Subject_Area__c IN :subjAreas
                                             and    Language__c=:currUsr.LanguageLocaleKey
                                             and  Market__r.Market_Id__c=:currUsr.MRKT_ID__c])
        {
            mktTags.put(mktLabel.Subject_Area__c+'_'+mktLabel.Tag_Name__c,mktLabel.Tag_Label__c);                                   
        }
    }       

    public void initialize(List<String> subjAreas,String mrktId,String usrLangCd){
        for(Market_Tag_Label__c mktLabel:[  Select  Tag_Name__c, Tag_Label__c, 
                                                    Subject_Area__c, Language__c 
                                             From   Market_Tag_Label__c
                                             where  Subject_Area__c IN :subjAreas
                                             and  Market__r.Market_Id__c=:mrktId
                                             and    Language__c=:usrLangCd])
        {
            mktTags.put(mktLabel.Subject_Area__c+'_'+mktLabel.Tag_Name__c,mktLabel.Tag_Label__c);                                   
        }
        System.debug('>>>>>>>>>>>>>>>>>> Market Tags:'+this.mktTags);       
    }       
    public void initialize(List<String> subjAreas,String usrLangCd){
        for(Market_Tag_Label__c mktLabel:[  Select  Tag_Name__c, Tag_Label__c, 
                                                    Subject_Area__c, Language__c 
                                             From   Market_Tag_Label__c
                                             where  Subject_Area__c IN :subjAreas
                                             and    Language__c=:usrLangCd])
        {
            mktTags.put(mktLabel.Subject_Area__c+'_'+mktLabel.Tag_Name__c,mktLabel.Tag_Label__c);                                   
        }
        System.debug('>>>>>>>>>>>>>>>>>> Market Tags:'+this.mktTags);       
    }       
    public String getLabel(String tagName){
        return mktTags.get(tagName);    
    }
    public String getLabel(String subjArea,String tagName){
        if(mktTags.containsKey(subjArea+'_'+tagName)){
            return getLabel(subjArea+'_'+tagName);
        }else{
            return 'Mkt-Tag '+tagName;
        }   
    }
    
    public String getLabel(String subjArea,String tagName,String defaultVal){
        if(mktTags.containsKey(subjArea+'_'+tagName)){
            return getLabel(subjArea+'_'+tagName);
        }else{
            return defaultVal;
        }   
    }
    
    public static testmethod void testMarketTagUtils(){
    MarketTagUtils ctlr = new MarketTagUtils();
    String mktIdKey = 'TEST123456';
    TestDataHelper testData = new TestDataHelper();
    List<String> subjAreas = new List<String>();
    subjAreas.add('Ldr-My Business');
    subjAreas.add('Ldr-Downline Performance');
    testData.createMarketTags(subjAreas);
    User testUsr = testData.createLeaderUser('123456');
    System.runAs(testUsr){
      ctlr.initialize(subjAreas);
      ctlr.initialize(subjAreas,testData.market.Market_Id__c,testUsr.LanguageLocaleKey);
      System.debug('Label:'+ctlr.getLabel('Ldr-My Business','Market Tag 1'));
      System.assert(ctlr.getLabel('Ldr-My Business','Market Tag 1')=='Market Tag 1');
      System.debug('Label:'+ctlr.getLabel('Ldr-My Business','Market Tag 4','Something'));
      System.assert(ctlr.getLabel('Ldr-My Business','Market Tag 4','Something')=='Something');
    }
      
    }
    
}
			                            	