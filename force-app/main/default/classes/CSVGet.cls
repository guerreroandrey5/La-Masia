public class CSVGet {
    static void doPost(){
        String reportText = new PageReference('/'+'00O3J000000SdanUAC'+'?csv=1').getContent().toString();	
        HttpRequest req = new HttpRequest();
		req.setEndpoint('https://inforge--lmsuarez.sandbox.my.salesforce-sites.com/2351rest');
		req.setBody(reportText);
		req.setHeader('Content-Type','text/csv');
		req.setHeader('Content-Length',String.valueOf(reportText.length()));
		req.setMethod('POST');

		HttpResponse response = new Http().send(req);
    }
}