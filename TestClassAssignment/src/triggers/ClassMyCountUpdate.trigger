trigger ClassMyCountUpdate on Student__c (after insert, after delete, after update) {
    Map<String,Integer> studentCountByClass = new Map<String,Integer>();
    if(Trigger.isInsert){
        studentCountByClass = ClassStudentCountUpdate.getNumberOfStudentsByClass(Trigger.NEW);
        List<Class__c> classesToUpdate = [Select id, MyCount__c from Class__c where id IN :studentCountByClass.keySet()];
        for(Class__c classToUpdate : classesToUpdate){
            if(classToUpdate.MyCount__c == null){
                classToUpdate.MyCount__c = 0;
            }
            classToUpdate.MyCount__c += studentCountByClass.get(classToUpdate.Id);
        }
        update classesToUpdate;
    }
    if(Trigger.isDelete){
        studentCountByClass = ClassStudentCountUpdate.getNumberOfStudentsByClass(Trigger.OLD);
        List<Class__c> classesToUpdate = [Select id, MyCount__c from Class__c where id IN :studentCountByClass.keySet()];
        for(Class__c classToUpdate : classesToUpdate){
            classToUpdate.MyCount__c -= studentCountByClass.get(classToUpdate.Id);
        }
        update classesToUpdate;
    }
    if(Trigger.isUpdate){
        for(Student__c student : Trigger.New){
            Student__c oldStudent = Trigger.oldMap.get(student.Id);
            if(student.Class__c != oldStudent.Class__c){
                if(studentCountByClass.containsKey(student.Class__c)){
                    Integer myCount = studentCountByClass.get(student.Class__c);
                    studentCountByClass.put(student.Class__c, ++myCount);
                }
                else{
                    studentCountByClass.put(student.Class__c, 1);
                }
                if(studentCountByClass.containsKey(oldStudent.Class__c)){
                    Integer myCount = studentCountByClass.get(oldStudent.Class__c);
                    studentCountByClass.put(oldStudent.Class__c, --myCount);
                }
                else{
                    studentCountByClass.put(oldStudent.Class__c, -1);
                }
            }
        }
        List<Class__c> classesToUpdate = [Select id,name, MyCount__c from Class__c where id IN :studentCountByClass.keySet()];
        for(Class__c classToUpdate : classesToUpdate){
            if(classToUpdate.MyCount__c == null){
                classToUpdate.MyCount__c = 0;
            }
            classToUpdate.MyCount__c += studentCountByClass.get(classToUpdate.Id);
        }
        update classesToUpdate;
    }
}