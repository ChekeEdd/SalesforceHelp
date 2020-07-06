trigger DateTrigger on User__c (after insert, after update) {
    
    TriggerDateClass.main(Trigger.New);

}