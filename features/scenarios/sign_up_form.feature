Feature: Verifying Signing up Application

  Background: System sets parameters
    Given system clears cache and cookies


  Scenario: 1. Verify valid signing up application
    Given user opens Farmdrop application
    And user goes to Sign Up page
    When user fills in the form on Sign Up page with data:
      | field_name   | value                      |
      | email        | nataly3@mail.com           |
      | password     | some11time22@              |
      | postcode     | EC1A 1BB                   |
      | mailing_list | Add me to the mailing list |
    And user submits Sign Up form
    Then user verifies text is displayed on the page:
    """
    Choose your delivery slot
    """
    And user verifies Sign up or Log in button isn't displayed on the page

  Scenario: 2. Verify invalid signing up application with the exist email
    Given user opens Farmdrop application
    And user goes to Sign Up page
    When user fills in the form on Sign Up page with data:
      | field_name   | value                      |
      | email        | nataly3@mail.com           |
      | password     | some11time22@              |
      | postcode     | EC1A 1BB                   |
      | mailing_list | Add me to the mailing list |
    And user tries to submit Sign Up form
    Then user verifies error is displayed on Sign Up page:
    """
    Email has already been taken
    """

  Scenario: 3. Verify invalid signing up application with the invalid postcode field
    Given user opens Farmdrop application
    And user goes to Sign Up page
    When user fills in the form on Sign Up page with data:
      | field_name   | value                      |
      | email        | nataly4@mail.com           |
      | password     | some11time22@              |
      | postcode     | 1234                       |
      | mailing_list | Add me to the mailing list |
    And user tries to submit Sign Up form
    Then user verifies text is displayed on the page:
    """
    Or with your email if you’d prefer:
    """
    Then user verifies validation message of postcode field:
      | text                               |
      | Please match the requested format. |


  Scenario: 4. Verify invalid signing up application with the invalid email field
    Given user opens Farmdrop application
    And user goes to Sign Up page
    When user fills in the form on Sign Up page with data:
      | field_name   | value                      |
      | email        | nataly                     |
      | password     | some11time22@              |
      | postcode     | EC1A 1BB                   |
      | mailing_list | Add me to the mailing list |
    And user tries to submit Sign Up form
    Then user verifies text is displayed on the page:
    """
    Or with your email if you’d prefer:
    """
    Then user verifies validation message of email field:
      | text                                                                    |
      | Please include an '@' in the email address. 'nataly' is missing an '@'. |
