/**
 * Builder to create test contacts.
 */
@IsTest
global class atdb_TestContactBuilder implements atdb_TestDataBuilder {
  private final List<atdb_TestContactRecordBuilder> contactBuilders = new List<atdb_TestContactRecordBuilder>();
  private Id defaultContactRecordTypeId;

  /**
   * Create new test data builder to create test contacts.
   */
  global atdb_TestContactBuilder() {
  }

  /**
   * Builder to create a single test contact.
   */
  global class atdb_TestContactRecordBuilder {
    private final atdb_TestContactBuilder parentBuilder;
    private final Contact contact;
    private atdb_TestContactAccountRecordBuilder accountBuilder;

    private atdb_TestContactRecordBuilder(
      atdb_TestContactBuilder parentBuilder
    ) {
      this.parentBuilder = parentBuilder;
      contact = new Contact();
    }

    /**
     * Return to parent builder allowing for further configuration.
     */
    global atdb_TestContactBuilder done() {
      return parentBuilder;
    }

    /**
     * Set given field to given value.
     *
     * @param field Name of the field.
     * @param value Value of the field.
     * @return Builder instance for chaining.
     */
    global atdb_TestContactRecordBuilder set(String field, Object value) {
      contact.put(field, value);
      return this;
    }

    /**
     * Create new test data builder to create test account for the contact.
     *
     * @param name Name of the test account.
     * @return Builder to configure the test account.
     */
    global atdb_TestContactAccountRecordBuilder account(String name) {
      accountBuilder = new atdb_TestContactAccountRecordBuilder(this);
      accountBuilder.name(name);
      contact.AccountId = null;
      contact.Account = accountBuilder.account;
      return accountBuilder;
    }

    /**
     * Use given test account for the contact.
     *
     * @param account Reference to the test account.
     * @return Builder instance for chaining.
     */
    global atdb_TestContactRecordBuilder account(Account account) {
      accountBuilder = null;
      contact.AccountId = null;
      contact.Account = account;
      return this;
    }

    /**
     * Use given test account Id for the contact.
     *
     * @param accountId Id of the test account.
     * @return Builder instance for chaining.
     */
    global atdb_TestContactRecordBuilder accountId(Id accountId) {
      accountBuilder = null;
      contact.Account = null;
      contact.AccountId = accountId;
      return this;
    }

    global atdb_TestContactRecordBuilder salutation(String salutation) {
      contact.Salutation = salutation;
      return this;
    }

    global atdb_TestContactRecordBuilder firstName(String firstName) {
      contact.FirstName = firstName;
      return this;
    }

    global atdb_TestContactRecordBuilder lastName(String lastName) {
      contact.LastName = lastName;
      return this;
    }

    global atdb_TestContactRecordBuilder email(String email) {
      contact.Email = email;
      return this;
    }

    global atdb_TestContactRecordBuilder phone(String phone) {
      contact.Phone = phone;
      return this;
    }

    global atdb_TestContactRecordBuilder fax(String fax) {
      contact.Fax = fax;
      return this;
    }

    global atdb_TestContactRecordBuilder mobilePhone(String mobilePhone) {
      contact.MobilePhone = mobilePhone;
      return this;
    }

    global atdb_TestContactRecordBuilder recordTypeId(Id recordTypeId) {
      contact.put('RecordTypeId', recordTypeId);
      return this;
    }
  }

  /**
   * Builder to create a single test account for a contact.
   */
  global class atdb_TestContactAccountRecordBuilder {
    private final atdb_TestContactRecordBuilder parentBuilder;
    private final Account account;

    private atdb_TestContactAccountRecordBuilder(
      atdb_TestContactRecordBuilder parentBuilder
    ) {
      this.parentBuilder = parentBuilder;
      account = new Account();
    }

    /**
     * Return to contact builder allowing for further configuration.
     */
    global atdb_TestContactRecordBuilder done() {
      return parentBuilder;
    }

    /**
     * Set given field to given value.
     *
     * @param field Name of the field.
     * @param value Value of the field.
     * @return Builder instance for chaining.
     */
    global atdb_TestContactAccountRecordBuilder set(
      String field,
      Object value
    ) {
      account.put(field, value);
      return this;
    }

    global atdb_TestContactAccountRecordBuilder name(String name) {
      account.Name = name;
      return this;
    }

    global atdb_TestContactAccountRecordBuilder recordTypeId(Id recordTypeId) {
      account.put('RecordTypeId', recordTypeId);
      return this;
    }
  }

  /**
   * Insert the test contacts configured with the builder.
   */
  global void insertData() {
    if (!contactBuilders.isEmpty()) {
      List<Account> accounts = getAccounts();
      Map<String, Id> accountIdsByName = new Map<String, Id>();
      if (!accounts.isEmpty()) {
        insert accounts;
        for (Account account : accounts) {
          accountIdsByName.put(account.Name, account.Id);
        }
      }
      List<Contact> contacts = getContacts();
      for (Contact contact : contacts) {
        if (
          contact.Account != null &&
          String.isNotBlank(contact.Account.Name) &&
          accountIdsByName.containsKey(contact.Account.Name)
        ) {
          contact.Account.Id = accountIdsByName.get(contact.Account.Name);
          contact.AccountId = accountIdsByName.get(contact.Account.Name);
        }
      }
      insert contacts;
    }
  }

  /**
   * Get contacts configured with the builder.
   *
   * @return List of test contacts.
   */
  global List<Contact> getContacts() {
    List<Contact> contacts = new List<Contact>();
    for (atdb_TestContactRecordBuilder contactBuilder : contactBuilders) {
      contacts.add(contactBuilder.contact);
    }
    return contacts;
  }

  /**
   * Get accounts configured for the contacts in the builder.
   *
   * @return List of test accounts.
   */
  global List<Account> getAccounts() {
    List<Account> accounts = new List<Account>();
    for (atdb_TestContactRecordBuilder contactBuilder : contactBuilders) {
      if (contactBuilder.accountBuilder != null) {
        accounts.add(contactBuilder.accountBuilder.account);
      }
    }
    return accounts;
  }

  /**
   * Set default record type Id to apply to all subsequent test contacts.
   *
   * @param recordTypeId Default record type Id.
   * @return Builder instance for chaining.
   */
  global atdb_TestContactBuilder defaultRecordTypeId(Id recordTypeId) {
    defaultContactRecordTypeId = recordTypeId;
    return this;
  }

  /**
   * Register new test contact.
   *
   * @return Test contact builder for further configuration.
   */
  global atdb_TestContactRecordBuilder withContact() {
    atdb_TestContactRecordBuilder contactBuilder = new atdb_TestContactRecordBuilder(
      this
    );
    if (defaultContactRecordTypeId != null) {
      contactBuilder.recordTypeId(defaultContactRecordTypeId);
    }
    contactBuilders.add(contactBuilder);
    return contactBuilder;
  }
}
