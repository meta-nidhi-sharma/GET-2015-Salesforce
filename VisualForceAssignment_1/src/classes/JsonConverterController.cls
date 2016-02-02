public class JsonConverterController
{    
    public String text {get;set;}
      
    public JsonConverterController()
    {
         parseJson();
    }    
    public void parseJson()
    {
        String soql = 'SELECT Name FROM Account LIMIT 5';
        List<Account> accounts = Database.Query(soql); 
        text = JSON.serialize(accounts);
    }    
}
