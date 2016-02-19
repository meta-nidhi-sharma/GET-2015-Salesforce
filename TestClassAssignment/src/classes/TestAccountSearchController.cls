@isTest
private class TestAccountSearchController {
    static Account testAccount1;
    static Account testAccount2;
    static Account testAccount3;
    static Account testAccount4;
    static Account testAccount5;
    static Account testAccount6;
    static List<Account> accounts;
    @testSetup
    public static void setupMethod(){
        testAccount1 = new Account(Name='Account1',BillingCity='Jodhpur',BillingState='Rajasthan',BillingCountry='India');
        testAccount2 = new Account(Name='Account2',BillingCity='Jaipur',BillingState='Rajasthan',BillingCountry='India');
        testAccount3 = new Account(Name='Account3',BillingCity='Jaipur',BillingState='Rajasthan',BillingCountry='India');
        testAccount4 = new Account(Name='Account4',BillingCity='Mumbai',BillingState='Maharastra',BillingCountry='India');
        testAccount5 = new Account(Name='Account5',BillingCity='Mumbai',BillingState='Maharastra',BillingCountry='India');
        testAccount6 = new Account(Name='Account6',BillingCity='Mumbai',BillingState='Maharastra',BillingCountry='India');
        accounts = new List<Account>{testAccount1,testAccount2,testAccount3,testAccount4,testAccount5,testAccount6};
            insert accounts;
    }
    @isTest
    public static void testAccountSearchController_retrieveAccounts_retrieved(){
        AccountSearchController controller = new AccountSearchController();
        System.assertEquals(6,controller.accountsSetController.getResultSize());
    }
    @isTest
    public static void testGetAccounts_retrieveAccountsPerPage_retrievedAccounts(){
        AccountSearchController controller = new AccountSearchController();
        System.assertEquals(2,controller.accounts.size());
    }
    @isTest
    public static void testSearchRecords_retrieveAccountsWithoutAddressSpecified_retrievedAllAccounts(){
        AccountSearchController controller = new AccountSearchController();
        controller.searchRecords();
        System.assertEquals(6,controller.accountsSetController.getResultSize());
    }
    @isTest
    public static void testSearchRecords_retrieveAccountsWithSpecifiedBillingCity_retrievedAccounts(){
        AccountSearchController controller = new AccountSearchController();
        controller.billingCity = 'Jodhpur';
        controller.searchRecords();
        System.assertEquals(1,controller.accountsSetController.getResultSize());
        controller.billingCity = 'Jaipur';
        controller.searchRecords();
        System.assertEquals(2,controller.accountsSetController.getResultSize());
        controller.billingCity = 'Mumbai';
        controller.searchRecords();
        System.assertEquals(3,controller.accountsSetController.getResultSize());
    }
    @isTest
    public static void testSearchRecords_retrieveAccountsWithSpecifiedBillingState_retrievedAccounts(){
        AccountSearchController controller = new AccountSearchController();
        controller.billingState = 'Maharastra';
        controller.searchRecords();
        System.assertEquals(3,controller.accountsSetController.getResultSize());
        controller.billingCity = 'Jodhpur';
        controller.billingState = 'Rajasthan';
        controller.searchRecords();
        System.assertEquals(1,controller.accountsSetController.getResultSize());
    }
    @isTest
    public static void testSearchRecords_retrieveAccountsWithSpecifiedBillingCountry_retrievedAccounts(){
        AccountSearchController controller = new AccountSearchController();
        controller.billingCountry = 'India';
        controller.searchRecords();
        System.assertEquals(6,controller.accountsSetController.getResultSize());
        controller.billingCity = 'Jaipur';
        controller.billingState = 'Rajasthan';
        controller.billingCountry = 'India';
        controller.searchRecords();
        System.assertEquals(2,controller.accountsSetController.getResultSize());
        controller.billingState = 'Rajasthan';
        controller.billingCountry = 'NewYork';
        controller.searchRecords();
        System.assertEquals(0,controller.accountsSetController.getResultSize());
    }
}