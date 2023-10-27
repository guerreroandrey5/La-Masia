trigger OppUpdate on Opportunity (after update) {

    List<Account> accToUpdate = new List<Account>();
    List<Contact> conToUpdate = new List<Contact>();
    
    for (Opportunity opp : Trigger.new) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        if (opp.StageName != oldOpp.StageName) {

            Account acc = new Account(Id = opp.AccountId, Stage_Opportunity__c = opp.StageName);
            accToUpdate.add(acc);
            List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :opp.AccountId];
            for (Contact con : contacts) {
                con.Stage_OpportunityC__c = opp.StageName;
                conToUpdate.add(con);
            }
        }
    }

    update accToUpdate;
    update conToUpdate;
}