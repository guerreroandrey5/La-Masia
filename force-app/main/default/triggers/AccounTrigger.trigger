trigger AccounTrigger on Account(before delete) {
  List<Opportunity> oppList = [
    SELECT Id, Name, AccountId, StageName
    FROM Opportunity
    WHERE AccountId IN :Trigger.old
  ];
  for (Opportunity opp : oppList) {
    for (Account acc : Trigger.old) {
      if (acc.Id == opp.AccountId && opp.StageName == 'Closed Won') {
        acc.addError(
          'Account cannot be deleted because it has opportunities with the Closed Won stage associated with it'
        );
      }
    }
  }
}