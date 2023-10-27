trigger FileTrigger on ContentVersion(after insert) {
    if (TriggerByPasser.shouldRunTrigger()) {
  ContentVersion cv = [
    SELECT Title, Id, ContentDocumentId, FirstPublishLocationId
    FROM ContentVersion
    WHERE Title LIKE '%important%' AND Id IN :Trigger.new
  ];
  if (cv != null) {
    List<String> conEmails = new List<String>();
    Account acc = [
      SELECT Id, Email__c
      FROM Account
      WHERE Id = :cv.FirstPublishLocationId
    ];
    conEmails.add(acc.Email__c);
    List<Contact> conList = [
      SELECT Id, Email
      FROM Contact
      WHERE AccountId = :acc.Id
    ];
    for (Contact con : conList) {
      conEmails.add(con.Email);
      ContentDocumentLink cdl = new ContentDocumentLink();
      cdl.ContentDocumentId = cv.ContentDocumentId;
      cdl.LinkedEntityId = con.Id;
      cdl.ShareType = 'I';
      cdl.Visibility = 'InternalUsers';
      insert cdl;
    }
    EmailManager.sendMail(
      conEmails,
      'A new File has been uploaded',
      'Please Check your own Page for more details'
    );
  }
    }
}