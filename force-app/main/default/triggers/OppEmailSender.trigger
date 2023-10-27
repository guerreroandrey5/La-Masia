trigger OppEmailSender on Opportunity(after update) {
  List<Opportunity> oppList = [
    SELECT id, StageName, AccountId, Name
    FROM Opportunity
    WHERE id = :Trigger.new
  ];

  for (Opportunity opp : oppList) {   
    if (opp.StageName == 'Closed Won') {
        List<String> accEmail = new List<String>();
        accEmail.add([SELECT Email__c FROM Account WHERE Id = :opp.AccountId]
    .Email__c);
      EmailManager.sendMail(
        accEmail,
        'Your Opportunity ' + opp.Name + ' has reached the Closed Won Stage',
        'Please check it in the next Link https://inforge--lmsuarez.sandbox.lightning.force.com/lightning/r/Opportunity/' +
          opp.id +
          '/view'
      );
    }
  }
}