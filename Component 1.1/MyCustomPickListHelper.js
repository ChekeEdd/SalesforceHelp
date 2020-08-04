({
    onFilterClick: function(component, event, helper) {    
        
        var searchText = component.get('v.strName');
        var typefield = component.get('v.Fields');  
        var pagesize = component.get("v.pageSize")
        var recordsPerPage = component.get('v.records'); 
        var pageNumber = component.get('v.pageNumber') || 1;
        
        console.log(typefield);
        var action = component.get('c.findCase');
        action.setParams({KeyWord:searchText, typeField: typefield, recordsPerPage:recordsPerPage, pageNumber: pageNumber} );
        action.setCallback(this, function(response) {
            var state = response.getState();
            var cases, table, count;           
            if (state === 'SUCCESS') {                
                cases = response.getReturnValue().objects;
                table = response.getReturnValue().listOfMaps; 
                
                cases.forEach(function(field){
                    field.CaseLink = '/' + field.Id;
                    
                });                
            }else alert(response.getError()[0].message);
            
            component.set("v.dataSize", cases.length);
            component.set("v.data", cases);
            component.set("v.columns", table);
            
            
        });
        
        $A.enqueueAction(action);
    },
    
    count: function(component, event, helper){
        
        var searchText = component.get('v.strName');
        var typefield = component.get('v.Fields');  
        var pagesize = component.get("v.count");
        var recordsPerPage = component.get('v.records');         
        var action1 = component.get('c.counter');
        action1.setParams({KeyWord:searchText, typeField: typefield, recordsPerPage:recordsPerPage});
        action1.setCallback(this, function(response) {
            var state = response.getState();
            var casescount
            if (state === 'SUCCESS') {                
                casescount = response.getReturnValue();
                component.set("v.count", casescount);
                var disableButtonNext = component.get("v.count");
                if(disableButtonNext == 0){
                    component.set('v.isLastPage', true);
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Info',
                        message: 'No results found',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'info',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    
                }else{
                    component.set('v.isLastPage', false);
                }
                
                
            }
        });
        
        $A.enqueueAction(action1);
    },
    
    block: function(component, event, helper) {  
        
        var validIsInputBlank = component.get("v.strName");      
        if(!validIsInputBlank.trim()){         
            component.set('v.isLastPage',true);
            component.set('v.pageNumber', 1);            
        }
        
        
        
        
    },
    
    
    
})