({
	loadAnimals : function(component, event, helper) {
		 var action = component.get("c.getSameExternalIdAnimals");
         action.setParams({
            animalId: component.get("v.recordId")
         });
         console.log(component.get("v.recordId"));
         action.setCallback(this, function(response){
            var similarProperties = response.getReturnValue();
            console.log(similarProperties);
            component.set("v.similarProperties", similarProperties);
         });
        $A.enqueueAction(action);
	}
})