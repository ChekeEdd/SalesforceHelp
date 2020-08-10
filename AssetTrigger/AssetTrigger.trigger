trigger AssetTrigger on Asset__c (after insert, after delete) {

    if(Trigger.isAfter){         
        if(Trigger.isInsert){
            Set<Id> sConId = new Set<Id>();
            for(Asset__c asset : Trigger.New){
                if(asset.Account__c != null){
                    sConId.add(asset.Account__c);
                }
            }
            AssetTriggerHandler batchT = new AssetTriggerHandler(sConId);
            Id batchId = Database.executeBatch(batchT, 50);
        } 
        if(Trigger.isDelete){
            Set<Id> sConIdOld = new Set<Id>();
            for(Asset__c asset : Trigger.Old){
                if(asset.Account__c != null){
                    sConIdOld.add(asset.Account__c);
                }
            } 
            AssetTriggerHandler batchT = new AssetTriggerHandler(sConIdOld);
            Id batchId = Database.executeBatch(batchT, 50);
        }
    }
    
   
}
