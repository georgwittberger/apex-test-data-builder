@IsTest
private class atdb_TestContactBuilderTest {
  @IsTest
  static void itCreatesTestContactsConfiguredWithBuilder() {
    atdb_TestContactBuilder builder = new atdb_TestContactBuilder()
      .withContact()
      .account('Test Company 1')
      .done()
      .salutation('Mr')
      .firstName('Toni')
      .lastName('Testzerker')
      .email('toni.test@testdomain.com')
      .phone('12345678')
      .fax('23456789')
      .mobilePhone('01234567')
      .done()
      .withContact()
      .account('Test Company 2')
      .set('BillingCity', 'Berlin')
      .done()
      .salutation('Ms')
      .firstName('Tina')
      .lastName('Testastic')
      .email('tina.test@testdomain.de')
      .phone('34567890')
      .fax('45678901')
      .mobilePhone('02345678')
      .set('MailingCity', 'Berlin')
      .done();

    List<Account> testAccounts = builder.getAccounts();
    List<Contact> testContacts = builder.getContacts();

    System.assertEquals(2, testAccounts.size());
    System.assertEquals('Test Company 1', testAccounts[0].Name);
    System.assertEquals('Test Company 2', testAccounts[1].Name);
    System.assertEquals('Berlin', testAccounts[1].BillingCity);

    System.assertEquals(2, testContacts.size());
    System.assertEquals('Test Company 1', testContacts[0].Account.Name);
    System.assertEquals('Mr', testContacts[0].Salutation);
    System.assertEquals('Toni', testContacts[0].FirstName);
    System.assertEquals('Testzerker', testContacts[0].LastName);
    System.assertEquals('toni.test@testdomain.com', testContacts[0].Email);
    System.assertEquals('12345678', testContacts[0].Phone);
    System.assertEquals('23456789', testContacts[0].Fax);
    System.assertEquals('01234567', testContacts[0].MobilePhone);
    System.assertEquals('Test Company 2', testContacts[1].Account.Name);
    System.assertEquals('Berlin', testContacts[1].Account.BillingCity);
    System.assertEquals('Ms', testContacts[1].Salutation);
    System.assertEquals('Tina', testContacts[1].FirstName);
    System.assertEquals('Testastic', testContacts[1].LastName);
    System.assertEquals('tina.test@testdomain.de', testContacts[1].Email);
    System.assertEquals('34567890', testContacts[1].Phone);
    System.assertEquals('45678901', testContacts[1].Fax);
    System.assertEquals('02345678', testContacts[1].MobilePhone);
    System.assertEquals('Berlin', testContacts[1].MailingCity);
  }
}
