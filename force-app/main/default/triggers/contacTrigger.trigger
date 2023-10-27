trigger contacTrigger on Contact(before insert) {
  List<Contact> conList = [
    SELECT Id, Email, Phone
    FROM Contact    
  ];
  for (Contact con : Trigger.new) {
    for (Contact con1 : conList) {
      if (con.Email == con1.Email || con.Phone == con1.Phone) {
          //system.debug('old email: '+con.Email + ' new email: '+con1.Email+' old phone: '+con.Phone+' new phone: '+con1.Phone);
        con.addError('Your Contact already exists in system');
      }
    }
  }
}