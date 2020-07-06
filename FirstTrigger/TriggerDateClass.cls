public class TriggerDateClass {
    
    //Getting Id's from parent object
    private static Set<Id> companyId(List<User__c> listusr) {
        
        Set<Id> totalid = new Set<Id>();
        for (User__c user : listusr) {
            if (user.Company__c != null){
				totalid.add(user.Company__c);         
            }    
        }
        return totalid;
    }
    
    //Select field from parent object
    private static Map<Id, Company__c> getcompany(Set<Id> totalid){
        return new Map<Id, Company__c>([SELECT ID, Date__c
                                        FROM Company__c
                                        WHERE ID IN :totalid]);
    }
    
    //Updating field
    private static void updateDate(Map<Id, Company__c> company){
        List<Company__c> complst = new List<Company__c>();
        Company__c cmpny;
        for(Id cmpID : company.keySet()){
            cmpny = company.get(cmpID);
            cmpny.Date__c = Date.today();
            complst.add(cmpny);            
        }
        if (complst.size() > 0){
            update complst;
        }
    }
    
    //Main point for Trigger
    public static void main(List<User__c> usertrg){
        Set<Id> compID = companyId(usertrg);
        Map<Id, Company__c> getcmpn = getcompany(compID);
        updateDate(getcmpn);    
        
    }
}