@isTest
public class TestManagerOppBatch {
  @isTest
  static void testManagerOppBatch() {
    // Create a test Opportunity

    List<Opportunity> oppListSM = new List<Opportunity>();
    List<Opportunity> oppListNM = new List<Opportunity>();
    List<Opportunity> oppListOM = new List<Opportunity>();
    List<Opportunity_Manager__c> oppManagerListSM = new List<Opportunity_Manager__c>();
    List<Opportunity_Manager__c> oppManagerListNM = new List<Opportunity_Manager__c>();
    List<Opportunity_Manager__c> oppManagerListOM = new List<Opportunity_Manager__c>();

    for (Integer i = 0; i < 50; i++) {
      Opportunity opp = new Opportunity();
      opp.Name = 'Sale Manager Opportunity' + i;
      opp.StageName = 'Prospecting';
      opp.CloseDate = Date.today();
      opp.Amount = 2000;
      opp.LeadSource = 'Website';
      oppListSM.add(opp);
    }
      insert oppListSM;
    for (Integer i = 0; i < 50; i++) {
      Opportunity opp = new Opportunity();
      opp.Name = 'National Manager Opportunity' + i;
      opp.StageName = 'Prospecting';
      opp.CloseDate = Date.today();
      opp.Amount = 2000;
      opp.LeadSource = 'Website';
      oppListNM.add(opp);
    }
      insert oppListNM;
    for (Integer i = 0; i < 50; i++) {
      Opportunity opp = new Opportunity();
      opp.Name = 'Operation Manager Opportunity' + i;
      opp.StageName = 'Prospecting';
      opp.CloseDate = Date.today();
      opp.Amount = 2000;
      opp.LeadSource = 'Website';
      oppListOM.add(opp);
    }
    insert oppListOM;
    // Create a test Opportunity_Manager__c record

    for (Opportunity opp : oppListSM) {
      Opportunity_Manager__c oppManager = new Opportunity_Manager__c();
      oppManager.Opportunity__c = opp.Id;
      oppManager.Manager__c = UserInfo.getUserId();
      oppManager.Manager_Type__c = 'Sales Manager';
      oppManagerListSM.add(oppManager);
    }
    insert oppManagerListSM;
    for (Opportunity opp : oppListNM) {
      Opportunity_Manager__c oppManager = new Opportunity_Manager__c();
      oppManager.Opportunity__c = opp.Id;
      oppManager.Manager__c = UserInfo.getUserId();
      oppManager.Manager_Type__c = 'National Sales';
      oppManagerListNM.add(oppManager);
    }
    insert oppManagerListNM;
    for (Opportunity opp : oppListOM) {
      Opportunity_Manager__c oppManager = new Opportunity_Manager__c();
      oppManager.Opportunity__c = opp.Id;
      oppManager.Manager__c = UserInfo.getUserId();
      oppManager.Manager_Type__c = 'Operation Sales';
      oppManagerListOM.add(oppManager);
    }
    insert oppManagerListOM;

    Test.startTest();

    ManagerOppBatch b = new ManagerOppBatch();
    ID batchprocessid = Database.executeBatch(b);

    Test.stopTest();

    AsyncApexJob a = [
      SELECT
        Id,
        Status,
        NumberOfErrors,
        JobItemsProcessed,
        TotalJobItems,
        CreatedBy.Email
      FROM AsyncApexJob
      WHERE Id = :batchprocessid
    ];

    System.assertEquals('Completed', a.Status);
    List<Opportunity> updatedOpp = [
      SELECT
        Id,
        National_Sales_Manager__c,
        Operation_Sales_Manager__c,
        Sales_Manager__c
      FROM Opportunity   
    ];

    System.assertEquals(50, [SELECT COUNT() FROM Opportunity where National_Sales_Manager__c = : UserInfo.getUserId()]);
    System.assertEquals(50, [SELECT COUNT() FROM Opportunity where Operation_Sales_Manager__c  = : UserInfo.getUserId()]);
    System.assertEquals(50, [SELECT COUNT() FROM Opportunity where Sales_Manager__c  = : UserInfo.getUserId()]);

      
  }
}