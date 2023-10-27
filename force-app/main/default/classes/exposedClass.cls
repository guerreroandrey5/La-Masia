@RestResource(urlMapping='/RestSite/v1/*')
global class exposedClass {
  static string link;
  @HttpPost
  global static List<String> doPost() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    List<String> lstHeaders = new List<String>();
    string headers = req.headers.toString();
    string body = req.requestBody.toString();
    lstHeaders.add(headers);
    lstHeaders.add(body);
    return lstHeaders;
  }

  @HttpGet
  global static String doGet() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    List<String> csvHeaders = new List<String>{
      'Name',
      'Amount',
      'CreateDate',
      'Account.Name'
    };
    List<String> csvRows = new List<String>();
    for (Opportunity opp : [
      SELECT Id, Account.Name, Amount, CloseDate, CreatedDate, Name
      FROM Opportunity
      WHERE StageName = 'Closed Won' AND CALENDAR_YEAR(CreatedDate) = 2023
      ORDER BY CreatedDate
    ]) {
      csvRows.add(
        opp.Name +
          ',' +
          opp.Amount +
          ',' +
          opp.CloseDate +
          ',' +
          opp.Account.Name
      );
    }
    System.debug(csvRows);
    createCSV(csvHeaders, csvRows, 'OpportunitiesCSV');
    return link;
  }

  public static void createFile(String versionData, String title) {
    ContentVersion cv = new ContentVersion();
    cv.ContentLocation = 'S';
    cv.Title = title;
    cv.PathOnClient = title;
    cv.VersionData = Blob.valueOf(versionData);
    TriggerByPasser.setDoNotRunTrigger();
    insert cv;

    ContentDistribution cd = new ContentDistribution();
    cd.Name = 'CSVOpportunity';
    cd.ContentVersionId = cv.id;
    cd.PreferencesAllowViewInBrowser = true;
    cd.PreferencesLinkLatestVersion = true;
    cd.PreferencesNotifyOnVisit = false;
    cd.PreferencesPasswordRequired = false;
    cd.PreferencesAllowOriginalDownload = true;
    CD.PreferencesAllowPDFDownload = false;

    insert cd;

    link = [
      SELECT id, DistributionPublicUrl
      FROM ContentDistribution
      WHERE id = :cd.id
    ].DistributionPublicUrl;
  }

  public static void createCSV(
    List<String> csvHeaders,
    List<String> csvRowList,
    String title
  ) {
    String headerRow = String.join(csvHeaders, ',') + '\n';
    String concantenatedStr = headerRow;
    Integer i = 0;
    Integer rowListSize = csvRowList.size();
    for (String row : csvRowList) {
      i++;
      concantenatedStr += (String) row + ((i != rowListSize) ? '\n' : '');
    }
    title += '.csv';
    createFile(concantenatedStr, title);
  }
}