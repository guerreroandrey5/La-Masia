@isTest
public class ManagerOppTest {
  @isTest
  static void ManagerOppTest() {
    Opportunity opp = new Opportunity(
      Name = 'OppApexTest',
      Amount = 5000,
      LeadSource = 'Website',
      ContactId__c = '0033J00000WO9NBQA1',
      StageName = 'New',
      CloseDate = Date.Today() + 2
    );
    insert opp;
    Opportunity_Manager__c opm = new Opportunity_Manager__c(
      Manager__c = '0053J000002pfWmQAI',
      Manager_Type__c = 'Sales Manager',
      Opportunity__c = opp.Id
    );
    Test.startTest();
    insert opm;
    opm.Manager_Type__c = 'Operation Sales';
    upsert opm;
    delete opm;
      
    Opportunity_Manager__c opmB = opm.clone();
    insert opmB;
    opmB.Manager_Type__c = 'Sales Manager';
    upsert opmB;

    Opportunity_Manager__c opmC = opm.clone();
    insert opmC;
    opmC.Manager_Type__c = 'National Sales';
    upsert opmC;

    Test.stopTest();
  }
}