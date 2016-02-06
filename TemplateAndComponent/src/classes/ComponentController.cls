/**
 * @Author : Nidhi Sharma
 * Description : Controller providing query editor functionality with sorting based on fields by clicking on records header.
 *  By default records will be displayed in ascending order if record Ids.
 */ 
public class ComponentController {
    public List<String> fieldLabels{get;set;}
    public String query {get;set;}
    public Boolean queryBlockDisplayPopUp {get;set;}
    public Boolean queryResultBlockDisplayPopUp {get;set;}
    public ApexPages.StandardSetController sObjectSetController {get; set;} //StandardSetController to get records by query locator
    public String sortingColumn {get;set;}	//stores column name on which sorting is to apply
    public String sortType {get;set;}	//stores two values (ASC/DESC) to sort accounts in ascending or descending order
    public Integer pageNumber {get;set;}
    public Integer totalpages{get;set;} //total pages of records
    Integer recordsPerPage = 5;         //number of records on one page
    //List of records
    public List<SObject> sObjects {
        get{
            if(sObjectSetController!=null){
                pageNumber = sObjectSetController.getPageNumber();
                return (List<SObject>) sObjectSetController.getRecords();
            }// ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Records found'));
            return null;
        }set;
    } 
    //Controller
    public ComponentController(){
        sortingColumn = 'Id';
        sortType = 'ASC';
        queryBlockDisplayPopUp = true;
        queryResultBlockDisplayPopUp = false;
        totalPages = 0;
    }
    //providing functionality of 'Quick Go', forwarding to page number specified by user
    public void redirectToPage(){
        if(pageNumber <= totalpages && pageNumber > 0 ){
            sObjectSetController.setpageNumber(pageNumber);
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Page does not exists,Page starts from 1 and last page number is '+ totalpages));
        }
    }
    //To execute soql
    public void execute(){
        queryBlockDisplayPopUp = false;
        queryResultBlockDisplayPopUp = true;
        if(query!=null && query!=''){
            try{
                retrieveRecords();
                try{
                    getFieldLabels();
                }catch(ListException exp1){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Records found'));
                }
            }catch(Exception exp){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unknown error parsing query'));
            } 
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Enter query first'));
        } 
    }
    //To go back to write query
    public void back(){
        totalPages = 0;
        queryBlockDisplayPopUp = true;
        fieldLabels = null;
        queryResultBlockDisplayPopUp = false;
    }
    //To retrieve records using query locator providing default sording based on Id in ascending order
    public void retrieveRecords(){
        String sortingQuery = query + ' ORDER BY ' + sortingColumn  + ' ' + sortType+'';
        sObjectSetController = new ApexPages.StandardSetController(Database.getQueryLocator(sortingQuery));
        sObjectSetController.setPageSize(recordsPerPage);
        totalPages = (sObjectSetController.getResultSize() / sObjectSetController.getPageSize());
        totalPages = Integer.valueOf(totalPages + ((Math.mod(sObjectSetController.getResultSize(), recordsPerPage)>0) ? 1 : 0));
        pageNumber=1;
    }
    //To get retrieved field labels
    public void getFieldLabels(){
        String sObjectJSON = JSON.serialize(sObjects[0]);
        Map<String,Object> valueByFieldName = (Map<String,Object>)Json.deserializeUntyped(sObjectJSON);
        Set<String> fieldLabelsset = valueByFieldName.keyset().clone();
        fieldLabelsset.remove('attributes');
        fieldLabels = new List<String>(fieldLabelsset);
    }
    //To sort records according to fields headers
    public void sort(){
        retrieveRecords();
    }
}