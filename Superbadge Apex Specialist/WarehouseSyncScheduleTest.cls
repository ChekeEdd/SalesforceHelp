@isTest
public class WarehouseSyncScheduleTest {
    
    @isTest private static void test() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());   		
        String cron_exp =  '0 0 0 3 9 ? 2022';
        
        Test.startTest();        
        String jobId = System.schedule('testScheduledApex', cron_exp, new WarehouseSyncSchedule());        
        Test.stopTest();
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                          NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals(cron_exp,ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}