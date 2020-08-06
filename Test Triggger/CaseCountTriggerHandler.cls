public class CaseCountTriggerHandler { 
     
     public static void caseCount(List<Case> lstCase){ 
         
         List<Contact> lstContact = new List<Contact>();
         Set<Id> sConId = new Set<Id>();
         for(Case cs: lstCase){
             if(cs.ContactId != null){
                 sConId.add(cs.ContactId);
             }
         }
         if(sConId != null && sConId.size() > 0){
             lstContact = [select id, Account.Number_of_open_Cases__c, (select id, status from Cases) from Contact where id in: sConId];
             if(lstContact.size() > 0){
                 for(Contact ct: lstContact){
                     System.debug('cases ' + ct.Cases.size());
                     ct.Account.Number_of_open_Cases__c = ct.Cases.size();
                     System.debug(ct.Account.Number_of_open_Cases__c);
                     Integer opencases = 0;
                     for(Case c : ct.Cases){
                         if(c.Status != 'Closed')
                             opencases++;
                     }
                     ct.Account.Number_of_open_Cases__c = opencases;
                 }
             }update lstContact;
         } 
     }
     
}
