public class EmailManager {
  public static void sendMail(List<String> toAddresses, String subject, String body) {
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(toAddresses);
    mail.setSubject(subject);
    mail.setPlainTextBody(body);
      if(toAddresses[0] != null){
          Messaging.SendEmailResult[] results = Messaging.sendEmail(
      new List<Messaging.SingleEmailMessage>{ mail }
    );
    inspectResults(results);
      }  
  }
  private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
    Boolean sendResult = true;
    for (Messaging.SendEmailResult res : results) {
      if (res.isSuccess()) {
        System.debug('Email sent successfully');
      } else {
        sendResult = false;
        System.debug('The following errors occurred: ' + res.getErrors());
      }
    }
    return sendResult;
  }
}