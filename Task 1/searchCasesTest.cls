@isTest
public class searchCasesTest {
    
   @TestSetup private static void setupmethod(){
        
        Case case1 = new Case(Origin = 'Email', Status = 'New', Subject = 'generator');
        insert case1;        
    }
    
    @isTest private static void findCaseTest(){
        
        Case case1 = [select id from Case];
        Test.startTest();
        searchCases.findCase('generator', 'Subject');
        Test.stopTest();
        case1 = [select id, Subject from case];
        System.assertEquals('generator', case1.Subject);
        
    }

}