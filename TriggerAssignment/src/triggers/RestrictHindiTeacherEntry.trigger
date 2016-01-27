trigger RestrictHindiTeacherEntry on Contact (after insert,after update) {
    for(Contact contact : Trigger.new)
    {
        if(contact.Subjects__c.Contains('Hindi'))
        {
            contact.addError('Hindi teacher Not allowed');
        }
    }
}
