trigger ManagerOppTrigger on Opportunity_Manager__c(
  after update,
  after delete
) {
  //updated
  if (Trigger.isUpdate) {
    List<String> OppIds = new List<String>();
    for (Opportunity_Manager__c opm : Trigger.new) {
      OppIds.add(opm.Opportunity__c);
    }
    List<Opportunity> OppList = [
      SELECT
        Id,
        National_Sales_Manager__c,
        Operation_Sales_Manager__c,
        Sales_Manager__c
      FROM Opportunity
      WHERE Id IN :OppIds
    ];
    for (Opportunity_Manager__c opm : Trigger.new) {
      for (Opportunity opp : OppList) {
        if (opp.Id == opm.Opportunity__c) {
          if (opm.Manager_Type__c == 'National Sales') {
            opp.National_Sales_Manager__c = opm.Manager__c;
            opp.Operation_Sales_Manager__c = null;
            opp.Sales_Manager__c = null;
          }
          if (opm.Manager_Type__c == 'Operation Sales') {
            opp.National_Sales_Manager__c = null;
            opp.Operation_Sales_Manager__c = opm.Manager__c;
            opp.Sales_Manager__c = null;
          }
          if (opm.Manager_Type__c == 'Sales Manager') {
            opp.National_Sales_Manager__c = null;
            opp.Operation_Sales_Manager__c = null;
            opp.Sales_Manager__c = opm.Manager__c;
          }
        }
          System.debug(opp.National_Sales_Manager__c);
          System.debug(opp.Operation_Sales_Manager__c);
          System.debug(opp.Sales_Manager__c);
      }
    }
  }
  //deleted
  if (Trigger.isDelete) {
    List<String> OppIds = new List<String>();
    for (Opportunity_Manager__c opm : Trigger.old) {
      OppIds.add(opm.Opportunity__c);
    }
    List<Opportunity> OppList = [
      SELECT
        Id,
        National_Sales_Manager__c,
        Operation_Sales_Manager__c,
        Sales_Manager__c
      FROM Opportunity
      WHERE Id IN :OppIds
    ];
    for (Opportunity_Manager__c opm : Trigger.old) {
      for (Opportunity opp : OppList) {
        if (opp.Id == opm.Opportunity__c) {
          opp.National_Sales_Manager__c = null;
          opp.Operation_Sales_Manager__c = null;
          opp.Sales_Manager__c = null;
        }
      }
    }
  }
}