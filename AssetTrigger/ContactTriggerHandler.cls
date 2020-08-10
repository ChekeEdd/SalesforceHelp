global class AssetTriggerHandler implements Database.Batchable<sObject>, Database.Stateful  {
    
    global Integer recordsProcessed = 0;
    
    Set<Id> newSet = new Set<Id>();
    public AssetTriggerHandler(Set<Id> newSet){
        this.newSet = newSet;
    }
      
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([select Id from Account WHERE Id IN :newSet ORDER BY Name]);
    }
    
    public void execute(Database.BatchableContext context, List<Account> scope){
        Account[] updates = new Account[] {};
            for (AggregateResult ar : [
                SELECT Account__c a, count(Id) c
                from Asset__c
                where Account__c in :scope
                group by Account__c
            ]) {
                updates.add(new Account(
                    Id = (Id) ar.get('a'),
                    Number_of_Assets__c = (Decimal) ar.get('c')
                ));
            }
        update updates;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }
    
    
}