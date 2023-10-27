@isTest
public class TestFileTrigger {
    @isTest static void testFileTrigger() {
        // Prepare test data
        Account testAccount = new Account(Name = 'Test Account',Email__c = 'test@test.com');
        insert testAccount;

        Contact testContact = new Contact(LastName = 'Test Contact', AccountId = testAccount.Id, Email = 'test@test.com');
        insert testContact;

        // Run the trigger
        Test.startTest();
        
        ContentVersion cv = new ContentVersion(
            Title = 'Test important',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true,
            FirstPublishLocationId = testAccount.Id
        ); 
        insert cv;
        
        Test.stopTest();

    }
}