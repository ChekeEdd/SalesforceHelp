public with sharing class WidgetLWCHelper {
    
    //init method that will fetch data for widget.
    public static Map<String, Object> fetchData(){
        
        String employeeId;
        Boolean isLive = false;
        Double currentWorklog = 0.00;  
        Double currentWorktime = 0.00;               
        Employee__c employeeIdq = [select Id, RequireWorklog__c from Employee__c where User__c =: UserInfo.getUserId()];        
        
        List<Work_Time__c> workTimes = [SELECT Id, Start__c, End__c, Duration__c
                                        FROM Work_Time__c 
                                        WHERE Employee__c =:employeeIdq.id
                                        AND Date__c =:Date.today()];
        System.debug(workTimes);
        List<Worklog__c> workLogList = [SELECT id, Actual__c, Date__c 
                                        FROM Worklog__c 
                                        WHERE Employee__c =:employeeIdq.id 
                                        AND Date__c =: Date.today()];        
        
        for(Work_Time__c wt: workTimes){
            if(wt.Start__c != null){
                if (wt.End__c == null){                    
                    isLive = true;                    
                } 
                currentWorktime += wt.Duration__c;
            }  
        }       
        
        if(employeeIdq.RequireWorklog__c){
            for(Worklog__c wk: workLogList){
                currentWorklog += wk.Actual__c;
            }
        }

        String message = listOfMessages(String.valueOf(employeeIdq.id), employeeIdq.RequireWorklog__c);
        Map<String, Object> result = new Map<String, Object>{'employeeId' => employeeIdq.id, 'currentworktime' => currentWorktime, 'currentWorklog' => currentWorklog, 'isLive' => isLive, 'message' => message};
        System.debug(result);
        return result;
    }    
    
    //if user didn’t enter worlogs after 8 hours of total work time
    public static String workLogforToDay(String employeeId){
        Double currentWorktime = 0.00; //variable only for this method
        String workLogLabelMsg;        
        
        List<Work_Time__c> workTimes = [SELECT Id, Start__c, Duration__c
                                        FROM Work_Time__c 
                                        WHERE Employee__c =:employeeId
                                        AND Date__c =:Date.today()];
        List<Worklog__c> workLogList = [SELECT id, Actual__c 
                                        FROM Worklog__c 
                                        WHERE Employee__c =:employeeId 
                                        AND Date__c =: Date.today()];

        if(workLogList.isEmpty()){
            for(Work_Time__c wt: workTimes){               
                if(wt.Start__c != null && wt.Duration__c != null){
                    currentWorktime += wt.Duration__c;
                    if(currentWorktime >= 9.00){
                        workLogLabelMsg = System.Label.WorkLogsAfterEightHours;
                    }
                }
            }
        }
        return workLogLabelMsg;
    }    
    
    //if employee should work today(has no vacation or sick leave for today and today is not a holiday)
    //and has no opened worktime for today and it it already 10:00 AM
    public static String workForToDay(String employeeId){                
        String workForToDayMsg;       
        TimeZone tz = UserInfo.getTimeZone();
		Datetime timeNow;        
        Datetime tenAm = Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(), 10, 0, 0);
        if(Test.isRunningTest()){
            timeNow = Datetime.now().addSeconds((tz.getOffset(Datetime.now())/1000));           
        } 
        
        if(timeNow > tenAm.addSeconds((tz.getOffset(tenAm)/1000))){
            System.debug(Datetime.now().addHours(3) > tenAm.addSeconds((tz.getOffset(tenAm)/1000)));
            List<Holiday> holidays = [SELECT id, ActivityDate from Holiday
                                      WHERE ActivityDate = :Date.today()];            
            if(holidays.isEmpty()){
                
                List<Vacation__c> vacations = [SELECT id, Start_Date__c, End_Date__c 
                                               FROM Vacation__c 
                                               WHERE Employee__c =:employeeId
                                               AND Start_Date__c <= :Date.today()
                                               AND End_Date__c >= :Date.today()];
                List<Sick_Leave__c> sickLeaves = [SELECT id, Start_Date__c, End_Date__c
                                                  FROM Sick_Leave__c
                                                  WHERE Employee__c =:employeeId
                                                  AND Start_Date__c <= :Date.today()
                                                  AND End_Date__c >= :Date.today()];                
                if(vacations.isEmpty() && sickLeaves.isEmpty()){                    
                    List<Work_Time__c> workTimes = [SELECT Id, Start__c
                                                    FROM Work_Time__c 
                                                    WHERE Employee__c =:employeeId
                                                    AND Date__c =:Date.today() ];                    
                    if(workTimes.isEmpty()){
                        workForToDayMsg = System.Label.EmployeeShouldWorkToday;
                    }
                }
            }
        }        
        return  workForToDayMsg;        
    }
    
    //if user didn’t close his worktime in whole current month
    public static String workTimeMonth(String employeeId){
        
        String workTimeMonthMsg;
        List<Work_Time__c> workTimes = [SELECT Id, Start__c, End__c
                                        FROM Work_Time__c 
                                        WHERE Employee__c =:employeeId 
                                        AND Date__c = THIS_MONTH
                                        AND End__c = NULL];
        
        if(!workTimes.isEmpty()){
            workTimeMonthMsg = Label.UserDidntCloseWorktime;
        } 
        
        return workTimeMonthMsg;        
    }
    
    //if worklogs >  worktime AND if worklogs < worktime - 1 hour in whole current month
    public static String workTimeCompareworklogs(String employeeId){
        
        String workTimeCompareworkLogsMsg;
        Map<Date, Double> resultForCompare = new Map<Date, Double>();
        AggregateResult[] workTimes = [SELECT SUM(Duration__c)Duration__c, Date__c
                                       FROM Work_Time__c
                                       WHERE Employee__c =:employeeId
                                       AND Date__c = THIS_MONTH
                                       GROUP BY Date__c];
        AggregateResult[] workLogList = [SELECT SUM(Actual__c)Actual__c, Date__c
                                         FROM Worklog__c
                                         WHERE Employee__c =:employeeId
                                         AND Date__c = THIS_MONTH
                                         GROUP BY Date__c];
        
        if(!workTimes.isEmpty()){
            for(AggregateResult  ar: workTimes){
                resultForCompare.put((Date)ar.get('Date__c'), (Double)ar.get('Duration__c'));
            }
        }
        if(!workLogList.isEmpty()){
            for(AggregateResult agr: workLogList){
                if(resultForCompare.containsKey((Date)agr.get('Date__c'))){
                    if((Double)agr.get('Actual__c') > resultForCompare.get((Date)agr.get('Date__c'))){
                        workTimeCompareworkLogsMsg = Label.WorkLogsMoreThanWT;
                    }
                    else if((Double)agr.get('Actual__c') < resultForCompare.get((Date)agr.get('Date__c')) - 1){
                        workTimeCompareworkLogsMsg = Label.WorkLogsLessThanWT;
                    }
                    
                }
            }
        }
        
        return workTimeCompareworkLogsMsg;
    }
    
    public static String listOfMessages(String employeeId, Boolean requireWorkLog){
        
        String msg = workForToDay(employeeId);        
        if(String.isNotBlank(msg)){
            System.debug(msg);
            return msg;
        }
        if(requireWorkLog){
            msg = workLogforToDay(employeeId);
            if(String.isNotBlank(msg)){
                System.debug(msg);
                return msg;
            }
        }
        if(String.isNotBlank(msg = workTimeMonth(employeeId))){
            System.debug(msg);
            return msg;
        }
        if(requireWorkLog){
            if(String.isNotBlank(msg = workTimeCompareworklogs(employeeId))){
                System.debug(msg);
                return msg;
            } 
        }        
        return msg = 'Everything fine';
    }
}