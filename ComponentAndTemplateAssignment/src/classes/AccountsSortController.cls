public class AccountsSortController {
    public String sortingColumn {get;set;}	//stores column name on which sorting is to apply
    public String sortType {get;set;}	//stores two values (ASC/DESC) to sort accounts in ascending or descending order
    public ApexPages.StandardSetController accountSetController {get; set;}	//StandardSetController to get records by query locator
    public String query;	//to get accounts from database
    public Integer totalpages{get;set;}	//total pages of records
    Integer recordsPerPage = 5;			//number of records on one page
   	//List of accounts to sort
    public List<Account> Accounts {
        get{
            return (List<Account>) accountSetController.getRecords();
        }set;
    }   
    //Controller
    public AccountsSortController(){ 
        sortingColumn = 'Name';
        sortType = 'ASC';
        retrieveAccounts();
    }
    //To retrieve accounts using query locator
    public void retrieveAccounts(){
        query = 'SELECT id,name,BillingCity FROM Account ';
        if(sortingColumn!=null && sortType != null){
            query += 'ORDER BY ' + sortingColumn  + ' ' + sortType+'';
            System.debug('Sort type ' + sortType + ' sort column ' + sortingColumn );
        }
        accountSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        accountSetController.setPageSize(recordsPerPage);
        totalPages = (accountSetController.getResultSize() / accountSetController.getPageSize());
        totalPages = Integer.valueOf(totalPages + ((Math.mod(accountSetController.getResultSize(), recordsPerPage)>0) ? 1 : 0));
    }
	//To sort accounts according to name or billingCity
    public void sort(){
        retrieveAccounts();
    }
}