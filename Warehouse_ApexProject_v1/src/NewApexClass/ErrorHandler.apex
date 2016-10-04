public class ErrorHandler {

  public static PageReference handleError(Exception ex){
    Error_Message__c err = new Error_Message__c(Page_Occurred__c='UNKNOWN',
                          Error_Message__c=ex.getMessage());
    
    
    String errorId =insertError(err);
    PageReference errPage = Page.ErrorPage;
    errPage.getParameters().put('errId',errorId);
    return errPage;
  }
  
  public static PageReference handleError(String srcPage,Exception ex){
    Error_Message__c err = new Error_Message__c(Page_Occurred__c=srcPage,
                          Error_Message__c=ex.getMessage());
    String errorId =insertError(err);
    PageReference errPage = Page.ErrorPage;
    errPage.getParameters().put('errId',errorId);
    return errPage;
  }
  
  private static String insertError(Error_Message__c errMsg){
    try{
      //insert errMsg;
      //return errMsg.Name;
      return 'UNKNOWN-ERROR';  
    }catch(Exception ex){
      System.debug('Not able to insert error record !!!!');
      return 'UNKNOWN-ERROR';
    } 
	finally
	{
	}
  }
  
  public static testmethod void testErrHandler(){
    try{
      List<String> tempList = new List<String>();
      System.debug(tempList[1]);
    }catch(Exception ex){
      PageReference pageRef = ErrorHandler.handleError(ex);
      System.debug('>>>>>>>>>>>>>>>>>>>'+pageRef.getUrl());
      pageRef = ErrorHandler.handleError('ErrorHandler',ex);
      System.debug('>>>>>>>>>>>>>>>>>>>'+pageRef.getUrl());      
    }
  } 
}
			                            	