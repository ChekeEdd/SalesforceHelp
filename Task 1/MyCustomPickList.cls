global class MyCustomPickList extends VisualEditor.DynamicPickList {
    
    global override VisualEditor.DataRow getDefaultValue(){
        
        VisualEditor.DataRow Value = new VisualEditor.DataRow('Case', 'Case');
        return Value;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Case.fields.getMap();
        List<Schema.SObjectField> fieldCase = fieldMap.values();
        VisualEditor.DynamicPickListRows  result = new VisualEditor.DynamicPickListRows();
        for(Schema.SObjectField objectInstance :fieldCase){
            result.addRow(new VisualEditor.DataRow(objectInstance.getDescribe().getLabel(), objectInstance.getDescribe().getName()));
        }
        return result;
    } 
}