trigger RestrictHindiTeacherEntry on Contact (before insert,before update) {
    for(Contact contactObject : Trigger.new)
    {
        if(contactObject.Subjects__c.Contains('Hindi'))
        {
            contactObject.addError('Hindi teacher Not allowed');
        }
    }
}