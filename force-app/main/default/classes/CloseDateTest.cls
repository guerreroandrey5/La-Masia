@isTest
public class CloseDateTest {
  @testSetup
  static void setup() {
    List<Account> accList = new List<Account>();
    List<Opportunity> oppList = new List<Opportunity>();
    List<Contact> conList = new List<Contact>();
    Account acc = new Account(
      Name = 'TestAccount',
      Phone = '1234567890',
      Email__c = 'guerreroandrey@gmail.com'
    );
    accList.add(acc);
    insert accList;

    Contact con = new Contact(
      FirstName = 'Test',
      LastName = 'Contact',
      Phone = '1234567890',
      AccountId = acc.Id
    );
    insert conList;
    date CDate = Date.today().addDays(-7);
    CDate = CDate - 60;
    date ODate = Date.today().addDays(-8);
    ODate = ODate - 60;
    // insert 250 opportunities
    for (Integer i = 0; i < 250; i++) {
      oppList.add(
        new Opportunity(
          Name = 'TestOppApez',
          StageName = 'Closed Lost',
          CloseDate = CDate,
          Amount = 1000,
          LeadSource = 'Website',
          AccountId = acc.id,
          ContactId__c = con.Id
        )
      );
    }
    oppList.add(
      new Opportunity(
        Name = 'TestOppApez',
        StageName = 'Closed Lost',
        CloseDate = ODate,
        Amount = 1000,
        LeadSource = 'Website',
        AccountId = acc.id
      )
    );
    insert oppList;
  }

  @isTest
  static void test() {
    Test.startTest();
    CloseDateChecker cdd = new CloseDateChecker();
    Id batchId = Database.executeBatch(cdd, 251);
    Test.stopTest();
    System.assertEquals(
      250,
      [SELECT COUNT() FROM Opportunity WHERE Closing_Date_Approaching__c = TRUE]
    );
  }
}