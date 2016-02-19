public class StudentAndClassDetails {   
    /**
* Function which take classid as argument and returns all names of the students in
that class as a list.
*/ 
    public static List<Student__c> getStudentDetailByClassId(String classId){
        if(classId!=''){
            List<Student__C> studentList = [Select id,name from Student__c where class__r.id = :classId];
            return studentList;
        }
        else
            return null;
    }
    /**
* Function which returns a map where key is class and value is set of studentid in it.
*/ 
    public static Map<Class__c, Set<Student__c>> getStudentsByClass(){
        Map<Class__c,Set<Student__c>> studentsByClass  = new Map<Class__c,Set<Student__c>>();
        for (Student__C student :  [Select id,name, class__r.id,class__r.name from Student__C]){
            if(!studentsByClass.containsKey(student.class__r)){
                Set<Student__c> studentSet = new Set<Student__c>();
                studentSet.add(student);
                studentsByClass .put(student.class__r, studentSet);
            }
            else{
                studentsByClass .get(student.Class__r).add(student);
            }
        }
        return studentsByClass ;
    }
    
    /**
*  Function which take 2 dates as argument and return number of working days between two days 
*  excluding both daysSaturday and Sunday is nonworking
*/
    public static Integer getNumberOfWorkingDays(Date date1, Date date2){
        Integer daysDifference = date1.daysBetween(date2);
        Integer numberOfWeeks = daysDifference/7;
        Integer extraDays = Math.mod(daysDifference,7);
        date1 = date1.addDays(numberOfWeeks*7);
        Integer numberOfWorkingDays =  (numberOfWeeks*5);
        Date referenceDate = Date.newInstance(1900, 1, 7);
        Integer noOfdays;
        Integer day;
        for(Integer i=1; i<=extraDays; i++){
            noOfdays = referenceDate.daysBetween(date1.addDays(i));
            day = Math.mod(noOfdays, 7); 
            if(day==1 || day==2 || day==3 ||day==4||day==5){ 
                numberOfWorkingDays++;
            } 
        }
        noOfdays = referenceDate.daysBetween(date1);
        day = Math.mod(noOfdays, 7); 
        if(day==1 || day==2 || day==3 ||day==4||day==5){ 
            numberOfWorkingDays++;
        } 
        return numberOfWorkingDays;      
    }
    
    /**
* Function which take ContactID as argument, their is a Custom field in Account
* Object(ContactIDs), it is comma separated of all related Contact IDs, check if it is Null or not:-
* IF Null, then fetch all related Account Contacts and store IDs of all Contacts in it.
* IF Not Null, then check Is Contact Id exist on this field, if not then append it on that field.
*/ 
    public static void appendRelatedContactIdsInAccount(String contactId){
        Contact contact = [Select id,account.id from contact where id=:contactId];
        Account account = [Select id,ContactIDs__c,(Select id from contacts) from account where id=:contact.accountId];
        String contactIds = '';
        Boolean contactAlreadyExists = false;
        if(account.ContactIDs__c==null){
            Integer i = 1;
            for(Contact accountRelatedContact : account.contacts){
                if(i==1){
                    contactIds = contactIds + accountRelatedContact.id;
                }
                else{
                    contactIds = contactIds + ',' + accountRelatedContact.id;
                }
                i++;
            }    
            System.debug(contactIds);
        }
        else{
            String[] contactIdArray = account.ContactIDs__c.split('\\,');
            for(Integer j=0; j<contactIdArray.size();j++){
                if(contactIdArray[j]==contact.id) {
                    contactAlreadyExists=True;
                    break;
                }
            }
            contactIds = account.ContactIDs__c;
            if(contactAlreadyExists == false){
                contactIds = contactIds+ ',' + contact.id;
            }
        }
        account.ContactIDs__c = contactIds;
        update account;
    }
}