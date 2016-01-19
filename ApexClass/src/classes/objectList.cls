public class ObjectList{
  
  public static void getSobjectName ()
  {
        List<Schema.SObjectType> sObjectTypeList = Schema.getGlobalDescribe().Values();     
        List<String> sObjectNames = new List<String>();
        for(Schema.SObjectType sObjectType : sObjectTypeList)
        {
           System.debug(sObjectType.getDescribe().getLabel());
           sObjectNames.add(sObjectType.getDescribe().getLabel());
        }
      	System.debug(sObjectNames);
   }
}
