trigger AnimalTrigger on Animal__c (after insert) {
    
    AnimalsCallouts.mainGetAnimal(Trigger.newMap.keySet());

}