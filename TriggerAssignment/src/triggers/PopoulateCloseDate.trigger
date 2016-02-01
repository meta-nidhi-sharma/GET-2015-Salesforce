trigger PopoulateCloseDate on Opportunity (before update) {
    List<opportunity> opportunityList;
    for(Opportunity opportunityObject : Trigger.New){
        if(opportunityObject.stageName =='Closed Won' || opportunityObject.StageName=='Closed Lost'){
            opportunityObject.CloseDate = Date.today();
        }
    }
}