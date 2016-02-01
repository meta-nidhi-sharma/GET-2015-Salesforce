trigger RestrictHindiTeacherEntry on Contact (before insert,before update) {
    for(Contact contactObject : Trigger.new)
    {
        try{
            if(contactObject.Subjects__c.Contains('Hindi')){
                contactObject.addError('Hindi teacher Not allowed');
            }
        }
        catch(NullPointerException e){
            contactObject.addError('Select at least one subject');
        }
    }
}
