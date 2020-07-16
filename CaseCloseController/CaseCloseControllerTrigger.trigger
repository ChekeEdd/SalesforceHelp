trigger AnimalTrigger on Animal__c (after insert) {    
    
    if(Trigger.isAfter){
        AnimalsCallouts.mainGetAnimal(Trigger.newMap.keySet());        
    }

}