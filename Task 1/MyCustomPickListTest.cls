@isTest
public class MyCustomPickListTest {
    
    @isTest private static void testPickList(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Subject', 'Subject');
        Test.StartTest();
        MyCustomPickList casePickList = new MyCustomPickList();
        VisualEditor.DataRow rows = casePickList.getDefaultValue();
        Test.stopTest();
        system.equals(defaultValue.getValue(), rows.getValue());
    }
    
    @isTest private static void getValuesTest(){
        
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Case.fields.getMap();
        Test.StartTest();
        MyCustomPickList casePickList = new MyCustomPickList();
        VisualEditor.DynamicPickListRows rows = casePickList.getValues();
        Test.stopTest();
        system.assertequals(rows.size(), fieldMap.size());
    }
    
    
}