public class ClassDetails {
    
    /**
     * Function which take classid as argument and returns all names of the students in
that class as a list.
     */ 
    public static List<Student__c> getClassDetails(String classId){
       List<Student__C> studentList = new List<Student__C>();
        studentList = [Select name from Student__c where class__r.id = :classId];
        return studentList;
    }
    
    /**
     * Function which returns a map where key is class and value is set of studentid in it.
     */ 
    public static Map<Class__c, List<Student__c>> getMapOfClassAndStudent(){
        Map<Class__c,List<Student__c>> classMap = new Map<Class__c,List<Student__c>>();
        List<Student__c> studentList = new List<Student__c>();
        for(Class__c classes : [Select id, name, board__c from Class__C]){
           studentList = [Select id from Student__c where class__r.id = :classes.id];
            classMap.put(classes, studentList);
        }
        return classmap;
    }
    
    /**
     *  Function which take 2 dates as argument and return number of working days between two days 
	 *  excluding both daysSaturday and Sunday is nonworking
     */
    public static Integer numberOfWorkingDays(Date date1, Date date2){
        Integer daysDifference = date1.daysBetween(date2);
        Integer numberOfWeeks = daysDifference/7;
        Integer extraDays = Math.mod(daysDifference,7);
        date1 = date1.addDays(numberOfWeeks*7);
        Integer numberOfWorkingDays =  (numberOfWeeks*5);
        for(Integer i=1; i<=extraDays; i++){
             Date d = Date.newInstance(1900, 1, 7);
        Integer noOfdays = d.daysBetween(date1.addDays(i));
      	Integer day = Math.mod(noOfdays, 7); 
            if(day==1 || day==2 || day==3 ||day==4||day==5){ 
                numberOfWorkingDays++;
            } 
        }
        System.debug(numberOfWorkingDays);
         return numberOfWorkingDays;      
    }
    
    /**
     * Function which take ContactID as argument, their is a Custom field in Account
	 * Object(ContactIDs), it is comma separated of all related Contact IDs, check if it is Null or not:-
	 * IF Null, then fetch all related Account Contacts and store IDs of all Contacts in it.
	 * IF Not Null, then check Is Contact Id exist on this field, if not then append it on that field.
     */ 
     public static void insertContactIDs(String cid){

        Contact cc = [Select id,account.id from contact where id=:cid];
         Account a = [Select id,ContactIDs__c from account where id=:cc.account.id];
          String contactIds = '';
         Boolean flag = false;
        if(a.ContactIDs__c==null){
        List<Contact> cl = [Select id from contact where account.id=:cc.account.id];
            Integer i = 1;
        for(Contact c : cl){
            if(i==1){
                  contactIds = contactIds + c.id;
            }
            else{
                  contactIds = contactIds + ','+c.id;
            }
            i++;
       	 }    
        }
         else{
             String[] arrTest = a.ContactIDs__c.split('\\,');
             for(Integer j=0; j<arrTest.size();j++){
                 if(arrTest[j]==cc.id){
                     flag=True;
                     break;
                 }
             }
                contactIds = a.ContactIDs__c;
            }
        if(flag==false){
             contactIds = contactIds+','+cc.id;
        }
            a.ContactIDs__c = contactIds;
            update a;
    }
}
