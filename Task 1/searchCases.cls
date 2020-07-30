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
        String query = 'SELECT Id, ' + String.join(fields, ', ') + ' FROM Case WHERE '+ typeField +' LIKE \'' + searchKey +'\' LIMIT 50';
        System.debug('query ' + query);            
        List<Case> caseList = Database.query(query);  
        System.debug(caseList);         
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Case.fields.getMap();
        System.debug(fieldMap);
        Schema.DescribeFieldResult dfr = fieldMap.get('CaseNumber').getDescribe();
        Map<String, Object> link = new Map<String, Object>{ 'target' => '_blank', 'label' => new Map<String, String>{'fieldName' => 'CaseNumber'}};
        Map<String, Object> labels = new Map<String, Object>{'fieldName' => 'CaseLink', 'label' => dfr.getLabel() , 'type' => 'url' , 'typeAttributes' => link};
        Schema.DescribeFieldResult dfr2 = fieldMap.get(typeField).getDescribe();
        Map<String, Object> labels2 = new Map<String, Object>{'fieldName' => typeField, 'label' => dfr2.getLabel() , 'type' => 'text'};   
        List<Map<String, Object>> listOfMaps = new List<Map<String, Object>>{labels,labels2};             
        ResponseWrapper resp = new ResponseWrapper(listOfMaps, caseList);
        System.debug(resp);
        return resp;
    }   
    
    
    public class ResponseWrapper {
        @AuraEnabled
        public List<Case> objects;
        @AuraEnabled
        public List<Map<String, Object>> listOfMaps;
        
        public ResponseWrapper(List<Map<String, Object>> listOfMaps, List<Case> objects) {
            this.listOfMaps = listOfMaps;
            this.objects = objects;
            
        }
        
    }
}