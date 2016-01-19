public class OpportunityUpdateSchedule implements Schedulable{
    
    public static void execute(SchedulableContext  sc)
    {       
        DateTime todayDate = DateTime.Now();
        Datetime lastMonthDate = todayDate.addDays(-30) ;
        List<Id> targetIdList = new List<Id>();
        for(Opportunity opportunity : [Select id, Owner.id From Opportunity where LastModifiedDate > :lastMonthDate])
        {
   		    targetIdList.add(opportunity.Owner.id);
        }
        if(targetIdList.size()>0)
        {
        	SendEmail(targetIdList);
        }
    }
    
    public static void SendEmail(List<Id> targetIdList) 
    {
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        mail.setTargetObjectIds(targetIdList);
        mail.setTemplateID('00X28000000MVVR');
        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.MassEmailMessage[] {mail});   
	}
}
