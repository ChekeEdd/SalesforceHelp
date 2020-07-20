trigger MaintenanceRequest on Case (before update, after update) {
    
    List<Case> ClosedCaseList = [SELECT Id, subject, Vehicle__c, vehicle__r.Name, equipment__c, Type 
                                 FROM Case 
                                 WHERE status = 'Closed' 
                                 AND (Type = 'Repair' OR Type ='Routine Maintenance') 
                                 AND ID IN :Trigger.New];
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            MaintenanceRequestHelper.updateWorkOrders(ClosedCaseList);
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            MaintenanceRequestHelper.updateWorkOrders(ClosedCaseList);
        }
    }
    
}
