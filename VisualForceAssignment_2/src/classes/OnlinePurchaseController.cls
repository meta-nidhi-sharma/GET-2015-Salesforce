public class OnlinePurchaseController {
    
    public List<Product2> products{get;set;}
    public List<PurchaseOrderLineItems__c> productsInCart{get;set;}
    public Set<ID> productIdsInCart{get;set;}
    public String selectedProductId{get;set;}
    public PurchaseOrder__c order{get;set;}
    public Date deliveryDate{get;set;}
    public boolean productsPopUp {get;set;}
    public boolean purchaseOrderLineItemsdisplayPopUp {get; set;}  
    public boolean lineItemBlockDisplay {get; set;}  
    public boolean purchaseOrderdisplayPopUp {get; set;}  
    public boolean personalInfoDisplayPopUp {get; set;} 
    
    public OnlinePurchaseController(){
        productsPopUp = true;
        lineItemBlockDisplay = true;
        purchaseOrderLineItemsdisplayPopUp = false;
        personalInfoDisplayPopUp = false;
        purchaseOrderdisplayPopUp = false;
        order = new PurchaseOrder__c();
        productsInCart = new List<PurchaseOrderLineItems__c>();
        productIdsInCart = new Set<ID>();
        getproducts();
    }
    
    public Void getProducts(){
        string Query = 'SELECT id,name,price__c FROM Product2';
        products = Database.query(Query);
    }
    
    public Void addToCart(){
        purchaseOrderLineItemsdisplayPopUp = true;
        if(productIdsInCart.contains(selectedProductId)){
            for(PurchaseOrderLineItems__c product : productsInCart){
                if(product.Product__c == selectedProductId){
                    product.Quantity__c = ++product.Quantity__c;
                }
            }   
        }
        else{
            System.debug(selectedProductId);
            Product2 productToPurchase = [Select name,price__C from Product2 where id=:selectedProductId];
            PurchaseOrderLineItems__c lineItem = new PurchaseOrderLineItems__c();
            lineItem.Name = productToPurchase.Name;
            lineItem.Product__c = productToPurchase.id;
            lineItem.Quantity__c = 1;
            lineItem.UnitPrice__c = productToPurchase.price__C; 
            lineItem.ESmartPack__c = false;
            insert lineItem;
            ID lineItemId = lineItem.id;
            PurchaseOrderLineItems__c newProduct = [Select name,Product__c,Quantity__c,ESmartPack__c,UnitPrice__c,TotalPrice__c from PurchaseOrderLineItems__c where id=:lineItemId];
            productsInCart.add(newProduct);
            productIdsInCart.add(newProduct.Product__c);
        }
    }    
    
    public Void removeFromCart(){
        PurchaseOrderLineItems__c productToRemove = [Select name,Quantity__c,ESmartPack__c,UnitPrice__c,TotalPrice__c from PurchaseOrderLineItems__c where id=:selectedProductId];
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
    
    public void proceedToPay(){  
        Decimal totalPrice = 0;
        for(PurchaseOrderLineItems__c purchaseOrder : productsInCart){
            totalPrice += (purchaseOrder.TotalPrice__c * purchaseOrder.Quantity__c);
        }
        order.TotalPrice__c = totalPrice;
        productsPopUp = false;
        lineItemBlockDisplay = false;
        personalInfoDisplayPopUp = true;
        purchaseOrderLineItemsdisplayPopUp = false;
    }
    
    public void pay(){
        insert order;
        Id orderId = order.Id;
        for(PurchaseOrderLineItems__c purchaseOrder : productsInCart){
            purchaseOrder.PurchaseOrder__c = orderId;
        }
        upsert productsInCart;
        deliveryDate = (Date.today()).addDays(9);
        personalInfoDisplayPopUp  = false;
        purchaseOrderdisplayPopUp = true;
    }
}