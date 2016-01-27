trigger DeleteOpportunityLineItemOnReset on Opportunity (after update) {
		Set<Id> opportunityIds = new Set<Id>();
		for (Opportunity objOpportunity:Trigger.New) {
			if (objOpportunity.Custom_Status__c != null && objOpportunity.Custom_Status__c == 'Reset' && objOpportunity.Custom_Status__c != Trigger.OldMap.get(objOpportunity.Id).Custom_Status__c) {
				opportunityIds.Add(objOpportunity.id);
			}
		}
        if (opportunityIds != null && opportunityIds.size() > 0) {
            List<OpportunityLineItem> opportunityLineItemList = [select id from OpportunityLineItem where Opportunity.Id IN :opportunityIds];
            Database.delete(opportunityLineItemList);
        }
}
