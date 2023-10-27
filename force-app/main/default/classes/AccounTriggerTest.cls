@isTest
public class AccounTriggerTest {
    @isTest static void testAccountDelete() {
        // Create an Account
        Account acc = new Account(Name='Test Account');
        insert acc;

        // Create a Closed Won Opportunity associated with the Account
        Opportunity opp = new Opportunity(
            Name='Test Opportunity',
            StageName='Closed Won',
            CloseDate=System.today(),
            AccountId=acc.Id,
            Amount = 1000,
            LeadSource = 'Website'
        );
        insert opp;

        // Attempt to delete the Account and catch the error
        Database.DeleteResult result = Database.delete(acc, false);

        // Verify that the Account was not deleted due to the error
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(
            'Account cannot be deleted because it has opportunities with the Closed Won stage associated with it',
            result.getErrors()[0].getMessage()
        );
    }
}