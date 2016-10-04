public class PreviewEmailTemplateController {
  public EmailTemplate template {get; private set;}
  public String htmlValue {get; private set;}
  public PageReference init(){
    String templateId = System.currentPageReference().getParameters().get('templateId');
    template = [select Id,HtmlValue,markup from EmailTemplate where Id=:templateId];
    String temp = template.HtmlValue;
    temp = temp.replace('<![CDATA[','');
    temp = temp.replace(']]','');
    htmlValue =temp; 
    return null;
  }
  
  public static testmethod void testPreviewTemplate(){
    TestDataHelper testData = new TestDataHelper();
    EmailTemplate temp = testData.createEmailTemplate();
    PageReference pageRef = Page.PreviewTemplate;
    pageRef.getParameters().put('templateId',temp.Id);
    PreviewEmailTemplateController ctlr = new PreviewEmailTemplateController();
    Test.setCurrentPageReference(pageRef);
    ctlr.init();
    System.assert(ctlr.template.HtmlValue==temp.HtmlValue);  
  }
}
			                            	