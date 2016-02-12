/*
* If Loan status is changed to approved or rejected, sending mail to applicant
*/ 
public class LoanStatusAlert {
    //Sending email of given emailTemplateid to specified target Ids
    public void sendEmail(List<Id> targetIds, Id emailTemplateId) {
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        mail.setTargetObjectIds(targetIds);
        mail.setTemplateID(emailTemplateId);
        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.MassEmailMessage[] {mail});
    }
}