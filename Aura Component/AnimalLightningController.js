({
	loadAnimals : function(component, event, helper) {
         helper.tableInit(component);
		 var action = component.get("c.getSameExternalIdAnimals");
         action.setParams({
            aID: component.get("v.recordId")
         });
         helper.fetchAnimals(component,action);
	},
    onFilterClick : function(component, event, helper) {
        var filterString =  component.get("v.filterValue");
        var action = component.get("c.findAnimals");
        action.setParams({
            aID : component.get("v.recordId"),
            searchanimal : component.get("v.filterValue")
        })
        helper.fetchAnimals(component,action);
    }
})