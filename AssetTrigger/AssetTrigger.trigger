trigger AssetTrigger on Asset__c (after insert, after delete) {
    
    
    Set<Id> sConId = new Set<Id>();
    for(Asset__c asset : Trigger.New){
        if(asset.Account__c != null){
            sConId.add(asset.Account__c);
        }
    }   
    
    if(Trigger.isAfter){       
        if(Trigger.isInsert){
            AssetTriggerHandler batchT = new AssetTriggerHandler(sConId);
            Id batchId = Database.executeBatch(batchT, 50);
        }
  
    }
}
