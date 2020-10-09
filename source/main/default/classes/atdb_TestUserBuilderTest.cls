@IsTest
private class atdb_TestUserBuilderTest {
  @IsTest
  static void itCreatesTestUsersConfiguredWithBuilder() {
    atdb_TestUserBuilder builder = new atdb_TestUserBuilder()
      .defaultLocale('en_US')
      .defaultLanguage('en_US')
      .defaultTimeZone('America/New_York')
      .withUser('american@testdomain.com')
      .profileName('System Administrator')
      .firstName('Toni')
      .lastName('Testzerker')
      .email('toni.test@testdomain.com')
      .emailEncoding('UTF-8')
      .alias('tonitest')
      .done()
      .withUser('german@testdomain.de')
      .profileName('System Administrator')
      .firstName('Tina')
      .lastName('Testastic')
      .email('tina.test@testdomain.de')
      .emailEncoding('UTF-8')
      .alias('tinatest')
      .timeZone('Europe/Berlin')
      .set('City', 'Berlin')
      .done();

    List<User> testUsers = builder.getUsers();

    System.assertEquals(2, testUsers.size());

    System.assertEquals('american@testdomain.com', testUsers[0].Username);
    System.assertNotEquals(null, testUsers[0].Profile);
    System.assertEquals('System Administrator', testUsers[0].Profile.Name);
    System.assertEquals('Toni', testUsers[0].FirstName);
    System.assertEquals('Testzerker', testUsers[0].LastName);
    System.assertEquals('toni.test@testdomain.com', testUsers[0].Email);
    System.assertEquals('UTF-8', testUsers[0].EmailEncodingKey);
    System.assertEquals('tonitest', testUsers[0].Alias);
    System.assertEquals('en_US', testUsers[0].LocaleSidKey);
    System.assertEquals('en_US', testUsers[0].LanguageLocaleKey);
    System.assertEquals('America/New_York', testUsers[0].TimeZoneSidKey);

    System.assertEquals('german@testdomain.de', testUsers[1].Username);
    System.assertNotEquals(null, testUsers[1].Profile);
    System.assertEquals('System Administrator', testUsers[1].Profile.Name);
    System.assertEquals('Tina', testUsers[1].FirstName);
    System.assertEquals('Testastic', testUsers[1].LastName);
    System.assertEquals('tina.test@testdomain.de', testUsers[1].Email);
    System.assertEquals('UTF-8', testUsers[1].EmailEncodingKey);
    System.assertEquals('tinatest', testUsers[1].Alias);
    System.assertEquals('en_US', testUsers[1].LocaleSidKey);
    System.assertEquals('en_US', testUsers[1].LanguageLocaleKey);
    System.assertEquals('Europe/Berlin', testUsers[1].TimeZoneSidKey);
    System.assertEquals('Berlin', testUsers[1].City);
  }
}
