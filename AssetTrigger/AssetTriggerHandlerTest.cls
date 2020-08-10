@isTest
public class AssetTriggerHandlerTest {
    
    @TestSetup private static void setupmethod(){
        
        Account newAcc = new Account (Name='Test');
        insert newAcc;
        List<Asset__c> assetList = new List<Asset__c>();
        for(Integer i = 0 ; i < 20; i++){
            Asset__c newAsset = new Asset__c(Account__c = newAcc.Id);
            assetList.add(newAsset);
        }
       
        insert assetList;
        
        
    }
    
    
    @isTest private static void countAssetTestInsert(){
        Account newAcc = [select id from Account];
        List<Asset__c> assetList = [select id, Account__c from Asset__c];
        Set<Id> newSet = new Set<Id> ();
        for(Asset__c asse_i: assetList){
            newSet.add(asse_i.Account__c);   
        }
        
        Test.startTest();
        
        AssetTriggerHandler cauntAsset = new AssetTriggerHandler(newSet);
        Database.executeBatch(cauntAsset);
        
        Test.stopTest();
        
        Account testAccount = [SELECT Id,Number_of_Assets__c FROM Account WHERE Id=:newAcc.Id LIMIT 1];
        System.assertEquals(20, testAccount.Number_of_Assets__c);
    }   
    
    
   
    
    
}
