trigger OpportunityTrigger on Opportunity (before update) {
    List<Opportunity> ol = new List<Opportunity>();
    for(Opportunity o  : Trigger.New){
        ol.add(o);
    }
    ValidateOpportunityClass.opportunityUpdateValidation(ol);
}
