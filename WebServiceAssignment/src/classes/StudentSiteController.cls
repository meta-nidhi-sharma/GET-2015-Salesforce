public class StudentSiteController {
   public static List<Student__c> students{ get; private set;}
   public static Student__c studentInfo{ get; set;}
   public StudentSiteController (){
   }
    
   public static  List<SelectOption> options { get{    
       students = new List<Student__c> ([SELECT Id,Name FROM Student__c]);
       options = new List<SelectOption> ();
       for(Student__c student : students) {
           options.add(new SelectOption(student.Id,student.Name));
       }
       return options;
   } set;}
   
   @RemoteAction
   public static Student__c getStudent( Id selectedId ){
       studentInfo = [SELECT Id, FirstName__c, LastName__c, Class__r.Name  FROM Student__c WHERE Id =:selectedId] ;
       return studentInfo ;
   }  
}
