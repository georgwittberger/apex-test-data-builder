/**
 * Builder to create test accounts.
 */
@IsTest
global class atdb_TestAccountBuilder implements atdb_TestDataBuilder {
  private final List<atdb_TestAccountRecordBuilder> accountBuilders = new List<atdb_TestAccountRecordBuilder>();
  private Id defaultAccountRecordTypeId;

  /**
   * Create new test data builder to create test accounts.
   */
  global atdb_TestAccountBuilder() {
  }

  /**
   * Builder to create a single test account.
   */
  global class atdb_TestAccountRecordBuilder {
    private final atdb_TestAccountBuilder parentBuilder;
    private final Account account;

    private atdb_TestAccountRecordBuilder(
      atdb_TestAccountBuilder parentBuilder
    ) {
      this.parentBuilder = parentBuilder;
      account = new Account();
    }

    /**
     * Return to parent builder allowing for further configuration.
     */
    global atdb_TestAccountBuilder done() {
      return parentBuilder;
    }

    /**
     * Set given field to given value.
     *
     * @param field Name of the field.
     * @param value Value of the field.
     * @return Builder instance for chaining.
     */
    global atdb_TestAccountRecordBuilder set(String field, Object value) {
      account.put(field, value);
      return this;
    }

    global atdb_TestAccountRecordBuilder name(String name) {
      account.Name = name;
      return this;
    }

    global atdb_TestAccountRecordBuilder recordTypeId(Id recordTypeId) {
      account.RecordTypeId = recordTypeId;
      return this;
    }
  }

  /**
   * Insert the test accounts configured with the builder.
   */
  global void insertData() {
    if (!accountBuilders.isEmpty()) {
      List<Account> accounts = getAccounts();
      insert accounts;
    }
  }

  /**
   * Get accounts configured with the builder.
   *
   * @return List of test accounts.
   */
  global List<Account> getAccounts() {
    List<Account> accounts = new List<Account>();
    for (atdb_TestAccountRecordBuilder accountBuilder : accountBuilders) {
      accounts.add(accountBuilder.account);
    }
    return accounts;
  }

  /**
   * Set default record type Id to apply to all subsequent test accounts.
   *
   * @param recordTypeId Default record type Id.
   * @return Builder instance for chaining.
   */
  global atdb_TestAccountBuilder defaultRecordTypeId(String recordTypeId) {
    defaultAccountRecordTypeId = recordTypeId;
    return this;
  }

  /**
   * Register new test account with given name.
   *
   * @param name Name for the test account.
   * @return Test account builder for further configuration.
   */
  global atdb_TestAccountRecordBuilder withAccount(String name) {
    atdb_TestAccountRecordBuilder accountBuilder = new atdb_TestAccountRecordBuilder(
      this
    );
    accountBuilder.name(name);
    if (defaultAccountRecordTypeId != null) {
      accountBuilder.recordTypeId(defaultAccountRecordTypeId);
    }
    accountBuilders.add(accountBuilder);
    return accountBuilder;
  }
}
