@IsTest
private class atdb_TestAccountBuilderTest {
  @IsTest
  static void itCreatesTestAccountsConfiguredWithBuilder() {
    atdb_TestAccountBuilder builder = new atdb_TestAccountBuilder()
      .withAccount('Test Company')
      .done()
      .withAccount('Another Company')
      .set('BillingCity', 'Berlin')
      .done();

    List<Account> testAccounts = builder.getAccounts();

    System.assertEquals(2, testAccounts.size());
    System.assertEquals('Test Company', testAccounts[0].Name);
    System.assertEquals('Another Company', testAccounts[1].Name);
    System.assertEquals('Berlin', testAccounts[1].BillingCity);
  }
}
