({
    onFilterClick: function(component, event, helper) {
        var searchText = component.get('v.strName');
        var typefield = component.get('v.Fields')
        var action = component.get('c.findCase');
        action.setParams({KeyWord:searchText, typeField: typefield} );
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === 'SUCCESS') {
          var cases = response.getReturnValue().objects;
          console.log(cases);
        }
             component.set("v.data", cases);
            component.set('v.columns',[
                {label: 'Opportunity name', fieldName: 'opportunityName', type: 'text'},
            {label: 'Account name', fieldName: 'accountName', type: 'text'}] )
      });
      $A.enqueueAction(action);
    }
})