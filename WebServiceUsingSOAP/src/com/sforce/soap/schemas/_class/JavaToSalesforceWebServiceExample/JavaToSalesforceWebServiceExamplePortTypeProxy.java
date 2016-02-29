package com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample;

public class JavaToSalesforceWebServiceExamplePortTypeProxy implements com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExamplePortType {
  private String _endpoint = null;
  private com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExamplePortType javaToSalesforceWebServiceExamplePortType = null;
  
  public JavaToSalesforceWebServiceExamplePortTypeProxy() {
    _initJavaToSalesforceWebServiceExamplePortTypeProxy();
  }
  
  public JavaToSalesforceWebServiceExamplePortTypeProxy(String endpoint) {
    _endpoint = endpoint;
    _initJavaToSalesforceWebServiceExamplePortTypeProxy();
  }
  
  private void _initJavaToSalesforceWebServiceExamplePortTypeProxy() {
    try {
      javaToSalesforceWebServiceExamplePortType = (new com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleServiceLocator()).getJavaToSalesforceWebServiceExample();
      if (javaToSalesforceWebServiceExamplePortType != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)javaToSalesforceWebServiceExamplePortType)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)javaToSalesforceWebServiceExamplePortType)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (javaToSalesforceWebServiceExamplePortType != null)
      ((javax.xml.rpc.Stub)javaToSalesforceWebServiceExamplePortType)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExamplePortType getJavaToSalesforceWebServiceExamplePortType() {
    if (javaToSalesforceWebServiceExamplePortType == null)
      _initJavaToSalesforceWebServiceExamplePortTypeProxy();
    return javaToSalesforceWebServiceExamplePortType;
  }
  
  public java.lang.String insertStudent(java.lang.String firstName, java.lang.String lastName, java.lang.String classId) throws java.rmi.RemoteException{
    if (javaToSalesforceWebServiceExamplePortType == null)
      _initJavaToSalesforceWebServiceExamplePortTypeProxy();
    return javaToSalesforceWebServiceExamplePortType.insertStudent(firstName, lastName, classId);
  }
  
  public java.lang.String retrieveQueryResults(java.lang.String query) throws java.rmi.RemoteException{
    if (javaToSalesforceWebServiceExamplePortType == null)
      _initJavaToSalesforceWebServiceExamplePortTypeProxy();
    return javaToSalesforceWebServiceExamplePortType.retrieveQueryResults(query);
  }
  
  
}