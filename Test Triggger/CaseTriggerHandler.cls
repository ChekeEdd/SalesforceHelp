public class CaseTriggerHandler { 
     
     public static void caseCount(List<Case> lstCase){ 
         List<Account> acc = new List<Account>();         
         List<Contact> lstContact = new List<Contact>();
         Set<Id> sConId = new Set<Id>();
         for(Case cs: lstCase){
             if(cs.ContactId != null){
                 sConId.add(cs.ContactId);
             }
         }
         
         if(sConId != null && sConId.size() > 0){
             lstContact = [select id, Account.Number_of_open_Cases__c, (select id, status from Cases where status != 'Closed') from Contact where id in: sConId];
             if(lstContact.size() > 0){                 
                 for(Contact ct: lstContact){
                     
                     Account contAcc = new Account(Id=ct.AccountId, Number_of_open_Cases__c = ct.Cases.size());                     
                     acc.add(contAcc);
                     
                 }
             }update acc;
         } 
     }     
}
