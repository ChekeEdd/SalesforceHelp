@isTest
public class CaseCountTriggerHandlerTest {   
    
    
    
    @isTest private static void testCaseCount(){  
        
        Account acc1 = new Account(Name = 'Moon', Number_of_open_Cases__c = 0);
        insert acc1;
        Contact con1 = new Contact(FirstName = 'xyzFirst',LastName = 'XyZLast', AccountId = acc1.Id);
        insert con1;
        
        
        Case insertTestCase = new Case(Origin = 'Email', Status = 'New', ContactId = con1.Id);  
        Case insertTestCase1 = new Case(Origin = 'Email', Status = 'Closed', ContactId = con1.Id);
        Test.startTest();
        insert insertTestCase;
        insert insertTestCase1;
        Test.stopTest();        
        acc1 = [select id, Number_of_open_Cases__c from Account];
        System.assertEquals(1, acc1.Number_of_open_Cases__c);
    }

}
