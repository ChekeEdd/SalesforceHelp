public class AnimalsCallouts {
    
    public class AnimalModel{
        
        public String id_x;
        public String name;
        public String says;
        public String eats;  
        
    }
    
    @Future(callout=true)
    public static void mainGetAnimal(Set<Id> id_s){
        
        Http http = new Http();
        Map<String,AnimalModel> animalM = new Map<String,AnimalModel>();
        
        List<Animal__c> animals = [SELECT Name, says__c, eats__c, extId__c
                  FROM animal__c
                  WHERE Id = :id_s
                  AND extId__c != null];
        for(Animal__c an : animals){
            String extid = an.extId__c;
            if (animalM.keySet().contains(extid) == false){
                AnimalModel mod = getAnimalById(extid, http);
                animalM.put(extid, mod);
                }
            
        }
        update animals;
    }
    
    
    
    public static HttpRequest getRequestId(String Ids){
        
        HttpRequest result = new HttpRequest();
      	String endPoint = 'https://th-apex-http-callout.herokuapp.com/animals/';
  		result.setEndpoint(endPoint + Ids);
  		result.setMethod('GET');
      	return result;
    }
    
    public static AnimalModel getAnimalById(String Ids, Http http){
        
        AnimalModel animalmod;
        HttpResponse response = http.send(getRequestId(Ids));
        if(response.getStatusCode() == 200) {
            String body = response.getBody().replace('"id"','"id_x"')
              .replace('{"animal":','')
              .replace('}}','}');
            animalmod = (AnimalModel)JSON.deserialize(body,AnimalModel.class);            
        } else {
          throw new CalloutException('Status code: ' + response.getStatusCode());
      }
        return animalmod;
        
    } 
}
