trigger OpportunityTrigger on Opportunity (before update) {
    List<Opportunity> opportunities = new List<Opportunity>();
    for(Opportunity opportunity  : Trigger.New){
        opportunities.add(opportunity);
    }
    OpportunityManagement.populateManagerForOpportunity(opportunities);
}