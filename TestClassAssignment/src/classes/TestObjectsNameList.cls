@isTest
private class TestObjectsNameList {
	@isTest
    static void testGetSobjectName(){
        List<String> sObjectsName = ObjectsNameList.getSobjectName();
        Set<String> actualSObjects = new Set<String>(sObjectsName);
        System.assertEquals(true, actualSObjects.contains('Account'));
    }
}