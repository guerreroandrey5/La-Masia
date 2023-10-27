public class createCon {
    @AuraEnabled
    public static Contact createContact(Contact con) {
        system.debug('con'+con);
        insert con;
        return con;
    }
}