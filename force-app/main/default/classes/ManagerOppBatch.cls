public class ManagerOppBatch implements Database.Batchable<sObject>, Database.Stateful {
  public Integer recordsProcessed = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT Id, National_Sales_Manager__c, Operation_Sales_Manager__c, Sales_Manager__c FROM Opportunity'
    );
  }
  public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
    List<Opportunity_Manager__c> oppManagers = [
      SELECT Id, Opportunity__c, Manager__c, Manager_Type__c
      FROM Opportunity_Manager__c
      WHERE Opportunity__c IN :scope
    ];
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    for (Opportunity opp : scope) {
      for (Opportunity_Manager__c oppManager : oppManagers) {
        if (opp.Id == oppManager.Opportunity__c) {
          if (oppManager.Manager_Type__c == 'National Sales') {
            opp.National_Sales_Manager__c = oppManager.Manager__c;
            opp.Operation_Sales_Manager__c = null;
            opp.Sales_Manager__c = null;
          }
          if (oppManager.Manager_Type__c == 'Operation Sales') {
            opp.Operation_Sales_Manager__c = oppManager.Manager__c;
            opp.Sales_Manager__c = null;
            opp.National_Sales_Manager__c = null;
          }
          if (oppManager.Manager_Type__c == 'Sales Manager') {
            opp.Sales_Manager__c = oppManager.Manager__c;
            opp.Operation_Sales_Manager__c = null;
            opp.National_Sales_Manager__c = null;
          }
        }
      }
      oppsToUpdate.add(opp);
      recordsProcessed++;
    }
  }
  public void finish(Database.BatchableContext bc) {
    System.debug(recordsProcessed + ' records processed.');
    AsyncApexJob job = [
      SELECT
        Id,
        Status,
        NumberOfErrors,
        JobItemsProcessed,
        TotalJobItems,
        CreatedBy.Email
      FROM AsyncApexJob
      WHERE Id = :bc.getJobId()
    ];
  }
}