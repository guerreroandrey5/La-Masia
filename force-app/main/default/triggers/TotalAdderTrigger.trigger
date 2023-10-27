trigger TotalAdderTrigger on Opportunity(
  after insert,
  after update,
  after delete
) {
  Id AccId;
  for (Opportunity opps : Trigger.new) {
    AccId = opps.AccountId;
  }
  List<Account> accs = [SELECT Id FROM Account WHERE Id = :AccId];
  for (Account acc : accs) {
    AggregateResult ar = [
      SELECT SUM(Amount) Total
      FROM Opportunity
      WHERE AccountId = :AccId
    ];
    acc.Total_Ammount__c = decimal.Valueof(string.valueof(ar.get('Total')));
    upsert acc;
  }
}