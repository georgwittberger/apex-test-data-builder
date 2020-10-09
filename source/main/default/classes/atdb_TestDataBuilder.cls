/**
 * Interface to be implemented by test data builders.
 */
global interface atdb_TestDataBuilder {
  /**
   * Invoked by the test setup when test data should be inserted into database.
   */
  void insertData();
}
