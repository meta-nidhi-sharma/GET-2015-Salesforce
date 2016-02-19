@isTest
private class TestOpportunityTrigger {
    @testSetup
    public static void setUpMethod(){
        Account testAccount = new Account(name='TestAccount') ;
        insert testAccount;
        Contact testContact = new Contact(AccountId=testAccount.Id,lastname='Sharma',firstname='Nidhi',Subjects__c='English');
        insert testContact;
        Opportunity testOpportunity = new Opportunity(Name='TestOpportunity',StageName='Prospecting',CloseDate=System.today().addMonths(1));
        insert testOpportunity;
    }
    @isTest
    static void testPopulateManagerForOpportunity(){
        Test.startTest();
        Opportunity testOpportunity = [Select name from Opportunity where name='TestOpportunity'];
        testOpportunity.BillToContact__c = [Select id from Contact where (firstname='Nidhi' AND lastname='Sharma')].Id;
        Update testOpportunity;
        testOpportunity = [Select name,Manager__c from Opportunity where name='TestOpportunity'];
        Account expectedAccount = [Select name from Account where name='TestAccount'];
        System.assertEquals(expectedAccount.Id, testOpportunity.Manager__c);
        Test.stopTest();
    }
}