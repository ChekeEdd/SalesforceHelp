@isTest
public class ContactTriggerHandlerTest {
    
    @isTest private static void createContact(){
        
        Account account1 = new Account(Name = 'Moon', Number_of_open_Cases__c = 6);
        insert account1;        
        
        Contact con1 = new Contact(FirstName = 'xyzFirst',LastName = 'XyZLast', AccountId = account1.Id);
        
        Database.SaveResult sr = Database.insert(con1, false);
        System.assert(!sr.isSuccess());
        System.assert(sr.getErrors().size() > 0);
        
        for(Database.Error err: sr.getErrors()){
            System.assertEquals(System.StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, err.statuscode);
            System.assert(err.getMessage().contains('Cant create contact if account has more than 5 cases'));
        }
        
        
    }

}