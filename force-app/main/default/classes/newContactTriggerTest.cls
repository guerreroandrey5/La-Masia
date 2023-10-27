@isTest
public class newContactTriggerTest {
    @isTest static void testContactInsertWithEmail() {
        // Create a Contact
        Contact con = new Contact(FirstName='Test', LastName='Contact', Email='test@example.com');
        insert con;

        // Verify that an email was sent
        System.assertEquals(1, Limits.getEmailInvocations());
    }
}