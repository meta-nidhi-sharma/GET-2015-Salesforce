@isTest(SeeAllData=false)
private class TestStudentAndClassDetails {
     @testSetup
    public static void setUpMethod(){
        Class__c testClass1 = new Class__c(name='XI') ;
        insert testClass1;
        List<Student__c> testStudents1 = new List<Student__c>();
        for(Integer i=0; i<3; i++){
            Student__c testStudent = new Student__c(Class__c=testClass1.Id, firstname__c='testFName1'+i, lastname__c='testLName1'+i);
            testStudents1.add(testStudent);
        }
        insert testStudents1;
        Class__c testClass2 = new Class__c(name='XII') ;
        insert testClass2;
        List<Student__c> testStudents2 = new List<Student__c>();
        for(Integer i=0; i<3; i++){
            Student__c testStudent = new Student__c(Class__c=testClass2.Id, firstname__c='testFName2'+1, lastname__c='testLName2'+i);
            testStudents2.add(testStudent);
        }
        insert testStudents2;
        Account testAccount = new Account(name='test1') ;
       insert testAccount;
       List<Contact> contacts = new List<Contact>();
       for(Integer i=0;i < 3;i++){
           Contact testContact = new Contact(AccountId=testAccount.Id,lastname='FName'+i,firstname='LName'+i,Subjects__c='English');
           contacts.add(testContact);
       }
       insert contacts;
    }
    
    @isTest
    static void testGetStudentDetailByClassId1(){
        Test.startTest();
        List<Student__c> expectedStudents = [Select name From Student__c where class__r.id = :[Select id from Class__c where name='XI']];
        Id classId = [Select id from Class__c where name = 'XI'].Id;
        List<Student__C> actualStudents = StudentAndClassDetails.getStudentDetailByClassId(classId);
        System.assertEquals(expectedStudents.size(), actualStudents.size());
        Test.stopTest();
    }
    
    @isTest
    static void testGetStudentDetailByClassId2(){
        List<Student__C> actualStudents = StudentAndClassDetails.getStudentDetailByClassId('');
        System.assertEquals(null, actualStudents);
    }
    
    @isTest
    static void testGetStudentsByClass1(){
        Map<Class__c, Set<Student__c>> expectedStudentsByClass = new Map<Class__c, Set<Student__c>>();
        Test.startTest();
        for (Student__C student :  [Select id,name, class__r.id,class__r.name from Student__c]){
            if(!expectedStudentsByClass.containsKey(student.class__r)){
                Set<Student__c> students = new Set<Student__c>();
                students.add(student);
                expectedStudentsByClass.put(student.class__r, students);
            }
            else{
                expectedStudentsByClass.get(student.Class__r).add(student);
            }
        }
        Map<Class__c, Set<Student__c>> actualStudentsByClass = StudentAndClassDetails.getStudentsByClass();
        System.assertEquals(expectedStudentsByClass.keySet(), actualStudentsByClass.keySet());
        Test.stopTest();
    }
    
    @isTest
    static void testGetNumberOfWorkingDays1(){
        Date date1 = Date.newinstance(2016, 2, 12);    
        Date date2 = Date.newinstance(2016, 3, 21);  
        Integer actual = StudentAndClassDetails.getNumberOfWorkingDays(date1, date2);
        System.assertEquals(27, actual);
    }
    
    @isTest
    static void testGetNumberOfWorkingDays2(){
        Date date1 = Date.newinstance(2016, 2, 13);    
        Date date2 = Date.newinstance(2016, 2, 21);    
        Integer expected = 5;
        Integer actual = StudentAndClassDetails.getNumberOfWorkingDays(date1, date2);
        System.assertEquals(expected, actual);
    }
    
   @isTest
   static void testAppendRelatedContactIdsInAccount1(){
       String expected = '';
       test.startTest();
       List<Contact> contacts = [Select id from Contact];
       String testcontactId = contacts[0].id;
       for(Contact contact : contacts){
           if(!expected.equals('')){
               expected +=',';
           }
           expected +=contact.Id;
       }  
       StudentAndClassDetails.appendRelatedContactIdsInAccount(testcontactId);
       Account account = [Select id,ContactIDs__c FROM account WHERE name='test1'];
       system.assertEquals(expected,account.ContactIDs__c);
       Test.stopTest(); 
   }

   @isTest
   static void testAppendRelatedContactIdsInAccount2(){
       Test.startTest();
       Account account = [Select id,ContactIDs__c FROM account WHERE name='test1'];
       List<Contact> contacts = [Select id from contact where accountId=:account.id];
       String testcontactId = contacts[0].id;
       StudentAndClassDetails.appendRelatedContactIdsInAccount(testcontactId);
       Contact testContact = new Contact(AccountId=account.Id,lastname='Sharma',firstname='Nidhi',Subjects__c='Maths');
       insert testContact;
       String expected = '';
       StudentAndClassDetails.appendRelatedContactIdsInAccount(testContact.Id);
       List<Contact> updatedcontacts = [Select id from contact where AccountId=:account.Id];
       for(Contact contact:updatedcontacts){
           if(!expected.equals('')){
               expected +=',';
           }
           expected +=contact.Id;
       }
       account = [Select id,ContactIDs__c FROM account WHERE name='test1'];
       system.assertEquals(expected, account.ContactIDs__c);
       Test.stopTest();
   }
}