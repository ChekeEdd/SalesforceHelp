public class AnimalController {
    
    @AuraEnabled
    public static List<Animal__c> getSameExternalIdAnimals(Id animalId) {
        Animal__c animalC = [SELECT Id, extId__c FROM Animal__c WHERE Id = :animalId];
        System.debug(animalC);
        List<Animal__c> result = [SELECT Id, Name, Says__c, Eats__c, extId__c
                FROM Animal__c
                WHERE extId__c = :animalC.extId__c
                AND Id != :animalId];
        System.debug(result);
        return result;
    }    
    
}