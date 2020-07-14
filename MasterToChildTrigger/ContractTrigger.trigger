trigger ContractTrigger on ContractC__c (after update, after insert) {
    
    ContractTriggerHandler.changeFieldStatus(Trigger.New);

}