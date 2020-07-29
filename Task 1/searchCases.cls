public class searchCases {
    
    @AuraEnabled
    public static ResponseWrapper findCase( String KeyWord, String typeField) {
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
        System.debug('query ' + query);            
        List<Case> caseList = Database.query(query);  
        System.debug(caseList);       
        return new ResponseWrapper(fields, caseList);
    }    
    
    
    public class ResponseWrapper {
        @AuraEnabled
        public List<String> fields;
        @AuraEnabled
        public List<Case> objects;
        
        public ResponseWrapper(List<String> fields, List<Case> objects) {
            this.fields = fields;  
            this.objects = objects;
        }
        
    }
}