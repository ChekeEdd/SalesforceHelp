trigger CaseCountTrigger on Case (after insert, after update,after delete) {    
    
    
    if(Trigger.isAfter){ 
        if(Trigger.isDelete){
            CaseTriggerHandler.caseCount(Trigger.New);
        }
        if(Trigger.isInsert){
            CaseTriggerHandler.caseCount(Trigger.New);
        }
        if(Trigger.isUpdate){
            CaseTriggerHandler.caseCount(Trigger.New);
        }
        
        
        
    }

}
