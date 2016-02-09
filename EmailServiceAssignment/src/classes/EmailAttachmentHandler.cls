/*
 * Parsing XML formatted attachments received in email service and according that inserting contact records in SFDC Org
 */ 
global class EmailAttachmentHandler implements Messaging.InboundEmailHandler {
    //Overrided method
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,  Messaging.Inboundenvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        //getting list of attachments from email
        Messaging.InboundEmail.TextAttachment[] attachments = email.textAttachments;
        //Checking for attachment is not null
        if(attachments != null){
            //parsing each attachment
            for(Messaging.InboundEmail.TextAttachment xmlAttachment : attachments){
                List<Contact> contacts = new List<Contact>();
                String fileContent = xmlAttachment.body;
                DOM.Document doc = new DOM.Document();
                doc.load(fileContent);
                //Getting root element from xml attachment
                Dom.XMLNode root = doc.getRootElement();  
                //Iterating on child(contact) of root element
                for(Dom.XMLNode child : root.getChildElements()) {
                    Contact contact = new Contact();
                    //Parsing each child element to contact field values
                    contact.FirstName = child.getChildElement('firstName', null).getText();
                    contact.LastName = child.getChildElement('lastName', null).getText();
                    contact.Email = child.getChildElement('email', null).getText();
                    contact.Phone = child.getChildElement('phone', null).getText();
                    contact.Subjects__c = child.getChildElement('subjects', null).getText();
                    contacts.add(contact);
                }
                //Inserting list of contacts
                insert contacts[0];
            }
        }
        return result; 
    }
}