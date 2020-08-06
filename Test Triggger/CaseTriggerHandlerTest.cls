@isTest
public class CaseCountTriggerHandlerTest {   
    
    
    
    @isTest private static void testCaseCount(){       
        
        Account acc1 = new Account(Name = 'Moon', Number_of_open_Cases__c = 0);
        insert acc1;
        Account acc2 = new Account(Name = 'Moooon Head', Number_of_open_Cases__c = 0);
        insert acc2;
        Contact con1 = new Contact(FirstName = 'xyzFirst',LastName = 'XyZLast', AccountId = acc1.Id);
        insert con1;
        Contact con2 = new Contact(FirstName = 'xyzFirst',LastName = 'XyZLast', AccountId = acc2.Id);
        insert con2;
        
        
        List<Case> caseList = new List<Case>{
            new Case(Origin = 'Email', Status = 'New', ContactId = con1.Id),
                new Case(Origin = 'Email', Status = 'Closed', ContactId = con1.Id),
                new Case(Origin = 'Email', Status = 'New', ContactId = con1.Id, AccountId = acc2.Id)
        };  
        Test.startTest();
        insert caseList;
        Test.stopTest();        
        acc1 = [select id, Number_of_open_Cases__c from Account where id =:acc1.Id];
        acc2 = [select id, Number_of_open_Cases__c from Account where id =:acc2.Id];
        System.assertEquals(2, acc1.Number_of_open_Cases__c);
        System.assertEquals(0, acc2.Number_of_open_Cases__c);
    }

}
