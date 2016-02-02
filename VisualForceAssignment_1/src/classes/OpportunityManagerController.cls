public with sharing class OpportunityManagerController {

    public Opportunity opportunity{get;set;}
    public Id contactId{get;set;}
    public List<Contact> contactList{get;set;}
    
    public OpportunityManagerController(ApexPages.StandardController stdController) {
        this.opportunity = (Opportunity)stdController.getRecord();
        this.contactList=[SELECT Id, Name FROM Contact where Contact.AccountID=:opportunity.Manager__c];
    }
    
    public List<SelectOption> getItems(){
        List<SelectOption> options=new List<SelectOption>();
        for(Contact contact : contactList)
            options.add(new SelectOption(contact.Id,contact.Name));
        return options;
    }
    
    public void setManager(){
        update opportunity;
    }
    
    public void removeManager(){
        opportunity.BillToContact__c = null;
        update opportunity;
    }
}
