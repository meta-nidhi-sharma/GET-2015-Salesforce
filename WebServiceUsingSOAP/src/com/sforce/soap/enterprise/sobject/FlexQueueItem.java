/**
 * FlexQueueItem.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.sforce.soap.enterprise.sobject;

public class FlexQueueItem  extends com.sforce.soap.enterprise.sobject.SObject  implements java.io.Serializable {
    private com.sforce.soap.enterprise.sobject.AsyncApexJob asyncApexJob;

    private java.lang.String asyncApexJobId;

    private java.lang.String flexQueueItemId;

    private java.lang.Integer jobPosition;

    private java.lang.String jobType;

    public FlexQueueItem() {
    }

    public FlexQueueItem(
           java.lang.String[] fieldsToNull,
           java.lang.String id,
           com.sforce.soap.enterprise.sobject.AsyncApexJob asyncApexJob,
           java.lang.String asyncApexJobId,
           java.lang.String flexQueueItemId,
           java.lang.Integer jobPosition,
           java.lang.String jobType) {
        super(
            fieldsToNull,
            id);
        this.asyncApexJob = asyncApexJob;
        this.asyncApexJobId = asyncApexJobId;
        this.flexQueueItemId = flexQueueItemId;
        this.jobPosition = jobPosition;
        this.jobType = jobType;
    }


    /**
     * Gets the asyncApexJob value for this FlexQueueItem.
     * 
     * @return asyncApexJob
     */
    public com.sforce.soap.enterprise.sobject.AsyncApexJob getAsyncApexJob() {
        return asyncApexJob;
    }


    /**
     * Sets the asyncApexJob value for this FlexQueueItem.
     * 
     * @param asyncApexJob
     */
    public void setAsyncApexJob(com.sforce.soap.enterprise.sobject.AsyncApexJob asyncApexJob) {
        this.asyncApexJob = asyncApexJob;
    }


    /**
     * Gets the asyncApexJobId value for this FlexQueueItem.
     * 
     * @return asyncApexJobId
     */
    public java.lang.String getAsyncApexJobId() {
        return asyncApexJobId;
    }


    /**
     * Sets the asyncApexJobId value for this FlexQueueItem.
     * 
     * @param asyncApexJobId
     */
    public void setAsyncApexJobId(java.lang.String asyncApexJobId) {
        this.asyncApexJobId = asyncApexJobId;
    }


    /**
     * Gets the flexQueueItemId value for this FlexQueueItem.
     * 
     * @return flexQueueItemId
     */
    public java.lang.String getFlexQueueItemId() {
        return flexQueueItemId;
    }


    /**
     * Sets the flexQueueItemId value for this FlexQueueItem.
     * 
     * @param flexQueueItemId
     */
    public void setFlexQueueItemId(java.lang.String flexQueueItemId) {
        this.flexQueueItemId = flexQueueItemId;
    }


    /**
     * Gets the jobPosition value for this FlexQueueItem.
     * 
     * @return jobPosition
     */
    public java.lang.Integer getJobPosition() {
        return jobPosition;
    }


    /**
     * Sets the jobPosition value for this FlexQueueItem.
     * 
     * @param jobPosition
     */
    public void setJobPosition(java.lang.Integer jobPosition) {
        this.jobPosition = jobPosition;
    }


    /**
     * Gets the jobType value for this FlexQueueItem.
     * 
     * @return jobType
     */
    public java.lang.String getJobType() {
        return jobType;
    }


    /**
     * Sets the jobType value for this FlexQueueItem.
     * 
     * @param jobType
     */
    public void setJobType(java.lang.String jobType) {
        this.jobType = jobType;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FlexQueueItem)) return false;
        FlexQueueItem other = (FlexQueueItem) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.asyncApexJob==null && other.getAsyncApexJob()==null) || 
             (this.asyncApexJob!=null &&
              this.asyncApexJob.equals(other.getAsyncApexJob()))) &&
            ((this.asyncApexJobId==null && other.getAsyncApexJobId()==null) || 
             (this.asyncApexJobId!=null &&
              this.asyncApexJobId.equals(other.getAsyncApexJobId()))) &&
            ((this.flexQueueItemId==null && other.getFlexQueueItemId()==null) || 
             (this.flexQueueItemId!=null &&
              this.flexQueueItemId.equals(other.getFlexQueueItemId()))) &&
            ((this.jobPosition==null && other.getJobPosition()==null) || 
             (this.jobPosition!=null &&
              this.jobPosition.equals(other.getJobPosition()))) &&
            ((this.jobType==null && other.getJobType()==null) || 
             (this.jobType!=null &&
              this.jobType.equals(other.getJobType())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        if (getAsyncApexJob() != null) {
            _hashCode += getAsyncApexJob().hashCode();
        }
        if (getAsyncApexJobId() != null) {
            _hashCode += getAsyncApexJobId().hashCode();
        }
        if (getFlexQueueItemId() != null) {
            _hashCode += getFlexQueueItemId().hashCode();
        }
        if (getJobPosition() != null) {
            _hashCode += getJobPosition().hashCode();
        }
        if (getJobType() != null) {
            _hashCode += getJobType().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FlexQueueItem.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "FlexQueueItem"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("asyncApexJob");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "AsyncApexJob"));
        elemField.setXmlType(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "AsyncApexJob"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("asyncApexJobId");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "AsyncApexJobId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("flexQueueItemId");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "FlexQueueItemId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("jobPosition");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "JobPosition"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("jobType");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:sobject.enterprise.soap.sforce.com", "JobType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
