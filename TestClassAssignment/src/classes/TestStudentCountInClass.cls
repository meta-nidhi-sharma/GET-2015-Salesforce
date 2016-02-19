@isTest(SeeAllData=false)
private class TestStudentCountInClass {
    static Class__c testClass1;
    static Class__c testClass2;
    static List<Class__c> classes = new List<Class__c>();
    static Student__c testStudent1;
    static Student__c testStudent2;
    static List<Student__c> students = new List<Student__c>();
    @testSetup
    public static void setupMethod(){
        testClass1 = new Class__c(Name='X');
        testClass2 = new Class__c(Name='XI');
        classes.add(testClass1);
        classes.add(testClass2);
        insert classes;
        testStudent1 = new Student__c(firstName__c='Nidhi', lastName__c='Sharma',Class__c=testClass1.Id);
        testStudent2 = new Student__c(firstName__c='Neha', lastName__c='Bansal',Class__c=testClass1.Id);
        students.add(testStudent1);
        students.add(testStudent2);
        insert students;
    }
    @isTest
    static void testCountOfStudentInOldClassOnInsertStudent(){
        Test.startTest();
        testClass1 = [Select MyCount__c from Class__c where Name='X'];
        Test.stopTest();
        System.assertEquals(2, testClass1.MyCount__c);
    }
    @isTest
    static void testCountOfStudentInNewClassOnInsertStudent(){
        Class__c newClass = new Class__c(Name='XII');
        Test.startTest();
        insert newClass;
        Student__c newStudent = new Student__c(firstName__c='Richa',lastName__c='Mittal',Class__c=newClass.Id);
        insert newStudent;
        newClass = [Select MyCount__c from Class__c where Name='XII'];
        Test.stopTest();
        System.assertEquals(1, newClass.MyCount__c);
    }
    @isTest
    static void testCountOfStudentInClassOnDeleteStudent(){
        Test.startTest();
        delete [Select id from Student__c where (firstName__c='Nidhi' AND lastName__c='Sharma')];
        testClass1 = [Select MyCount__c from Class__c where Name='X'];
        Test.stopTest();
        System.assertEquals(1, testClass1.MyCount__c);
    }
    @isTest
    static void testCountOfStudentInClassOnUpdateSingleStudent(){
        Test.startTest();
        testStudent1 = [Select id from Student__c where (firstName__c='Nidhi' AND lastName__c='Sharma')];
        testClass2 = [Select MyCount__c from Class__c where Name='XI'];
        testStudent1.Class__c = testClass2.id;
        update testStudent1;
        testClass1 = [Select MyCount__c from Class__c where Name='X'];
        testClass2 = [Select MyCount__c from Class__c where Name='XI'];
        Test.stopTest();
        System.assertEquals(1,testClass1.MyCount__c);
        System.assertEquals(1,testClass2.MyCount__c);
    }
    @isTest
    static void testCountOfStudentInClassOnUpdateStudentList(){
        Test.startTest();
        testStudent1 = [Select id,name,class__r.name from Student__c where (firstName__c='Nidhi' AND lastName__c='Sharma')];
        testStudent2 = [Select id,name,class__r.name from Student__c where (firstName__c='Neha' AND lastName__c='Bansal')];
        testClass1 = [Select MyCount__c from Class__c where Name='X'];
        testClass2 = [Select MyCount__c from Class__c where Name='XI'];
        testStudent1.Class__c = testClass2.id;
        testStudent2.Class__c = testClass2.id;
        List<Student__c> updatedStudents = new List<Student__c>();
        updatedStudents.add(testStudent1);
        updatedStudents.add(testStudent2);
        update updatedStudents;
        testClass1 = [Select MyCount__c from Class__c where Name='X'];
        testClass2 = [Select MyCount__c from Class__c where Name='XI'];
        Test.stopTest();
        System.assertEquals(0.0,testClass1.MyCount__c);
        System.assertEquals(2.0,testClass2.MyCount__c);
    }
}