public with sharing class ManageClassController {

    public Class__c classToUpdate { get; private set; }
    public String idToUpdate {get;set;}
    public boolean displayPopup {get; set;} 
    
    String query = 'Select Id, Name, fee__c, board__c From Class__c ';
    
    public ManageClassController(ApexPages.StandardController controller) {
    }
    
    public void saveClass() {  
        update classToUpdate;
        displayPopup = false;    
    }  
    
    public void deleteClass() { 
        classToUpdate = [select id,name,fee__C from Class__c where id = :idToUpdate];
        delete classToUpdate;
    }  
    
    public void ShowDataToEdit() { 
        classToUpdate = [select id, name, fee__c,board__C from Class__c where id = :idToUpdate];
        displayPopup = true;    
    }   

    public List<Class__C> getfindClasses() 
    {
        return Database.query(query); 
    }  
}