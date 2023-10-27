@isTest
public class OppEmailTest {
    @isTest
    static void Sender(){
        List<Account> accList = new List<Account>();
    Account acc = new Account(Name = 'TestAccount', Phone = '1234567890', Email__c = 'guerreroandrey@gmail.com');
    accList.add(acc);
    insert accList;
    List<Opportunity> oppList = new List<Opportunity>();
    Opportunity opp = new Opportunity(
      Name = 'TestOppApex',
      StageName = 'Prospecting',
      CloseDate = Date.today(),
      AccountId = acc.Id,
      Amount = 1000,
      LeadSource = 'Website'
    );
    oppList.add(opp);
    insert oppList;

    opp.StageName = 'Closed Won';
    Test.startTest();
    update opp;
    Integer EmailsSent = Limits.getEmailInvocations();
    Test.stopTest();
    
    system.assertEquals(1, EmailsSent);
    }
}