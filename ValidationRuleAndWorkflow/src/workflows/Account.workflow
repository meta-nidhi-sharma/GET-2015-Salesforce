<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AccountUpdatedByAnotherUser</fullName>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <template>unfiled$public/AccountUpdationAlert</template>
    </alerts>
    <fieldUpdates>
        <fullName>Field_Update</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Texas Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>nidhi.sharma@salesforce.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type Field</fullName>
        <field>Type</field>
        <literalValue>Pending</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type Update</fullName>
        <field>Type</field>
        <literalValue>Pending</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type Update1</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type Update2</fullName>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type_Field_Update</fullName>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AccountUpdationRule</fullName>
        <actions>
            <name>AccountUpdatedByAnotherUser</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND( AnnualRevenue  &gt; 1000000,  Owner.Id  &lt;&gt;  $User.Id  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Texas Accounts</fullName>
        <actions>
            <name>Texas Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
            <value>TX</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Follow Up with New Account</fullName>
        <assignedTo>nidhi.sharma@salesforce.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
    </tasks>
</Workflow>
