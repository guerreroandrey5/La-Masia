trigger newContacTrigger on Contact (after insert) {
    for(Contact c : Trigger.new){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new List<String> {[SELECT Email FROM User WHERE Profile.Name = 'System Administrator' AND FirstName = 'Andrey'].Email};
        mail.setToAddresses(toAddresses);
        mail.setTemplateId('00X3J000000J6xR');
        mail.setTargetObjectId(c.Id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}