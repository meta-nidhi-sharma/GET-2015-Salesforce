public class SearchRecords {
    // For the city
    public string getBillingCitystring{get;set;}
    // For the State
    public string getBillingStatestring{get;set;}
    // For the Country
    public string getBillingCountrystring{get;set;}
    // To store the Account
    public List<Account> createAccountList{get;set;}
    // To store the Total Records
    private integer totalRecs = 0;
    // To store the offset Size
    private integer OffsetSize = 0;
    // For the Limit Size
    private integer LimitSize = 10;
    
    public void searchRecords(){
        createAccountList= new list<Account>();
        totalRecs = [select count() from account];
        string Query = 'SELECT id,name,billingcity,billingCountry,billingState FROM Account where ';
        if(string.isBlank(getBillingCitystring)  && string.isBlank(getBillingStatestring) && string.isBlank(getBillingCountrystring)) 
        {
            Query = 'SELECT id,name,billingcity,billingCountry,billingState FROM Account';
        }    
        if(!(string.isBlank(getBillingCitystring)))
        {
            Query = Query + 'billingcity LIKE \'%'+getBillingCitystring+'%\' AND ';
            
        }
        if(!(string.isBlank(getBillingCountrystring)))
        {
            Query = Query + ' billingcountry  LIKE  \'%'+getBillingCountrystring+'%\' AND ';
        }
        if(!(string.isBlank(getBillingStatestring)))
        {
            Query = Query +  ' billingstate LIKE  \'%'+getBillingStatestring+'%\' AND ';
        }
        if(Query.substring(Query.length()-4,Query.length()).equals('AND '))
        {
            Query= Query.substring(0,Query.length()-4);
        }
        Query = Query +  ' LIMIT ' + LimitSize + ' OFFSET ' + OffsetSize;
        createAccountList= Database.query(Query);                  
    }
    
    
    public void FirstPage() {
        OffsetSize = 0;
        searchRecords();
    }
    
    public void previous() {
        OffsetSize = OffsetSize - LimitSize;
        searchRecords();
    }
    
    public void next() {
        OffsetSize = OffsetSize + LimitSize;
        searchRecords();
    }
    
    public void LastPage() {
        OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
        searchRecords();
    }
    
    public boolean getprev() {
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxt() {
        if((OffsetSize + LimitSize) > totalRecs)
            return true;
        else
            return false;
    }
}