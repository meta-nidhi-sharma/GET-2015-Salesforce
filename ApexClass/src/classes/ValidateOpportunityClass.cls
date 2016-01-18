public class ValidateOpportunityClass {
    public static void opportunityUpdateValidation(List<Opportunity> ol){
        for(Opportunity o : ol){
            if(o.BillToContact__c!=null && o.Manager__c==null){
                System.debug(o.BillToContact__c);
                Contact cc = [select id, name,Account.id from Contact where (id = :o.BillToContact__c AND account.id!=null)];
                o.Manager__c = cc.Account.id;
            }
        }     
    }  
}
