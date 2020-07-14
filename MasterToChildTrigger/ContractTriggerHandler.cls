public class ContractTriggerHandler {
    
    public static void changeFieldStatus(List<ContractC__c> contractClist){
        
        List<Project__c> projectList = new List<Project__c>();
        List<Project__c> projectId = new List<Project__c>();
        
        for(ContractC__c cr : contractClist){
            projectList = [select id, name, status__c, ContractC__c from Project__c where ContractC__c = :cr.Id]; 
            for (Project__c pr : projectList){
                if(cr.Status__c == 'Done' || pr.Approved__c == TRUE){
                    pr.Status__c = 'Closed';
                    projectId.add(pr);
                }                
            
        	}
            
        }
        if(projectId != null && projectList.size() > 0){
            upsert projectId;
        }
       
    }

}