@IsTest
public class TestWebServices {
    
    @isTest static void testGetAnimalById() {
        
        String recordID = '2';
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/' + recordID;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Animal__c animalC = AnimalWebService.getrecord();
        System.assert(animalC != null);
        System.assertEquals('2', animalC.extId__c);
        
    }
    
    @isTest static void testCreateAnimal() {
        
        ID thisAnimalId = AnimalWebService.createAnimals('Fish', 'eats', 'says', '14');
        System.assert(thisAnimalId != null);
        Animal__c thisAnimal = [SELECT Id, Name FROM Animal__c WHERE Id = :thisAnimalId];
        System.assert(thisAnimal != null);
        System.assertEquals(thisAnimal.Name, 'Fish');		        
        
    }
    
    @isTest static void testDeleteCase() {
        
        String recordID = '2';
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/' + recordID;
        request.httpMethod = 'GET';
        RestContext.request = request;
        AnimalWebService.deleteAnimal();
        List<Animal__c> animalList = [SELECT Id, extId__c FROM Animal__c WHERE extId__c = :recordID];
        System.assert(animalList.size() == 0);
        
    }   
    
    @isTest static void testUpsertAnimal() {
        
        ID thisAnimalId = AnimalWebService.upsertAnimal(null, 'Fish', 'eats', 'says', '14');
        System.assert(thisAnimalId != null);
        Animal__c animal1 = [SELECT Id, Name FROM Animal__c WHERE id = :thisAnimalId];
        System.assert(animal1 != null);
        System.assertEquals(animal1.Name, 'Fish');
        
        ID thisAnimalId2 = AnimalWebService.upsertAnimal(null, 'Greg', 'Fish', 'says', '14');
        System.assert(thisAnimalId2 != null);
        Animal__c animal2 = [SELECT Id, Name FROM Animal__c WHERE id = :thisAnimalId2];
        System.assert(animal2 != null);
        System.assertEquals(animal2.Eats__c, 'Fish');
        
    }

}