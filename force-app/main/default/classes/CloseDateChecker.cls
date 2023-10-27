public class CloseDateChecker implements Database.Batchable<sObject>, Database.Stateful {
  public Integer recordsProcessed = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT id, CloseDate, StageName, Closing_Date_Approaching__c FROM Opportunity'
    );
  }
  public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
    List<Opportunity> oppListUp = new List<Opportunity>();
    for (Opportunity opp : scope) {
      if (opp.StageName != 'Closed Won' || opp.StageName != 'Closed Lost') {
        if (opp.CloseDate.daysBetween(Date.today()) <= 7) {
          opp.Closing_Date_Approaching__c = true;
          oppListUp.add(opp);
        } else {
          opp.Closing_Date_Approaching__c = false;
          oppListUp.add(opp);
        }
        recordsProcessed = recordsProcessed + 1;
      }
    }
    update oppListUp;
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