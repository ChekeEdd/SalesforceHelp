trigger CaseCountTrigger on Case (after insert, after update,after delete) {    
    
    
    if(Trigger.isAfter){ 
        if(Trigger.isDelete){
            CaseCountTriggerHandler.caseCount(Trigger.New);
        }
        if(Trigger.isInsert){
            CaseCountTriggerHandler.caseCount(Trigger.New);
        }
        if(Trigger.isUpdate){
            CaseCountTriggerHandler.caseCount(Trigger.New);
        }
        
        
        
    }

}
