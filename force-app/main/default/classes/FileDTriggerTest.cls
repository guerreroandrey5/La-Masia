@isTest
public class FileDTriggerTest {
    @isTest static void testFileDTrigger() {
        // Create a new Account
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        // Create a new Contact linked to the Account
        Contact testContact = new Contact(LastName='Test Contact', Email='test@example.com', AccountId=testAccount.Id);
        insert testContact;

        // Create a new ContentVersion
        ContentVersion cv = new ContentVersion(
            Title = 'Test Document',
            PathOnClient = 'TestDocument.txt',
            VersionData = Blob.valueOf('Test Content')
        );
        TriggerByPasser.setDoNotRunTrigger();
    	insert cv;
    	TriggerByPasser.shouldRunTrigger();

        // Get the ContentDocumentId from the ContentVersion
        cv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];

        // Link the ContentDocument to the Account
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = cv.ContentDocumentId,
            LinkedEntityId = testAccount.Id,
            ShareType = 'I'
        );
        insert cdl;

        // Attempt to delete the ContentDocument, which should fire the trigger
        delete [SELECT Id FROM ContentDocument WHERE Id = :cv.ContentDocumentId];
    }
}