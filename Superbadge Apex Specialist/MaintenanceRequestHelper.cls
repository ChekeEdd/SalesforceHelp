public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> caseList){
        // update workorders        
        List<Case> insertCaseList = new List<Case>();
        for(Case cs : caseList){
            Case newCase = new Case();
            newCase.Type = 'Routine Maintenance';
            newCase.Status = 'New';
            newCase.Vehicle__c = cs.Vehicle__c;
            newCase.Subject =  cs.Subject;
            newCase.Date_Reported__c = Date.today();
            newCase.Date_Due__c = Date.today();
            newCase.Equipment__c = cs.Equipment__c;
            insertCaseList.add(newCase);
        }
        if(insertCaseList.size()>0){
            insert insertCaseList;
        }
    }
}