public class ObjectsNameList{ 
  public static List<String> sObjectNames = new List<String>();
  public static List<String> getSobjectName (){
        List<Schema.SObjectType> sObjectTypeList = Schema.getGlobalDescribe().Values();     
        for(Schema.SObjectType sObjectType : sObjectTypeList){
           sObjectNames.add(sObjectType.getDescribe().getLabel());
        }
      return sObjectNames;
   }
}