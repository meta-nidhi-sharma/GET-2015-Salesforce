public with sharing class OpportunityManagerController {

    public Opportunity opportunity{get;set;}
    public Id contactId{get;set;}
    
    public List<Contact> contactList{get;set;}
    
    public OpportunityManagerController(ApexPages.StandardController stdController) {
        this.opportunity = (Opportunity)stdController.getRecord();
        Opportunity opportunityObject=this.opportunity;
        this.contactList=[SELECT ID,Name FROM Contact where Contact.AccountID=:opportunityObject.Manager__c];
    }
    
    public List<SelectOption> getItems(){
        List<SelectOption> options=new List<SelectOption>();
        for(Contact contact:contactList)
            options.add(new SelectOption(contact.Id,contact.Name));
        return options;
    }
    
    public void setManager1(){
        System.debug('in set manager');
        Opportunity opportunityObject = this.opportunity;
        opportunityObject.BillToContact__c = this.contactId;
        update opportunityObject;
    }
    
    public void clearManager(){
        System.debug('in clear manager');
        Opportunity opportunityObject = this.opportunity;
        opportunityObject.BillToContact__c = null;
        update opportunityObject;
    }
}
