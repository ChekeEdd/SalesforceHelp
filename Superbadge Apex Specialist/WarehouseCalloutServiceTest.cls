@isTest private class WarehouseCalloutServiceTest {
    
    @TestSetup private static void setupmethod() {
        
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock('[{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}]', 200));
        
    }
    
    
    @isTest private static void WarehouseEquipmentSync(){
        
        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();        
        Product2 equipment = [SELECT Id, Current_Inventory__c, Replacement_Part__c, Name, Maintenance_Cycle__c, Lifespan_Months__c, Cost__c, Warehouse_SKU__c
                              FROM Product2];
        System.assertEquals('Generator 1000 kW', equipment.Name);
        System.assertEquals('100003', equipment.Warehouse_SKU__c);
        
        
    }
    
}
