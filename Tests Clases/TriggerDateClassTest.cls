@isTest
private class TriggerDateClassTest {
    
    @TestSetup private static void setupmethod(){
        
        Company__c company1 = new Company__c();
        company1.Name = 'NCsoft';
        insert company1;
        
    }
    
    @isTest private static void main(){
        
        Company__c company1 = [select id from Company__c];
        User__c user1 = new User__c();
        user1.Name = 'Greg';
        user1.Company__c = company1.Id;
        Test.startTest();
        insert user1;
        Test.stopTest();
        company1 = [select Date__c from Company__c];
        System.assertEquals(Date.today(), company1.Date__c);
        
        
    } 
}
