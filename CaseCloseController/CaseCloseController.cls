public class CaseCloseController {
  
    public static void caseError(Case[] cases) {
        
    	Set<Id> closedCases = new Set<Id>();
    	Map<Id, Case> caseMap = new Map<Id, Case>(cases);
    	for(Case record: cases) {
      		if(record.Status == 'Closed') {
        		closedCases.add(record.Id);
      		}
    	}
    	if(!closedCases.isEmpty()) {
      		Set<Id> openCases = new Map<Id, AggregateResult>([
        	SELECT ParentId Id
        	FROM Case
        	WHERE ParentId = :closedCases AND 
            	IsClosed = FALSE
        	GROUP BY ParentId]).keySet();
      		for(Id caseId: openCases) {
        		caseMap.get(caseId).addError('You must close all child cases first.');
      		}
    	}
  	}
}
