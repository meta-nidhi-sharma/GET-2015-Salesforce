trigger ClassMyCountUpdate on Student__c (after insert, after delete) {
    List<Class__C> classList = [Select numberOfStudents__C,myCount__c from class__C];
    for(Class__C classObject : classList){
        classObject.myCount__c=classObject.numberOfStudents__C;
    }
    update classList;
    Map<String,Integer> classMap = new Map<String,Integer>();
    if(Trigger.isInsert){
        
        
        for(Student__C student : Trigger.NEW){
            if(classMap.containsKey(student.class__c)){
                Integer myCount = classMap.get(student.class__c);
                classMap.put(student.class__c, ++myCount);
            }
            else{
                classMap.put(student.class__c, 1);
            }
        }
        List<Class__C> classListToUpdate = [Select id, myCount__c from Class__C where id IN :classMap.keySet()];
        
        for(Class__C classToUpdate : classListToUpdate){
            classToUpdate.MyCount__c += classMap.get(classToUpdate.Id);
            
        }
        update classListToUpdate;
    }
    if(Trigger.isDelete){
        for(Student__C studentObject : Trigger.OLD){
            if(classMap.containsKey(studentObject.class__c)){
                Integer myCount = classMap.get(studentObject.class__c);
                classMap.put(studentObject.class__c, ++myCount);
            }
            else{
                classMap.put(studentObject.class__c, 1);
            }
        }
        List<Class__C> classListToUpdate = [Select id, myCount__c from Class__C where id IN :classMap.keySet()];
        
        for(Class__C classToUpdate : classListToUpdate){
            classToUpdate.MyCount__c -= classMap.get(classToUpdate.Id);
        }
        update classListToUpdate;
    }
    
}