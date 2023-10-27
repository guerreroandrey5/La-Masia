@isTest
public class ContactCalloutMock implements HttpCalloutMock {
  public HttpResponse respond(HttpRequest req) {
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');
    res.setBody(
      '{"results": [ {"gender": "male","name": {"title": "Mr","first": "Arnoldo","last": "Domínguez"}, "location": { "street": {"number": 8071,"name": "Corredor Barrios" }, "city": "Tlacote El Bajo","state": "Sinaloa","country": "Mexico","postcode": 54522,"coordinates": {"latitude": "21.6326","longitude": "-66.6986"},"timezone": {"offset": "+8:00","description": "Beijing, Perth, Singapore, Hong Kong"}},"email": "arnoldo.dominguez@example.com","login": {"uuid": "14dc8ec7-eafe-4bc4-bdaa-6a3bdfbb4077","username": "redostrich447","password": "snowboar","salt": "5N95TYpD","md5": "23edc64ddc8ab59708a58c73006fac69","sha1": "b47efd81e5b91cdfcf5cba9ae063838b7667d4ec","sha256": "0a1042052f95c4f2b34962b8b794d366da997545a0d34670b9f1793be3017bfc"},"dob": {"date": "1982-06-08T04:50:11.995Z","age": 41},"registered": {"date": "2006-05-23T16:45:49.594Z","age": 17},"phone": "(689) 772 0442","cell": "(697) 628 2572","id": {"name": "NSS","value": "63 33 95 4517 4"},"picture": {"large": "https://randomuser.me/api/portraits/men/69.jpg","medium": "https://randomuser.me/api/portraits/med/men/69.jpg","thumbnail": "https://randomuser.me/api/portraits/thumb/men/69.jpg"},"nat": "MX"}],"info": {"seed": "65e97f20fd9e036b","results": 1,"page": 1,"version": "1.4"}}'
    );
    res.setStatusCode(200);
    return res;
  }
}