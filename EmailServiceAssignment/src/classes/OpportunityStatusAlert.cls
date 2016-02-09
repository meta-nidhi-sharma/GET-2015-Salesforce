/*
 * To send email to opportunity owner whose status is updated
 */ 
public class OpportunityStatusAlert {
    //Sending email of given emailTemplateid to specified target Ids
    public void sendEmail(List<Id> targetIds, Id emailTemplateId) {
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        mail.setTargetObjectIds(targetIds);
        mail.setTemplateID(emailTemplateId);
        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.MassEmailMessage[] {mail});
    }
}