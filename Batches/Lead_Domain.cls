global class Lead_Domain implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LastName, Company, Email, EmailDomain__c, Phone FROM Lead');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead lead : scope) {
           lead.EmailDomain__c = lead.Email.replaceAll('@','');
           recordsProcessed = recordsProcessed + 1;
        }
        update scope;        
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }
    
    global void execute(SchedulableContext sc)
    {
        Lead_Domain leads = new Lead_Domain();
        database.executebatch(leads,200);
    }  

}