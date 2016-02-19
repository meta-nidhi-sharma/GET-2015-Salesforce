public class ShoppingCartController {
    public List<PurchaseOrderLineItems__c> productsInCart {get;set;}
    public Set<Id> productIdsInCart {get;set;} 
    public String selectedProductId {get;set;}
    public PurchaseOrder__c order {get;set;}
    public Date deliveryDate {get;set;}
    public boolean productsPopUp {get;set;}
    public boolean purchaseOrderLineItemsdisplayPopUp {get; set;}  
    public boolean cartDisplayPopUp {get; set;}  
    public boolean purchaseOrderdisplayPopUp {get; set;} 
    public Boolean categoryDisplayPopUp {get;set;}
    public boolean personalInfoDisplayPopUp {get; set;}  
    public String selectedCategory {get;set;}
    public ApexPages.StandardSetController productSetController {get; set;}
    public String query;
    public Integer totalPages {get;set;}
    Integer recordsPerPage = 5;   
    //list of products
    public List<Product2> Products {
        get{
            return (List<Product2>) productSetController.getRecords();
        }set;
    }   
    //Controller
    public ShoppingCartController(){
        productsPopUp = true;
        cartDisplayPopUp = true;
        purchaseOrderLineItemsdisplayPopUp = true;
        personalInfoDisplayPopUp = false;
        purchaseOrderdisplayPopUp = false;
        categoryDisplayPopUp = true;
        order = new PurchaseOrder__c();
        productIdsInCart = new Set<Id>();
        try{
            productsInCart = [Select name,Product__c,Quantity__c,ESmartPack__c,UnitPrice__c from PurchaseOrderLineItems__c where createdBy.id=:userinfo.getUserId()];
            if(productsInCart !=null && productsInCart.size()>0){
                for(PurchaseOrderLineItems__c productInCart : productsInCart){
                    productIdsInCart.add(productInCart.Product__c);
                } 
            }
        }catch(NullPointerException exp){
            productsInCart = new List<PurchaseOrderLineItems__c>();
        }
        if(productsInCart.size()>0){
            purchaseOrderLineItemsdisplayPopUp = true;
        }else{
            purchaseOrderLineItemsdisplayPopUp = false;
        }
        selectedCategory = 'All';
        retrieveProducts(); 
    }
    //To get list all available categories
    public List<SelectOption> getCategories() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('Electronics','Electronics'));
        options.add(new SelectOption('Clothing','Clothing'));
        options.add(new SelectOption('Home Appliances','Home Appliances'));
        options.add(new SelectOption('Others','Others'));
        return options;
    }
    //To search products by on the basis of selected category
    public void searchByCategory() {
        retrieveProducts();
    }
    //To retrive products (all or on the basis of category)
    public void retrieveProducts(){
        query = 'SELECT id,name,Category__c,price__c FROM Product2 ';
        if(selectedCategory!=null && selectedCategory != '' && selectedCategory != 'All'){
            query += 'where Category__c=\''+selectedCategory+'\'';
        }
        productSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        productSetController.setPageSize(recordsPerPage);
        totalPages = (productSetController.getResultSize() / productSetController.getPageSize());
        totalPages = Integer.valueOf(totalPages + ((Math.mod(productSetController.getResultSize(), recordsPerPage)>0) ? 1 : 0));
    }
    //To add selected product in cart
    public Void addToCart(){
        purchaseOrderLineItemsdisplayPopUp = true;
        if(productIdsInCart.contains(selectedProductId)){
            for(PurchaseOrderLineItems__c product : productsInCart){
                if(product.Product__c == selectedProductId){
                    product.Quantity__c = ++product.Quantity__c;
                }
            } 
            update productsInCart;
        }
        else{
            Product2 productToPurchase = [Select name,price__c from Product2 where id=:selectedProductId];
            PurchaseOrderLineItems__c lineItem = new PurchaseOrderLineItems__c();
            lineItem.Name = productToPurchase.Name;
            lineItem.Product__c = productToPurchase.id;
            lineItem.Quantity__c = 1;
            lineItem.UnitPrice__c = productToPurchase.price__C; 
            lineItem.ESmartPack__c = true;
            insert lineItem;
            ID lineItemId = lineItem.id;
            PurchaseOrderLineItems__c newProduct = [Select name,Product__c,Quantity__c,ESmartPack__c,UnitPrice__c from PurchaseOrderLineItems__c where id=:lineItemId];
            productsInCart.add(newProduct);
            productIdsInCart.add(newProduct.Product__c);
        }
    }    
    //To remove product from cart
    public Void removeFromCart(){
        PurchaseOrderLineItems__c productToRemove = [Select name,Quantity__c,ESmartPack__c,UnitPrice__c from PurchaseOrderLineItems__c where id=:selectedProductId];
        Integer index = 0;
        for(PurchaseOrderLineItems__c product : productsInCart){
            if(product.Id == productToRemove.Id){
                break;
            }
            index++;
        }
        productsInCart.remove(index);
        if(productsInCart.size() > 0){
            purchaseOrderLineItemsdisplayPopUp = true;
        }
        else{
            purchaseOrderLineItemsdisplayPopUp = false;
        }
        Delete productToRemove;
    }
    //To proceed for payment
    public void proceedToPay(){  
        Decimal totalPrice = 0;
        for(PurchaseOrderLineItems__c cartProduct : productsInCart){
            totalPrice += (cartProduct.UnitPrice__c * cartProduct.Quantity__c);
        }
        order.TotalPrice__c = totalPrice;
        productsPopUp = false;
        cartDisplayPopUp = false;
        personalInfoDisplayPopUp = true;
        purchaseOrderLineItemsdisplayPopUp = false;
        categoryDisplayPopUp = false;
        totalPages = 0;
    }
    //To create order and provide info of delievery of product to user
    public void pay(){
        insert order;
        Id orderId = order.Id;
        for(PurchaseOrderLineItems__c cartProduct : productsInCart){
            cartProduct.PurchaseOrder__c = orderId;
        }
        Update productsInCart;
        deliveryDate = (Date.today()).addDays(9);
        personalInfoDisplayPopUp  = false;
        purchaseOrderdisplayPopUp = true;
    }
}