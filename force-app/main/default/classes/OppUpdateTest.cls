@isTest
public class OppUpdateTest {
  @isTest
  static void OppUpdateTest() {
    Test.enableChangeDataCapture();
    List<Account> accList = new List<Account>();
    Account acc = new Account(Name = 'TestAccount', Phone = '1234567890', Email__c = 'guerreroandrey@gmail.com');
    accList.add(acc);
    insert accList;
    List<Contact> conList = new List<Contact>();
    Contact con = new Contact(
      FirstName = 'Test',
      LastName = 'Contact',
      Phone = '1234567890',
      AccountId = acc.Id,
      Email = 'test@test.com'
    );
    conList.add(con);
    insert conList;
    List<Opportunity> oppList = new List<Opportunity>();
    Opportunity opp = new Opportunity(
      Name = 'TestOppApex',
      StageName = 'Prospecting',
      CloseDate = Date.today(),
      AccountId = acc.Id,
      Amount = 1000,
      LeadSource = 'Website',
      ContactId__c = con.Id
    );
    oppList.add(opp);
    insert oppList;
    List<OpportunityContactRole> oppConList = new List<OpportunityContactRole>();
    OpportunityContactRole oppCon = new OpportunityContactRole(
      OpportunityId = opp.Id,
      ContactId = con.Id,
      IsPrimary = true,
      Role = 'Decision Maker'
    );
    oppConList.add(oppCon);
    insert oppConList;
    opp.StageName = 'Closed Won';

    update opp;
    Test.getEventBus().deliver();
System.assertEquals('Closed Won', [Select Stage_OpportunityC__c From Contact Where Id = :con.Id].Stage_OpportunityC__c, 'Contact Modified');
System.assertEquals('Closed Won', [Select Stage_Opportunity__c From Account Where Id = :acc.Id].Stage_Opportunity__c, 'Account Modified');
  }
}