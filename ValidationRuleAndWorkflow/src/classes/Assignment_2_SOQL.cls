public class Assignment_2_SOQL {
    public static void SOQL(){
        List<Student__c> sl1 = [SELECT Name,DOB__c,Sex__c from Student__c where LastName__c like 'S%'];
      	List<Student__c> sl2 = [SELECT Name from Student__c where Class__r.Name like 'X%'];
        List<Student__c> sl3 = [Select Name,Class__r.Name from Student__c];
        List<Class__c> sl4 = [SELECT Id, Name,(SELECT Name FROM Students__r) FROM Class__c];
        List<Student__c> sl5 = [Select name,DOB__c,Sex__c from Student__C where Class__r.ClassTeacher__r.Name like 'N%'];
		List<Student__c> sl6 = [Select Name,DOB__c,Sex__c from Student__c where DOB__c > 2000-12-31];
        List<Lead> sl7 = [Select name From Lead where LastModifiedDate = THIS_MONTH];
		List<Class__c> sl8 = [SELECT Id, Name,(SELECT Name FROM Students__r where name like 'S%') FROM Class__c];
        List<Contact> sl9 = [Select firstName, LastName from Contact where Subjects__c INCLUDES ('Hindi;English')]; 
       	List<Student__C> sl10 = [Select firstName__c, LastName__c from Student__C where Class__r.ClassTeacher__r.Subjects__c INCLUDES ('Hindi','English')];
    }
}