@RestResource(urlMapping='/Animals/*')
global with sharing class AnimalWebService {
    
    	
    
    @HttpGet
    global static Animal__c getrecord(){
        RestRequest request = RestContext.request;
        String animalId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);        
        Animal__c result = [SELECT Name, Eats__c, Says__c, extId__c
                        FROM Animal__c
                        WHERE extId__c = :animalId];
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(result));                
		return result;       
    }
    
    @HttpPost
    global static Id createAnimals(String name, String eats, String says, String animalId) {
        Animal__c thisAnimal = new Animal__c(
            extId__c = animalId,
            Name = name,
            Eats__c = eats,
            Says__c = says
            );
        insert thisAnimal;
        return thisAnimal.Id;
    } 
    
    @HttpDelete
    global static void deleteAnimal() {
        RestRequest request = RestContext.request;
        String animalId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Animal__c thisAnimal = [SELECT extId__c FROM Animal__c WHERE extId__c = :animalId];
        delete thisAnimal;
    }
    
    @HttpPut
    global static Id upsertAnimal(String Id, String name, String eats, String says, String animalId) {
        Animal__c thisAnimal = new Animal__c(
            Id = Id,
            extId__c = animalId,
            Name = name,
            Eats__c = eats,
            Says__c = says
            );
        upsert thisAnimal;
        return thisAnimal.Id;
    }
     

}