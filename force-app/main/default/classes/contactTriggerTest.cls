@isTest
public class contactTriggerTest {
    @isTest static void testContactInsert() {
        // Create a Contact
        Contact con1 = new Contact(FirstName='Test', LastName='Contact1', Email='test@example.com', Phone='1234567890');
        insert con1;

        // Create a new Contact with the same Email or Phone
        Contact con2 = new Contact(FirstName='Test', LastName='Contact2', Email='test@example.com', Phone='0987654321');

        // Attempt to insert the new Contact and catch the error
        Test.startTest();
        Database.SaveResult result = Database.insert(con2, false);
        Test.stopTest();

        // Verify that the new Contact was not inserted due to the error
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(
            'Your Contact already exists in system',
            result.getErrors()[0].getMessage()
        );
    }
}