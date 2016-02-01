trigger CheckMaxStudentLimitOfClass on Student__c (after insert) {
   Set<String> classIds = new Set<String>();
   for(student__C studentObject :Trigger.new){
      classIds.add(studentObject.Class__c);
   }
   for(Class__c classObject : [Select id,NumberOfStudents__c,MaxSize__c from class__c where id IN :classIds]){
       if(classObject.NumberOfStudents__c >= classObject.MaxSize__c){
           classIds.remove(classObject.id);
       }
    }
   for(student__C student :Trigger.new){
       if(!classIds.contains(student.Class__c)){
           student.addError('Cannot insert more student. Class max size limit exceeded.');
       }
   }    
}
