@isTest
private class exposedClassTest {
    @isTest static void testDoPost() {
        // Create a fake request
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/RestSite/v1';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name":"Test"}');
        RestContext.request = req;


        // Call the method
        List<String> result = exposedClass.doPost();

        // Perform assertions
        System.assert(result != null);
    }

    @isTest static void testDoGet() {
        // Create a fake request
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/RestSite/v1';
        req.httpMethod = 'GET';
        RestContext.request = req;

        // Call the method
        String result = exposedClass.doGet();

        // Perform assertions
        //System.assertEquals('success', result);
    }
}