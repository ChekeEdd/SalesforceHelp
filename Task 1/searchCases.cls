public class searchCases {
    
    @AuraEnabled
    public static ResponseWrapper findCase(String KeyWord, String typeField) {
        String searchKey = '%' + KeyWord + '%';
        String caseNumber = 'CaseNumber';
        List<String> fields = new List<String>();
        if(caseNumber.equals(typeField)){
            fields.add(caseNumber);            
        }
        else {
            fields.add(caseNumber);
            fields.add(typeField);
        }        
        String query = 'SELECT ' + String.join(fields, ', ') + ' FROM Case WHERE '+ typeField +' LIKE \'' + searchKey +'\' LIMIT 50';
        //System.debug('query ' + query);            
        List<Case> caseList = Database.query(query);  
        System.debug(caseList);         
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Case.fields.getMap();
        System.debug(fieldMap);
        Schema.DescribeFieldResult dfr = fieldMap.get('CaseNumber').getDescribe();
        Map<String, String> labels = new Map<String, String>{'fieldName' => 'CaseNumber', 'label' => dfr.getLabel() , 'type' => 'text'};
            Schema.DescribeFieldResult dfr2 = fieldMap.get(typeField).getDescribe();
        Map<String, String> labels2 = new Map<String, String>{'fieldName' => typeField, 'label' => dfr2.getLabel() , 'type' => 'text'};
            List<Map<String, String>> listOfMaps = new List<Map<String, String>>{labels,labels2};           
                
                ResponseWrapper resp = new ResponseWrapper(listOfMaps, caseList);
        System.debug(resp);
        return resp;
    }   
    
    
    public class ResponseWrapper {
        @AuraEnabled
        public List<Case> objects;
        @AuraEnabled
        public List<Map<String, String>> listOfMaps;
        
        public ResponseWrapper(List<Map<String, String>> listOfMaps, List<Case> objects) {
            this.listOfMaps = listOfMaps;
            this.objects = objects;
            
        }
        
    }
}