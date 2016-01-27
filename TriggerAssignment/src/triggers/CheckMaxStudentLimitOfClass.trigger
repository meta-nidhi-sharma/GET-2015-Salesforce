trigger CheckMaxStudentLimitOfClass on Student__c (after insert) {
   Set<String> setOfClassId = new Set<String>();
   for(student__C studentObject :Trigger.new){
      setOfClassId.add(studentObject.Class__c);
   }
   for(Class__c classObject : [Select id,NumberOfStudents__c,MaxSize__c from class__c where id IN :setOfClassId]){
       if(classObject.NumberOfStudents__c >= classObject.MaxSize__c){
           setOfClassId.remove(classObject.id);
       }
    }
   for(student__C student :Trigger.new){
       if(!setOfClassId.contains(student.Class__c)){
           student.addError('Cannot insert more student. Class max size limit exceeded.');
       }
   }    
}
