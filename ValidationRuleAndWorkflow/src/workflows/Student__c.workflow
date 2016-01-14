<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>StudentRecordsUpdated</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <template>unfiled$public/StudentRecordUpdateAlert</template>
    </alerts>
    <fieldUpdates>
        <fullName>MaritalStatusUpdate</fullName>
        <field>Married__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MaritalStatusAutomaticUpdate</fullName>
        <actions>
            <name>MaritalStatusUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISNULL(WifeName__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
