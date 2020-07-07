trigger DateTrigger on User__c (after insert, after update) {
    
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TriggerDateClass.main(Trigger.New);
        }
        if(Trigger.isUpdate){
            TriggerDateClass.main(Trigger.New);
        }
        
    }

}