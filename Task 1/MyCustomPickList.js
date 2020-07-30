({
    onFilterClick: function(component, event, helper) {
        var searchText = component.get('v.strName');
        var typefield = component.get('v.Fields');        
        console.log(typefield);
        var action = component.get('c.findCase');
        action.setParams({KeyWord:searchText, typeField: typefield} );
        action.setCallback(this, function(response) {
            var state = response.getState();
            var cases, table;           
            if (state === 'SUCCESS') {
                cases = response.getReturnValue().objects;
                table = response.getReturnValue().listOfMaps;
                cases.forEach(function(field){
                    field.CaseLink = '/' + field.Id;
                    
                });
                console.log(cases);
            }
            
            component.set("v.data", cases);
            component.set("v.columns", table);
            
            
        });
        
        $A.enqueueAction(action);
    }
})