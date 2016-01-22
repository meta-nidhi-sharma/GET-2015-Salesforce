trigger RestrictClassOnDeleteForFemaleStudents on Class__c (before delete) {
    List<Student__c> studentList = [Select id,class__r.id from Student__c where Sex__c='Female' AND Class__c In :Trigger.old];
    for(Class__c classObject : Trigger.old){
        Integer numberOfFemaleStudents = 0;
        for(Student__C studentObject : studentList){
           	if(classObject.id == studentObject.class__r.id){
                if(++numberOfFemaleStudents > 1){
                	Trigger.oldMap.get(classObject.id).adderror('Cannot delete a Class having more than 1 female student');
                	break;
				}
			}
		}
	}
}