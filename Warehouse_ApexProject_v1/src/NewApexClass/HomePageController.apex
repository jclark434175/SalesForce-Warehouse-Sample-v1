public class HomePageController {

  public PageReference init(){
    Profile usrProfile = [  select   Id,Name
                from  Profile
                where  Id=:UserInfo.getProfileId()
              ];
    PageReference landingPage;
    if(usrProfile.Name == 'Avon Leader'){
      landingPage = Page.MyBusiness;
      landingPage.getParameters().put('pgId','1');
    }
    if(usrProfile.Name == 'Avon Zone Manager'){
      landingPage = Page.SalesOrgActivity;
      landingPage.getParameters().put('pgId','8');
    }
    if(usrProfile.Name == 'Avon Division Manager'){
      landingPage = Page.SalesOrgActivity;
      landingPage.getParameters().put('pgId','8');
    }
    return landingPage;
  }
  
  public static testmethod void testHomePage(){
    HomePageController ctlr = new HomePageController();
    String mktIdKey = 'TEST123456';
    TestDataHelper testData = new TestDataHelper();
    User testUsr = testData.createLeaderUser(mktIdKey);
    User zoneUsr = testData.createZoneUser('Z'+mktIdKey);
    User divUsr = testData.createDivUser('D'+mktIdKey);
    System.runAs(testUsr){
      PageReference pageRef = ctlr.init();
      System.debug('&&&&&&&&&&&&&&&&&& '+pageRef.getUrl());
      System.assert(pageRef.getUrl()=='/apex/mybusiness?pgId=1');  
    }
    System.runAs(zoneUsr){
      PageReference pageRef = ctlr.init();
      System.debug('&&&&&&&&&&&&&&&&&& '+pageRef.getUrl());
      System.assert(pageRef.getUrl()=='/apex/SalesOrgActivity?pgId=8');  
    }
    System.runAs(divUsr){
      PageReference pageRef = ctlr.init();
      System.debug('&&&&&&&&&&&&&&&&&& '+pageRef.getUrl());
      System.assert(pageRef.getUrl()=='/apex/SalesOrgActivity?pgId=8');  
    }
      
  }
}
			                            	