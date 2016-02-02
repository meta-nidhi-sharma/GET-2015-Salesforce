public class AccountSearchController {
    public string billingCity{get;set;}
    public string billingState{get;set;}
    public string billingCountry{get;set;}
    public Integer totalPages { get; set; }  
    public Boolean DisplayAccounts{get;set;}
    public ApexPages.StandardSetController accountsSetController { get; set; }
    Decimal dtotalPages;
    Integer iRecordsPerPage = 5; 
    
    public AccountSearchController(){
        accounts = new List<Account>();
       	accountsSetController = new ApexPages.StandardSetController(Database.getQueryLocator([Select id,name,billingcity,billingCountry,billingState from account]));
        accountsSetController.setPageSize(iRecordsPerPage);
        dtotalPages = (accountsSetController.getResultSize() / accountsSetController.getPageSize());
        dtotalPages = Math.floor(dtotalPages) + ((Math.mod(accountsSetController.getResultSize(), iRecordsPerPage)>0) ? 1 : 0);
        totalPages = Integer.valueOf(dtotalPages);
    }
    public List<Account> Accounts {
        get{
            return (List<Account>) accountsSetController.getRecords();
        }set;
    }
    
    public void searchRecords () {
        string Query = 'SELECT id,name,billingcity,billingCountry,billingState FROM Account where ';
        if(string.isBlank(billingCity)  && string.isBlank(billingState) && string.isBlank(billingCountry)){
            Query = 'SELECT id,name,billingcity,billingCountry,billingState FROM Account';
        }    
        if(!(string.isBlank(billingCity))){
            
            Query = Query + 'billingcity LIKE \'%'+billingCity+'%\' AND ';
        }
        if(!(string.isBlank(billingCountry))){
            
            Query = Query + ' billingcountry  LIKE  \'%'+billingCountry+'%\' AND ';
        }
        if(!(string.isBlank(billingState))){
            
            Query = Query +  ' billingstate LIKE  \'%'+billingState+'%\' AND ';
        }
        if(Query.substring(Query.length()-4,Query.length()).equals('AND ')){
            
            Query= Query.substring(0,Query.length()-4);
        }
        accountsSetController = null;
        accountsSetController = new ApexPages.StandardSetController(Database.getQueryLocator(Query));
        accountsSetController.setPageSize(iRecordsPerPage);
        dtotalPages = (accountsSetController.getResultSize() / accountsSetController.getPageSize());
        dtotalPages = Math.floor(dtotalPages) + ((Math.mod(accountsSetController.getResultSize(), iRecordsPerPage)>0) ? 1 : 0);
        totalPages = Integer.valueOf(dtotalPages);
    }
}
