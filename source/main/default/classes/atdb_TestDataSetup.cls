/**
 * Test setup builder.
 */
@IsTest
global class atdb_TestDataSetup {
  private final List<atdb_TestDataBuilder> builders = new List<atdb_TestDataBuilder>();

  /**
   * Initiate new test setup.
   *
   * @return Test setup builder for further configuration.
   */
  global static atdb_TestDataSetup newBuilder() {
    return new atdb_TestDataSetup();
  }

  /**
   * Register test data builder.
   *
   * @param builder Test data builder to register.
   * @return Builder instance for chaining.
   */
  global atdb_TestDataSetup with(atdb_TestDataBuilder builder) {
    builders.add(builder);
    return this;
  }

  /**
   * Insert test data configured with registered builders.
   */
  global void insertData() {
    for (atdb_TestDataBuilder builder : builders) {
      builder.insertData();
    }
  }
}
