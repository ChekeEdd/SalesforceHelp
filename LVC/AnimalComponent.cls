public with sharing class AnimalComponent {
    
    @AuraEnabled
    public static List<animal__c> getAnimalByExternalId(String externalId) {
        System.debug(externalId);
        List<animal__c> result = [SELECT Id, Name, says__c, eats__c, extId__c 
                FROM animal__c 
                WHERE extId__c = :externalId];
        
        return result;        
        
        
        
        
    }

}