@isTest
public class AnimalsCalloutsTest {
    
    @TestSetup private static void setupmethod() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalsCalloutMock('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}', 200));
        Animal__c animal1 = new Animal__c(extId__c = '1');
        insert animal1;
        
    }
    
    
    
    @isTest static void testCallout() {
        
        Animal__c animal1 = [select id from Animal__c];
        Test.startTest();
        AnimalsCallouts.mainGetAnimal(new Set<Id>{animal1.id});
        Test.stopTest();
        animal1 = [select Name, Says__c, Eats__c, extId__c from Animal__c where id = :animal1.id];
        System.assertEquals('chicken', animal1.Name);

        
    }


}