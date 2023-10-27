public with sharing class CAccountController {
    public String countryCode {set; get;}
    public List<Account> getAccounts() {
      List<Account> results = Database.query(
        'SELECT Id, Name, Phone, BillingCountry, BillingCountryCode, BillingStateCode, BillingStreet, BillingCity, '+
          +'BillingPostalCode, ShippingStreet, ShippingCity, ShippingStateCode, ShippingPostalCode,'+ 
          'ShippingCountry, ShippingCountryCode  FROM Account  WHERE BillingCountry =:countryCode LIMIT 10  '
      );
      return results;
    }
  }