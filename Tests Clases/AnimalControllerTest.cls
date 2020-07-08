@isTest
public class AnimalControllerTest {
    
    @istest private static void testcontroller(){
        
        Animal__c animal1 = new Animal__c(Name = 'Fish', extId__c = '4', Says__c = 'uaua', Eats__c = 'Fish');
        insert animal1;
        animal1 = [select id from Animal__c];
        Test.startTest();
        AnimalController.getSameExternalIdAnimals(animal1.id);
        Test.stopTest();
        animal1 = [select extId__c from Animal__c where id = :animal1.id];
        System.assertEquals('4', animal1.extId__c);
        
    }
    
    @istest private static void findAnimalTest(){
        
        Animal__c animal1 = new Animal__c();
		animal1.Name = 'fox';
		animal1.Says__c = 'chicken';
		animal1.Eats__c = 'checken';
		animal1.extId__c = '4';
		insert animal1;
        animal1 = [select id from Animal__c];
        Test.startTest();
		AnimalController.findAnimals(animal1.id, 'fox');
        Test.stopTest();
        animal1 = [select Name from Animal__c where id = :animal1.id];
        System.assertEquals('fox', animal1.Name);
    }

}