/**
 * Builder to create test users.
 */
@IsTest
global class atdb_TestUserBuilder implements atdb_TestDataBuilder {
  private final List<atdb_TestUserRecordBuilder> userBuilders = new List<atdb_TestUserRecordBuilder>();
  private String defaultUserLocale;
  private String defaultUserLanguage;
  private String defaultUserTimeZone;

  /**
   * Create new test data builder to create test users.
   */
  global atdb_TestUserBuilder() {
  }

  /**
   * Builder to create a single test user.
   */
  global class atdb_TestUserRecordBuilder {
    private final atdb_TestUserBuilder parentBuilder;
    private final User user;

    private atdb_TestUserRecordBuilder(atdb_TestUserBuilder parentBuilder) {
      this.parentBuilder = parentBuilder;
      user = new User();
    }

    /**
     * Return to parent builder allowing for further configuration.
     */
    global atdb_TestUserBuilder done() {
      return parentBuilder;
    }

    /**
     * Set given field to given value.
     *
     * @param field Name of the field.
     * @param value Value of the field.
     * @return Builder instance for chaining.
     */
    global atdb_TestUserRecordBuilder set(String field, Object value) {
      user.put(field, value);
      return this;
    }

    global atdb_TestUserRecordBuilder username(String username) {
      user.Username = username;
      return this;
    }

    global atdb_TestUserRecordBuilder firstName(String firstName) {
      user.FirstName = firstName;
      return this;
    }

    global atdb_TestUserRecordBuilder lastName(String lastName) {
      user.LastName = lastName;
      return this;
    }

    global atdb_TestUserRecordBuilder email(String email) {
      user.Email = email;
      return this;
    }

    global atdb_TestUserRecordBuilder emailEncoding(String emailEncoding) {
      user.EmailEncodingKey = emailEncoding;
      return this;
    }

    global atdb_TestUserRecordBuilder alias(String alias) {
      user.Alias = alias;
      return this;
    }

    global atdb_TestUserRecordBuilder locale(String locale) {
      user.LocaleSidKey = locale;
      return this;
    }

    global atdb_TestUserRecordBuilder language(String language) {
      user.LanguageLocaleKey = language;
      return this;
    }

    global atdb_TestUserRecordBuilder timeZone(String timeZone) {
      user.TimeZoneSidKey = timeZone;
      return this;
    }

    global atdb_TestUserRecordBuilder profileName(String profileName) {
      user.Profile = new Profile(Name = profileName);
      return this;
    }

    global atdb_TestUserRecordBuilder profileId(Id profileId) {
      user.ProfileId = profileId;
      return this;
    }
  }

  /**
   * Insert the test users configured with the builder.
   */
  global void insertData() {
    if (!userBuilders.isEmpty()) {
      List<User> users = getUsers();
      insert users;
    }
  }

  /**
   * Get users configured with the builder.
   *
   * @return List of test users.
   */
  global List<User> getUsers() {
    List<User> users = new List<User>();
    for (atdb_TestUserRecordBuilder userBuilder : userBuilders) {
      users.add(userBuilder.user);
    }
    return users;
  }

  /**
   * Set default locale to apply to all subsequent test users.
   *
   * @param locale Default locale.
   * @return Builder instance for chaining.
   */
  global atdb_TestUserBuilder defaultLocale(String locale) {
    defaultUserLocale = locale;
    return this;
  }

  /**
   * Set default language to apply to all subsequent test users.
   *
   * @param language Default language.
   * @return Builder instance for chaining.
   */
  global atdb_TestUserBuilder defaultLanguage(String language) {
    defaultUserLanguage = language;
    return this;
  }

  /**
   * Set default time zone to apply to all subsequent test users.
   *
   * @param timeZone Default time zone.
   * @return Builder instance for chaining.
   */
  global atdb_TestUserBuilder defaultTimeZone(String timeZone) {
    defaultUserTimeZone = timeZone;
    return this;
  }

  /**
   * Register new test user with given username.
   *
   * @param username Username for the test user.
   * @return Test user builder for further configuration.
   */
  global atdb_TestUserRecordBuilder withUser(String username) {
    atdb_TestUserRecordBuilder userBuilder = new atdb_TestUserRecordBuilder(
      this
    );
    userBuilder.username(username);
    if (defaultUserLocale != null) {
      userBuilder.locale(defaultUserLocale);
    }
    if (defaultUserLanguage != null) {
      userBuilder.language(defaultUserLanguage);
    }
    if (defaultUserTimeZone != null) {
      userBuilder.timeZone(defaultUserTimeZone);
    }
    userBuilders.add(userBuilder);
    return userBuilder;
  }
}
