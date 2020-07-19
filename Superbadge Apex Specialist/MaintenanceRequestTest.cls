@isTest
private class MaintenanceRequestTest{
    @testSetup
    static void setup(){
        //Equipment SETUP
        List<Product2> equipmentsList = new List<Product2>();
        Product2 eqip = new Product2(Name = 'Test Equipment',
                                     Maintenance_Cycle__c = 10,
                                     Cost__c = 100,
                                     Current_Inventory__c = 10,
                                     Lifespan_Months__c = 10,
                                     Replacement_Part__c = true,
                                     Warehouse_SKU__c = 'abc');
        equipmentsList.add(eqip);
        insert equipmentsList;
    }
    @isTest
    static void testMaintenanceRequest(){
        List<Case> insertList = new List<Case>();
        List<Case> updateList = new List<Case>();
        Id equipId = [SELECT Id FROM Product2 LIMIT 1].get(0).Id;
        Case newCase = new Case(Type = 'Routine Maintenance',Status = 'New', Origin = 'Phone');
        newCase.Equipment__c = equipId;
        insertList.add(newCase);
        Case mrInsert = new Case(Type = 'Routine Maintenance2', Status = 'New', Origin = 'Phone');
        mrInsert.Equipment__c = equipId;
        insertList.add(mrInsert);
        Test.startTest();
        insert insertList;
        System.assertEquals(2, insertList.size());
        for(Case case_i : insertList){
            case_i.Status = 'Closed';
            updateList.add(case_i);
        }
        update updateList;
        System.assertEquals(2, updateList.size());
        Test.stopTest();
    }
}