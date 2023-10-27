public class ContactCallout {
  public static HttpResponse makeGetCallout() {
    List<Map<String, Object>> users = new List<Map<String, Object>>();
    Http http = new Http();
    HttpResponse response;
    HttpRequest request = new HttpRequest();
    for (Integer i = 0; i < 5; i++) {
      request.setEndpoint('https://randomuser.me/api/');
      request.setMethod('GET');
      response = http.send(request);
      if (response.getStatusCode() == 200) {
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
          response.getBody()
        );
        for (Object ob : (List<Object>) results.get('results')) {
          users.add((Map<String, Object>) ob);
        }
      }
    }
    System.debug('Received the following user:');
	List<Contact> conList = new List<Contact>();
    for (Object ob : users) {
      Contact con = new Contact();
      Map<String, Object> mapJson = (Map<String, Object>) ob;
      Map<String, Object> name = (Map<String, Object>) mapJson.get('name');
      Map<String, Object> dob = (Map<String, Object>) mapJson.get('dob');
      con.FirstName = (String) name.get('first');
      con.LastName = (String) name.get('last');
      con.Salutation = (String) name.get('title');
      con.Email = (String) mapJson.get('email');
      con.Nationality__c = (String) mapJson.get('nat');
      con.Gender__c = (String) mapJson.get('gender');
      con.Cell__c = (String) mapJson.get('cell');
      con.Phone = (String) mapJson.get('phone');
      con.Birth_Date__c = date.valueOf((String) dob.get('date'));
      conList.add(con);
    }
      //insert conList;
    return response;
  }
}