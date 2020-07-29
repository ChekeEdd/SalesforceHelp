({
    onFilterClick: function(component, event, helper) {
        var searchText = component.get('v.strName');
        var typefield = component.get('v.Fields');
        console.log(typefield);
        var action = component.get('c.findCase');
        action.setParams({KeyWord:searchText, typeField: typefield} );
        action.setCallback(this, function(response) {
            var state = response.getState();
            var cases, labels;
            
            if (state === 'SUCCESS') {
                cases = response.getReturnValue().objects;
                labels = response.getReturnValue().labels;
                console.log(cases);
            }
            component.set("v.data", cases);
            if(typefield !== 'CaseNumber'){
            component.set('v.columns',[                
                {label: 'Case Number', fieldName: 'CaseNumber', type: 'text'},
                {label: labels[typefield], fieldName: typefield, type: 'text'}] )
                }
            else{
                component.set('v.columns',[                
                {label: 'Case Number', fieldName: 'CaseNumber', type: 'text'}])
            }
        });
        
        $A.enqueueAction(action);
    }
})
