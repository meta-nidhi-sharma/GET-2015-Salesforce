public class ClassDetails {
    public static List<Student__c> getClassDetails(String classId){
       List<Student__C> studentList = new List<Student__C>();
        studentList = [Select name from Student__c where class__r.id = :classId];
        return studentList;
    }
    
    public static Map<Class__c, List<Student__c>> getMapOfClassAndStudent(){
        Map<Class__c,List<Student__c>> classMap = new Map<Class__c,List<Student__c>>();
        List<Student__c> studentList = new List<Student__c>();
        for(Class__c classes : [Select id, name, board__c from Class__C]){
           studentList = [Select id from Student__c where class__r.id = :classes.id];
            classMap.put(classes, studentList);
        }
        return classmap;
    }
    
    public static Integer numberOfWorkingDays(Date date1, Date date2){
        /*Date d = Date.newInstance(1900, 1, 7);
        Integer noOfdays = d.daysBetween(date1);
      	Integer day = Math.mod(noOfdays, 7);*/
        Integer dd = date1.daysBetween(date2);
        Integer nw = dd/7;
        Integer ed = Math.mod(dd,7);
        Integer addDay = nw*7;
        date1 = date1.addDays(addDay);
        
        for(Integer i=1; i<=ed; i++){
             Date d = Date.newInstance(1900, 1, 7);
        Integer noOfdays = d.daysBetween(date1.addDays(i));
      	Integer day = Math.mod(noOfdays, 7); 
            if(day==1 || day==2 || day==3 ||day==4||day==5){ 
                addDay++;
            } 
        }
         return addDay;      
    }
    
     public static void insertContactId(String contactId){
     	Contact c = [select Account.id,Account.ContactIDs__c from Contact where id = :contactId];
         String value = '';
         if(c.Account.ContactIDs__c != null){
             
         }else{
             for(Contact cl : [Select id from Contact where Account.id = :c.AccountId]){
                 value+=cl.id+',';
             }
         }
         Account a1 = new Account();
         a1.name='n';
        
         System.debug(value);
         a1.ContactIDs__c = value;
         insert a1;
     }
}