/*
 * @Author : Nidhi Sharma
 * Date : 9 feb, 2016
 * Description : To fetch 10 accounts from database and apply dml update while counting percentage of dmls executed out of allowed limits  
 */ 
public class GovernorLimitCountController {
    public List<Account> accounts {get;set;}
    public Boolean queryResultBlock {get;set;}
    public Boolean searchRecordsButtonPopUp {get;set;}
    public Decimal consumedQueries {get;set;}
    public Decimal queryLimits {get;set;}
    public Decimal percentageConsumedQueries {get;set;}
    //Controller
    public GovernorLimitCountController(){
        queryResultBlock = false;
        searchRecordsButtonPopUp = true;
    }
    //To fetch accounts from database
    public void fetchAccounts(){
        searchRecordsButtonPopUp = false;
        string query = 'SELECT id,name FROM Account Limit 10';
        accounts = Database.query(query);
        if(accounts==null || accounts.size()<=0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No records found'));
        }
    }
    //Updating list of accounts and counting number of dmls executed
    public void updateAccounts(){
        queryResultBlock = true;
        Update accounts[0];
        consumedQueries = limits.getDMLStatements();
        queryLimits = limits.getLimitDMLStatements();
        percentageConsumedQueries = ((consumedQueries*100)/queryLimits).setScale(4);
    }
}