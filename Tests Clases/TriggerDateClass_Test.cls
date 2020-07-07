@isTest
private class TriggerDateClass_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Company__c company_Obj = new Company__c(Date__c = DateTime.now());
    Insert company_Obj; 
    test.stopTest();
  }
  static testMethod void test_main_UseCase1(){
    List<Company__c> company_Obj  =  [SELECT Date__c from Company__c];
    System.assertEquals(true,company_Obj.size()>0);
    TriggerDateClass obj01 = new TriggerDateClass();
    TriggerDateClass.main(new List<User__c>());
  }
    
}