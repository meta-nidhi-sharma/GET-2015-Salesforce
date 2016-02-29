/**
 * JavaToSalesforceWebServiceExampleServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample;

public class JavaToSalesforceWebServiceExampleServiceLocator extends org.apache.axis.client.Service implements com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleService {

    public JavaToSalesforceWebServiceExampleServiceLocator() {
    }


    public JavaToSalesforceWebServiceExampleServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public JavaToSalesforceWebServiceExampleServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for JavaToSalesforceWebServiceExample
    private java.lang.String JavaToSalesforceWebServiceExample_address = "https://ap2.salesforce.com/services/Soap/class/JavaToSalesforceWebServiceExample";

    public java.lang.String getJavaToSalesforceWebServiceExampleAddress() {
        return JavaToSalesforceWebServiceExample_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String JavaToSalesforceWebServiceExampleWSDDServiceName = "JavaToSalesforceWebServiceExample";

    public java.lang.String getJavaToSalesforceWebServiceExampleWSDDServiceName() {
        return JavaToSalesforceWebServiceExampleWSDDServiceName;
    }

    public void setJavaToSalesforceWebServiceExampleWSDDServiceName(java.lang.String name) {
        JavaToSalesforceWebServiceExampleWSDDServiceName = name;
    }

    public com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExamplePortType getJavaToSalesforceWebServiceExample() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(JavaToSalesforceWebServiceExample_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getJavaToSalesforceWebServiceExample(endpoint);
    }

    public com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExamplePortType getJavaToSalesforceWebServiceExample(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleBindingStub _stub = new com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleBindingStub(portAddress, this);
            _stub.setPortName(getJavaToSalesforceWebServiceExampleWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setJavaToSalesforceWebServiceExampleEndpointAddress(java.lang.String address) {
        JavaToSalesforceWebServiceExample_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExamplePortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleBindingStub _stub = new com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleBindingStub(new java.net.URL(JavaToSalesforceWebServiceExample_address), this);
                _stub.setPortName(getJavaToSalesforceWebServiceExampleWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("JavaToSalesforceWebServiceExample".equals(inputPortName)) {
            return getJavaToSalesforceWebServiceExample();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://soap.sforce.com/schemas/class/JavaToSalesforceWebServiceExample", "JavaToSalesforceWebServiceExampleService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://soap.sforce.com/schemas/class/JavaToSalesforceWebServiceExample", "JavaToSalesforceWebServiceExample"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("JavaToSalesforceWebServiceExample".equals(portName)) {
            setJavaToSalesforceWebServiceExampleEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
