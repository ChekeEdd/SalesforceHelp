@isTest
public class WidgetLWCHelperTest {
    @isTest
    private static void fetchDataTestOne(){         
        Profile devProfile = [SELECT Id FROM Profile WHERE Name = 'Developers'];        
        User newTestUser = TestUtils.createUser(devProfile.Id);
        newTestUser.TimeZoneSidKey = 'Europe/Athens';
        insert newTestUser;        
        Employee__c testEmployee =  TestUtils.createEmployee(newTestUser.Id, newTestUser.Name, 'Salesforce Developer');        
        insert testEmployee;        
        Test.startTest();
        Map<String, Object> result;        
        System.runAs(newTestUser){
            System.debug(Date.today());
            result = WidgetLWCHelper.fetchData();            
            System.debug(result);
        }   
        
        System.debug(result);       
        Test.stopTest();        
        List<WorkLog__c> workLog = [SELECT Actual__c FROM WorkLog__c WHERE Employee__c =: testEmployee.id];
        Double currentWorklog = 0.00;        
        for(WorkLog__c wl: workLog){            
            currentWorklog += wl.Actual__c;
        }
        
        List<Work_Time__c> workTime = [SELECT Duration__c FROM Work_Time__c WHERE Employee__c =: testEmployee.id];
        Double currentWorktime = 0.00;
        for(Work_Time__c wt: workTime){
            currentWorktime += wt.Duration__c;
        }
        
        System.debug(result.get('currentworktime')); 
        System.debug(result.get('currentWorklog'));
        System.assertEquals(currentWorktime, result.get('currentworktime'));
        System.assertEquals(currentWorklog, result.get('currentWorklog'));
        System.assertEquals(Label.EmployeeShouldWorkToday, result.get('message')); 
              
    }
    
    
    
    @isTest
    private static void fetchDataTestTwo(){         
        Profile devProfile = [SELECT Id FROM Profile WHERE Name = 'Developers'];        
        User newTestUser = TestUtils.createUser(devProfile.Id);
        newTestUser.TimeZoneSidKey = 'Europe/Athens';
        insert newTestUser;        
        Employee__c testEmployee =  TestUtils.createEmployee(newTestUser.Id, newTestUser.Name, 'Salesforce Developer');        
        insert testEmployee;        
        Test.startTest();
        Map<String, Object> result;        
        System.runAs(newTestUser){
            
            Work_Time__c newWorkTime =  TestUtils.createWorkTime(testEmployee.Id, Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(), 10, 0, 0), Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(),20, 0, 0));
            insert newWorkTime;            
            
            System.debug(Date.today());
            result = WidgetLWCHelper.fetchData();            
            System.debug(result);
        }   
        
        System.debug(result);       
        Test.stopTest();         
        List<WorkLog__c> workLog = [SELECT Actual__c FROM WorkLog__c WHERE Employee__c =: testEmployee.id];
        Double currentWorklog = 0.00;        
        for(WorkLog__c wl: workLog){            
            currentWorklog += wl.Actual__c;
        }
        
        List<Work_Time__c> workTime = [SELECT Duration__c FROM Work_Time__c WHERE Employee__c =: testEmployee.id];
        Double currentWorktime = 0.00;
        for(Work_Time__c wt: workTime){
            currentWorktime += wt.Duration__c;
        }
                        
        System.debug(result.get('currentworktime')); 
        System.debug(result.get('currentWorklog'));
        System.assertEquals(currentWorktime, result.get('currentworktime'));
        System.assertEquals(currentWorklog, result.get('currentWorklog'));
        System.assertEquals(Label.WorkLogsAfterEightHours, result.get('message')); 
              
    }
    
    
    @isTest
    private static void fetchDataTestThree(){         
        Profile devProfile = [SELECT Id FROM Profile WHERE Name = 'Developers'];        
        User newTestUser = TestUtils.createUser(devProfile.Id);
        insert newTestUser;        
        Employee__c testEmployee =  TestUtils.createEmployee(newTestUser.Id, newTestUser.Name, 'Salesforce Developer');        
        insert testEmployee;        
        Test.startTest();
        Map<String, Object> result;        
        System.runAs(newTestUser){
            
            Work_Time__c newWorkTime =  TestUtils.createWorkTime(testEmployee.Id, Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(), 6, 0, 0), Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(),16, 0, 0));
            insert newWorkTime;
            
            WorkLog__c newWorkLog = TestUtils.createWorkLog(testEmployee.Id, 'Development');
            insert newWorkLog;
            
            
            System.debug(Date.today());
            result = WidgetLWCHelper.fetchData();            
            System.debug(result);
        }   
        
        System.debug(result);       
        Test.stopTest();         
        List<WorkLog__c> workLog = [SELECT Actual__c FROM WorkLog__c WHERE Employee__c =: testEmployee.id];
        Double currentWorklog = 0.00;        
        for(WorkLog__c wl: workLog){            
            currentWorklog += wl.Actual__c;
        }
        
        List<Work_Time__c> workTime = [SELECT Duration__c FROM Work_Time__c WHERE Employee__c =: testEmployee.id];
        Double currentWorktime = 0.00;
        for(Work_Time__c wt: workTime){
            currentWorktime += wt.Duration__c;
        }
        
        String msg = 'Everything fine';        
        
        System.debug(result.get('currentworktime')); 
        System.debug(result.get('currentWorklog'));
        System.assertEquals(currentWorktime, result.get('currentworktime'));
        System.assertEquals(currentWorklog, result.get('currentWorklog'));
        System.assertEquals(msg, result.get('message')); 
              
    }
    
    @isTest
    private static void fetchDataTestFour(){         
        Profile devProfile = [SELECT Id FROM Profile WHERE Name = 'Developers'];        
        User newTestUser = TestUtils.createUser(devProfile.Id);
        insert newTestUser;        
        Employee__c testEmployee =  TestUtils.createEmployee(newTestUser.Id, newTestUser.Name, 'Salesforce Developer'); 
        testEmployee.RequireWorklog__c = false;  //Test without 
        insert testEmployee;        
        Test.startTest();
        Map<String, Object> result;        
        System.runAs(newTestUser){ 
            
            Work_Time__c newWorkTime =  TestUtils.createWorkTime(testEmployee.Id, Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(), 10, 0, 0), Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(),20, 0, 0));
            insert newWorkTime;            
            
            System.debug(Date.today());
            result = WidgetLWCHelper.fetchData();            
            System.debug(result);
        }   
        
        System.debug(result);       
        Test.stopTest();         
        List<WorkLog__c> workLog = [SELECT Actual__c FROM WorkLog__c WHERE Employee__c =: testEmployee.id];
        Double currentWorklog = 0.00;        
        for(WorkLog__c wl: workLog){            
            currentWorklog += wl.Actual__c;
        }
        
        List<Work_Time__c> workTime = [SELECT Duration__c FROM Work_Time__c WHERE Employee__c =: testEmployee.id];
        Double currentWorktime = 0.00;
        for(Work_Time__c wt: workTime){
            currentWorktime += wt.Duration__c;
        }
        
        String msg = 'Everything fine';        
        
        System.debug(result.get('currentworktime')); 
        System.debug(result.get('currentWorklog'));
        System.assertEquals(currentWorktime, result.get('currentworktime'));
        System.assertEquals(currentWorklog, result.get('currentWorklog'));
        System.assertEquals(msg, result.get('message')); 
              
    }

}