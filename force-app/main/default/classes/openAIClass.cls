public class openAIClass {
  @AuraEnabled(cacheable=true)
  public static string ChatGPTAPI(ChatGPT_Prompt__mdt gpt) {
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    HTTPResponse res;
    string request;
    string prompt =
      'I need a short draft for an Email for Salesforce for the object: ' +
      gpt.Object_Picklist__c +
      ' and the input: ' +
      gpt.Prompt__c + ' max 150 words';
    System.debug(prompt);
    req.setEndpoint('callout:OpenAI_API/chat/completions');
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/json');
    req.setTimeout(60000);
    request =
      '{"model": "gpt-3.5-turbo","messages": [{"role": "user","content": "' +
      prompt +
      '"}],"temperature": 0.2,"top_p": 1,"n": 1,"stream": false,"max_tokens": 200,"presence_penalty": 0,"frequency_penalty": 0}';
    string body = request;
    req.setBody(body);
    System.debug('Request Body: ' + req.getBody());
    try {
      res = http.send(req);
      if (res.getStatusCode() == 200) {
        System.debug(res.getBody());
        return res.getBody();
      } else {
        System.debug(
          'Callout error: ' + res.getStatusCode() + ' ' + res.getBody()
        );
        return 'Error: ' + res.getStatusCode();
      }
    } catch (Exception e) {
      return 'Error: ' + e.getMessage();
    }
  }
}