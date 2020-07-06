global class DeleteRecord implements Database.Batchable<sObject>,Schedulable{
    
    static Date today = Date.today();
    
    public Database.QueryLocator start(Database.BatchableContext context)
    {
        return Database.getQueryLocator('Select ID from Animal__c where CreatedDate < :today');
    }

    public void execute(Database.BatchableContext context, List<Animal__c> records)
    {
        delete records;
    }

    global void execute(SchedulableContext ctx) 
    {
        Database.executeBatch(new DeleteRecord());
    }
    
    public void finish(Database.BatchableContext context){
        system.debug('delete have done');
    }
}