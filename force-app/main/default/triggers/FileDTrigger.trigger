trigger FileDTrigger on ContentDocument(before delete) {
    if(Trigger.isDelete){
  List<ContentDocument> cvList = new List<ContentDocument>(Trigger.old);
  List<String> CVIds = new List<String>();
  for (ContentDocument cv : cvList) {
    CVIds.add(cv.Id);
  }
  List<ContentDocumentLink> cdlList = [
    SELECT ContentDocumentId, LinkedEntityId
    FROM ContentDocumentLink
    WHERE ContentDocumentId = :CVIds
  ];

  List<String> CVLinkIds = new List<String>();
  for (ContentDocumentLink cv : cdlList) {
    CVLinkIds.add(cv.LinkedEntityId);
  }

  List<Account> accList = [
    SELECT Id, Email__c
    FROM Account
    WHERE Id IN :CVLinkIds
  ];

  List<Contact> conList = [
    SELECT Id, AccountId, Email
    FROM Contact
    WHERE AccountId IN :accList
  ];

  List<String> conEmails = new List<String>();
  
  for (ContentDocument cv : cvList) {
    for (Account acc : accList) {
        conEmails.add(acc.Email__c);
      for (Contact con : conList) {
        conEmails.add(con.Email);
      }
    }
  }
        EmailManager.sendMail(
    conEmails,
    'A File has been deleted',
    'Please Check your own Page for more details'
  );
    }
}