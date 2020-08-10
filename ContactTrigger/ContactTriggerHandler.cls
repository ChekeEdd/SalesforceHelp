public class ContactTriggerHandler {
    
    public static void createContact(List<Contact> conList){
        
        Set<Id> sConId = new Set<Id>();
        for(Contact ct: conList){
            if(ct.AccountId != null){
                sConId.add(ct.AccountId);
            }
        }
        List<Account> accList = [select id, Number_of_open_Cases__c from Account where id in: sConId];
        for(Account acc: accList){
            if(acc.Number_of_open_Cases__c > 4){
                for(Contact ct: conList){
                    ct.addError('Cant create contact if account has more than 5 cases');
                }
            }
        }
        
          
  }
    
}