public class OpportunityManagement {
    public static void PopoulateManagerForOpportunity(List<Opportunity> opportunities)
    {
        for(Opportunity opportunity : opportunities)
        {
            if(opportunity.BillToContact__c!=null 
               && opportunity.Manager__c==null)
            {
                Contact contact = [select id, name, Account.id from Contact where id = :opportunity.BillToContact__c];
                opportunity.Manager__c = contact.Account.id;
            }
        }     
    }  
}
