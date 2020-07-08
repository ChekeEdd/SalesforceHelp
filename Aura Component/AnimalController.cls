public class AnimalController {
    
    @AuraEnabled
    public static List<animal__c> getSameExternalIdAnimals(Id aID) {
        animal__c getExtid = [SELECT Id, extId__c FROM animal__c WHERE Id = :aID];
        List<animal__c> result = [SELECT Id, Name, says__c, eats__c, extId__c
                FROM animal__c
                WHERE extId__c = :getExtid.extId__c
                AND Id != :aID];
        System.debug(result);
        return result;
    } 
    
    
 	@AuraEnabled
    public static List<animal__c> findAnimals(Id aID, String searchanimal) {
        animal__c getExtid = [SELECT Id, extId__c FROM animal__c WHERE Id = :aID];
        List<List<animal__c>> animals = [FIND :searchanimal IN ALL FIELDS
                                         RETURNING animal__c(Id,Name,says__c,eats__c,extId__c
										 WHERE extId__c = :getExtid.extId__c
                                         AND Id != :aID)];
        return animals.get(0);
    }
    
}