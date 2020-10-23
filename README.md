# Apex Test Data Builder

> Lightweight test support library to create test data in Salesforce Apex unit tests

![GitHub version](https://img.shields.io/github/package-json/v/georgwittberger/apex-test-data-builder)
![GitHub issues](https://img.shields.io/github/issues/georgwittberger/apex-test-data-builder)
![GitHub license](https://img.shields.io/github/license/georgwittberger/apex-test-data-builder)

- [Apex Test Data Builder](#apex-test-data-builder)
  - [Overview](#overview)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Test Setup Builder](#test-setup-builder)
    - [Integrated Test Data Builders](#integrated-test-data-builders)
      - [atdb_TestUserBuilder](#atdb_testuserbuilder)
      - [atdb_TestAccountBuilder](#atdb_testaccountbuilder)
      - [atdb_TestContactBuilder](#atdb_testcontactbuilder)
    - [Custom Test Data Builders](#custom-test-data-builders)
  - [License](#license)

## Overview

This SFDX project provides a set of Apex classes to assist with the creation of test data in Apex unit tests. It promotes a builder style design pattern for the different data domains which finally offers developers a nice fluent API for an easy test data setup.

## Installation

<a href="https://githubsfdeploy.herokuapp.com?owner=georgwittberger&repo=apex-test-data-builder&ref=master">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

Alternatively, clone this Git repository and deploy the SFDX project using [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli).

## Usage

### Test Setup Builder

The entrypoint for test data setup is the Apex class `atdb_TestDataSetup`. It has a static method `newBuilder()` to start the declarative configuration of test data.

The test setup builder has the method `with()` to register an arbitrary number of test data builders. These builders are domain-specific plugins which take responsibility for the creation of a certain kind of test data.

After all necessary builders are registered the method `insertData()` has to be called to start the test data creation. It will invoke every test data builder in exactly the same order as they have been registered.

**Usage:**

```java
atdb_TestDataSetup.newBuilder()
  .with(firstBuilder)
  .with(secondBuilder)
  .with(thirdBuilder)
  .insertData();
```

**Example:**

```java
atdb_TestDataSetup.newBuilder()
  .with(
    new atdb_TestAccountBuilder()
      .withAccount('Test Company')
      .done()
  )
  .with(
    new atdb_TestUserBuilder()
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
  )
  .insertData();
```

### Integrated Test Data Builders

The library includes a set of test data builders for Salesforce standard objects.

#### atdb_TestUserBuilder

Supports the creation of users.

**Construction:**

Use the default constructor `new atdb_TestUserBuilder()`

**Default values:**

Use the methods prefixed with `default` to set default values which are used for all subsequently registered users.

**Configure users:**

Use the method `withUser()` to start configuration of a single user. Then use the various builder methods to configure the user. Finally, call the `done()` method to finish the configuration of the user. Continue with the next user by calling `withUser()` again.

**Example:**

```java
new atdb_TestUserBuilder()
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
  .locale('de_DE')
  .timeZone('Europe/Berlin')
  .set('City', 'Berlin')
  .done()
```

The example creates two test users. While the first user `american@testdomain.com` relies on the default locale, language and time zone the second user `german@testdomain.de` overrides the locale to `de_DE` and the time zone to `Europe/Berlin`. Additionally, the second user is configured with city.

#### atdb_TestAccountBuilder

Supports the creation of accounts.

**Construction:**

Use the default constructor `new atdb_TestAccountBuilder()`

**Configure accounts:**

Use the method `withAccount()` to start configuration of a single account. Then use the various builder methods to configure the account. Finally, call the `done()` method to finish the configuration of the account. Continue with the next account by calling `withAccount()` again.

**Example:**

```java
new atdb_TestAccountBuilder()
  .withAccount('Test Company')
  .done()
  .withAccount('Another Company')
  .set('BillingCity', 'Berlin')
  .done()
```

#### atdb_TestContactBuilder

> Available as of version 1.1.0

Supports the creation of contacts.

**Construction:**

Use the default constructor `new atdb_TestContactBuilder()`

**Configure contacts:**

Use the method `withContact()` to start configuration of a single contact. Then use the various builder methods to configure the contact. Finally, call the `done()` method to finish the configuration of the contact. Continue with the next contact by calling `withContact()` again.

Use the method `account()` with a `String` argument on the test contact builder to configure an embedded account associated with the contact. Alternatively, assign an account by passing the sObject to the `account()` method or by setting its Id using `accountId()`.

**Example:**

```java
new atdb_TestContactBuilder()
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
  .done()
```

### Custom Test Data Builders

You can implement your own test data builders that can be passed to the `with()` method of the test data setup by implementing the Apex interface `atdb_TestDataBuilder`. It requires the method `insertData()` to be implemented. This method is invoked when `insertData()` is called on the test setup.

Even though you can implement your test data builder in any style you like I definitely recommend to follow the same builder style used for the standard builders. Take a look at the source code of these Apex classes for guidance.

## License

[MIT License](https://opensource.org/licenses/MIT)
