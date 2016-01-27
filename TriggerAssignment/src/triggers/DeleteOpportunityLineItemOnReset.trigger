trigger DeleteOpportunityLineItemOnReset on Opportunity (after update) {
		Set<Id> setOpporutnityId = new Set<Id>();
		for (Opportunity objOpportunity:Trigger.New) {
			if (objOpportunity.Custom_Status__c != null && objOpportunity.Custom_Status__c == 'Reset' && objOpportunity.Custom_Status__c != Trigger.OldMap.get(objOpportunity.Id).Custom_Status__c) {
				setOpporutnityId.Add(objOpportunity.id);
			}
		}
        if (setOpporutnityId != null && setOpporutnityId.size() > 0) {
            List<OpportunityLineItem> opportunityLineItemList = [select id from OpportunityLineItem where Opportunity.Id IN :setOpporutnityId];
            Database.delete(opportunityLineItemList);
        }
}
