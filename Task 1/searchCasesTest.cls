@isTest
public class searchCasesTest { 
    
    @isTest private static void fetchCaseTest(){
        Case insertTestCase = new Case(Origin = 'Email', Status = 'Closed');
        insert insertTestCase ; 
        test.startTest();        
        searchCases.ResponseWrapper resp = searchCases.findCase('Closed','Status');
        test.stopTest();
        System.assertEquals(2, resp.listOfMaps.size());
        Case testCase = [SELECT Id, CaseNumber, Status FROM Case LIMIT 1];
        System.assertEquals(true ,resp.objects.contains(testCase));
    }
    
}