@IsTest
global class atdb_TestDataSetupTest {
  global class atdb_TestDataBuilderSpy implements atdb_TestDataBuilder {
    private Boolean insertDataCalled = false;

    global void insertData() {
      insertDataCalled = true;
    }
  }

  @IsTest
  static void itCreatesRecordsConfiguredWithBuilders() {
    atdb_TestDataBuilderSpy builderSpy = new atdb_TestDataBuilderSpy();

    atdb_TestDataSetup.newBuilder().with(builderSpy).insertData();

    System.assert(builderSpy.insertDataCalled);
  }
}
