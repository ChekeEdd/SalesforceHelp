public with sharing class WarehouseCalloutService {
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
        makeGetCallout();
    }
    
    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> equipmentToUpdate = new List<Product2>();
            for(Object result : results){
                Map<String,Object> resultMap = (Map<String,Object>) result;
                Product2 newEquipment = new Product2();                
                newEquipment.Replacement_Part__c = (Boolean)resultMap.get('replacement');
                newEquipment.Current_Inventory__c = (Integer)resultMap.get('quantity');
                newEquipment.Name = (String)resultMap.get('name');
                newEquipment.Maintenance_Cycle__c = (Decimal)resultMap.get('maintenanceperiod');
                newEquipment.Lifespan_Months__c = (Integer)resultMap.get('lifespan');
                newEquipment.Cost__c = (Decimal)resultMap.get('cost');
                newEquipment.Warehouse_SKU__c = (String)resultMap.get('sku');              
                equipmentToUpdate.add(newEquipment);  
            }
            upsert equipmentToUpdate;
            System.debug(equipmentToUpdate);
        }
        return response;
    }
}