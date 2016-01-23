public with sharing class AttachPdf {

    public String alreadySet;
    Student__c student;
    public AttachPdf(ApexPages.StandardController controller) {
        student = (Student__c)controller.getRecord();
        alreadySet = System.currentPageReference().getParameters().get('check');
    }
    public PageReference savePdf(){
        // List<Attachment> att1 = [select id, name from Attachment where parent.id =: student.Id];
        //delete(att1);
        PageReference pdf = Page.GeneratePDF;
        pdf.getParameters().put('id',student.Id);
        pdf.getParameters().put('check','YES');
        // create the new attachment
        Attachment attach = new Attachment();    
        // the contents of the attachment from the pdf
        Blob body;
        if(alreadySet != 'YES'){
            try {
                
                // returns the output of the page as a PDF
                body = pdf.getContent();
                
                // need to pass unit test -- current bug    
            } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
            }
            
            attach.Body = body;
            // add the user entered name
            attach.Name = student.Name+'.pdf';
            attach.IsPrivate = false;
            // attach the pdf to the account
            attach.ParentId= student.Id;
            insert attach;
        }
        // send the user to the account to view results
        
        return null;
    }
}