public with sharing class AttachPdf {
    
    public String alreadySet;
    private Student__c student;
    public AttachPdf(ApexPages.StandardController controller) {
        student = (Student__c)controller.getRecord();
        alreadySet = System.currentPageReference().getParameters().get('check');
    }
    public void savePdf(){
        PageReference pdf = Page.GeneratePDF;
        pdf.getParameters().put('id',student.Id);
        pdf.getParameters().put('check','YES');
        Attachment attach = new Attachment();    
        Blob body;
        if(alreadySet != 'YES'){
            try {
                body = pdf.getContent();
            } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
            }
            attach.Body = body;
            attach.Name = student.Name+'.pdf';
            attach.IsPrivate = false;
            attach.ParentId= student.Id;
            List<Attachment> att1 = [select id, name from Attachment where parent.id =: student.Id];
            if(att1.size()>0){
                Delete att1;
            }
            insert attach;
        }
    }
}
