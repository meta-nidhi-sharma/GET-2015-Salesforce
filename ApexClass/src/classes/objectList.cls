public class objectList{
  
  public static void getName()
  {
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
        List<String> objectList = new List<String>();
        for(Schema.SObjectType f : gd)
        {
           System.debug(f.getDescribe().getLabel());
           objectList.add(f.getDescribe().getLabel());
        }
      System.debug(objectList);
   }
}
