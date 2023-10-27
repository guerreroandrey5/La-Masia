public with sharing class getPickList {
  @AuraEnabled(cacheable=true)
  public static List<String> getPicklistValues(){
    List<String> pickListValues = new List<String>();
    Schema.DescribeFieldResult pickList = ChatGPT_Prompt__mdt.Object_Picklist__c.getDescribe();
    for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
        pickListValues.add(pickVal.getValue());
    }   
    return pickListValues;
}
}