@isTest private class WarehouseCalloutServiceTest {
    
    @TestSetup private static void setupmethod() {
        
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock('[{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}]', 200));
        
    }
    
    
    @isTest private static void WarehouseEquipmentSync(){
        
        Test.startTest();
        // This causes a fake response to be sent from the class that implements HttpCalloutMock. 
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();        
        System.assertEquals(1, [SELECT count() FROM Product2]);
              
        
    }
    
}