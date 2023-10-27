@isTest
public class ContactCalloutTest {
  @isTest
  static void calloutTest() {
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('GetContact');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    Test.setMock(HttpCalloutMock.class, mock);
    HttpResponse result = ContactCallout.makeGetCallout();
    System.assertNotEquals(
      null,
      result,
      'The callout returned a null response.'
    );
    System.assertEquals(
      200,
      result.getStatusCode(),
      'The status code is not 200.'
    );
    System.assertEquals(
      'application/json;charset=UTF-8',
      result.getHeader('Content-Type'),
      'The content type value is not expected.'
    );
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
      result.getBody()
    );
    System.debug(results);
    System.assertEquals(
      2,
      results.size(),
      'The array should only contain 2 items.'
    );
  }
}