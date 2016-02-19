@isTest
private class TestShoppingCartController {
    static Product2 testProduct1;
    static Product2 testProduct2;
    static Product2 testProduct3;
    static PageReference pageRef;
    static List<Product2> testProducts = new List<Product2>();
    static PurchaseOrderLineItems__c testLineItem;
    static List<PurchaseOrderLineItems__c> testLineItems;
    static PurchaseOrder__c testOrder;
    @testSetup
    public static void setupMethod(){
        testProduct1 = new Product2(Name='ProductA',Price__c=2000,Category__c='Clothing');
        testProduct2 = new Product2(Name='ProductB',Price__c=3000,Category__c='Home Appliances');
        testProduct3 = new Product2(Name='ProductC',Price__c=5000,Category__c='Others');
        testProducts.add(testProduct1);
        testProducts.add(testProduct2);
        testProducts.add(testProduct3);
        insert testProducts;
    }
    @isTest
    static void testProducts_RetrieveAllProducts_Retrieved() {
        ShoppingCartController testController = new ShoppingCartController();
        System.assertEquals(3,testController.Products.size());
    }
    @isTest
    static void testControllerWhenCartNotBlank_CartItemList_NotNull() {
        Test.startTest();
        testProduct1 = [Select Name,Price__c from Product2 where Name='ProductA'];
        testLineItem = new PurchaseOrderLineItems__c(Name='ProductA',Product__c=testProduct1.Id,Quantity__c=1,
                                                     UnitPrice__c=testProduct1.Price__c,ESmartPack__c=true);
        insert testLineItem;
        ShoppingCartController testController = new ShoppingCartController();
        Test.stopTest();
        System.assertEquals(1,testController.productsInCart.size());
    }
    @isTest
    static void testControllerWhenCartBlank_CartItemList_Null() {
        ShoppingCartController testController = new ShoppingCartController();
        System.assertEquals(0,testController.productsInCart.size());
    }
    @isTest
    static void testSearchProductsByCategory_RetrieveSelectedCategoryProduct_Retrieved() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testController.selectedCategory = 'Others';
        testController.searchByCategory();
        Test.stopTest();
        System.assertEquals(1, testController.productSetController.getResultSize());
    }
    @isTest
    static void testGetCategories_AllCategoriesList_Retrieved() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testController.selectedCategory = 'Others';
        Test.stopTest();
        System.assertEquals(5, testController.getCategories().size());
    }
    @isTest
    static void testAddToCartNewItem_ItemAddInCart_ItemAdded() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testProduct3 = [Select Name, Price__c from Product2 where Name='ProductC'];
        testController.selectedProductId = testProduct3.Id;
        testController.addToCart();
        Test.stopTest();
        System.assertEquals(1, testController.productsInCart.size());
    }
    @isTest
    static void testAddToCartExistedItem_ItemQuantityIncrement_Incremented() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testProduct3 = [Select Name, Price__c from Product2 where Name='ProductC'];
        testController.selectedProductId = testProduct3.Id;
        testController.addToCart();
        testController.selectedProductId = testProduct3.Id;
        testController.addToCart();
        PurchaseOrderLineItems__c cartItem = testController.productsInCart[0];
        Test.stopTest();
        System.assertEquals(2, cartItem.Quantity__c);
    }
    @isTest
    static void testRemoveFromCart_ItemRemoveFromCart_Removed() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testProduct2 = [Select Name, Price__c from Product2 where Name='ProductB'];
        testController.selectedProductId = testProduct2.Id;
        testController.addToCart();
        testProduct3 = [Select Name, Price__c from Product2 where Name='ProductC'];
        testController.selectedProductId = testProduct3.Id;
        testController.addToCart();
        testLineItem = [Select Name from PurchaseOrderLineItems__c where Name='ProductC'];
        testController.selectedProductId = testLineItem.Id;
        testController.removeFromCart();
        Test.stopTest();
        System.assertEquals(1, testController.productsInCart.size());
    }
    @isTest
    static void testRemoveFromCart_LastItemRemoveFromCart_Removed() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testProduct2 = [Select Name, Price__c from Product2 where Name='ProductA'];
        testController.selectedProductId = testProduct2.Id;
        testController.addToCart();
        testLineItem = [Select Name from PurchaseOrderLineItems__c where Name='ProductA'];
        testController.selectedProductId = testLineItem.Id;
        testController.removeFromCart();
        Test.stopTest();
        System.assertEquals(0, testController.productsInCart.size());
    }
    @isTest
    static void testProceedToPay_OpenDeliveryInfoPopUp_PopUpOpened() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testProduct2 = [Select Name, Price__c from Product2 where Name='ProductA'];
        testController.selectedProductId = testProduct2.Id;
        testController.addToCart();
        testController.proceedToPay();
        Test.stopTest();
        System.assertEquals(true, testController.personalInfoDisplayPopUp);
    }
    @isTest
    static void testPay_PlaceOrder_Placed() {
        Test.startTest();
        ShoppingCartController testController = new ShoppingCartController();
        testProduct2 = [Select Name, Price__c from Product2 where Name='ProductA'];
        testController.selectedProductId = testProduct2.Id;
        testController.addToCart();
        testController.proceedToPay();
        testOrder = testController.order;
        testOrder.Name = 'Nidhi';
        testOrder.Address__c = 'Jaipur';
        testOrder.Phone__c = '7346365344';
        testController.order = testOrder;
        testController.pay();
        Test.stopTest();
        System.assertEquals(testController.order.Id,testController.productsInCart[0].PurchaseOrder__c);
    }
}