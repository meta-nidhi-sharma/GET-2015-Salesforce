trigger OpportunityStatusChange on Opportunity (after update) {
    List<Id> addresses = new List<Id>();
    //Getting Id of email template
    Id emailTemplateId = [Select id,name from EmailTemplate where name 
                          ='Opportunity Status Update Email' and isActive = true Limit 1].Id; 
    //Getting Ids of those opportunity owners whose status is being updated
    for(Opportunity updatedOpportunity : Trigger.NEW){
        Opportunity oldOpportunity = Trigger.oldMap.get(updatedOpportunity.Id);
        if (oldOpportunity.status__c!=updatedOpportunity.status__c) {
            addresses.add(oldOpportunity.OwnerId);
        }
    }
    //To send email calling method 'sendEmail' of class 'OpportunityStatusAlert'
    if(addresses!=null && emailTemplateId!=null && addresses.size()>0){
        OpportunityStatusAlert opportunityStatusAlert = new OpportunityStatusAlert();
        opportunityStatusAlert.sendEmail(addresses, emailTemplateId);
    }
}
