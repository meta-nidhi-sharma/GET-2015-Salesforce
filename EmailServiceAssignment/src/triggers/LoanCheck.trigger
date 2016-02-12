trigger LoanCheck on Loan__c (after update) {
    List<Id> addresses = new List<Id>();
    //Getting Id of email template
    Id emailTemplateId = [Select id,name from EmailTemplate where name 
                          ='Loan Status Update Alert' and isActive = true Limit 1].Id; 
    //Getting Ids of those Loan applicants whose loan status is being updated to approved or rejected
    for(Loan__c updatedLoan : Trigger.NEW){
        Loan__c oldLoan = Trigger.oldMap.get(updatedLoan.Id);
        if (oldLoan.status__c!=updatedLoan.status__c && (updatedLoan.status__c=='Approved' || updatedLoan.status__c=='Rejected')){
            addresses.add(oldLoan.ownerId);
        }
    }
    //To send email calling method 'sendEmail' of class 'LoanStatusAlert'
    if(emailTemplateId!=null && addresses!=null && addresses.size()>0){
        LoanStatusAlert loanStatusAlert = new LoanStatusAlert();
        loanStatusAlert.sendEmail(addresses, emailTemplateId);
    }
}
