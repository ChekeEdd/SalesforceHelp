({
    searchClick: function(component, event, helper) {
        
        helper.onFilterClick(component, event, helper);
        helper.count(component, event, helper);
                
    },
    
    handleNext : function(component, event, helper) {         
        var pageNumber = component.get("v.pageNumber");        
        component.set("v.pageNumber", pageNumber + 1);        
        var pagesoncomp = component.get('v.count');
        if(pagesoncomp === pageNumber + 1){
            component.set("v.isLastPage", true);
        }
        
        helper.onFilterClick(component, event, helper);
        
        
        
        
    },
    
    handlePrev : function(component, event, helper) {        
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber - 1);
        var pagesoncomp = component.get('v.count');
        if(pagesoncomp !== pageNumber + 1){
            component.set("v.isLastPage", false);
        }
        helper.onFilterClick(component, event, helper);
        
        
    },
    
    activeButton : function(component, event, helper) {
        
        helper.block(component, event, helper);
        
    },
    
       
    
    
})