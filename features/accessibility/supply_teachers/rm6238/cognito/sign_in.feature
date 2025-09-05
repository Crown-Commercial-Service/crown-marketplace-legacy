@accessibility @javascript
Feature: Sign in to my account - Supply Teachers - RM6238 - Accessibility

  Background: Navigate to the sign in page
    When I go to the 'supply teachers' start page for 'RM6238'
    Then I am on the 'Find supply teachers and agency workers' page
    When I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    And I click on 'Sign in with CCS'
    And I am on the 'Sign in to your supply teachers account' page

  Scenario: Sign in page
    Then the page should pass the accessibility checks

  Scenario: Enter your access code page
    Then I should sign in with MFA and with the roles:
      | st_access |
      | buyer     |
    Then I am on the 'Enter your access code' page
    Then the page should pass the accessibility checks

  Scenario: Change your password page
    Then I should sign in for the first time with the roles:
      | st_access |
      | buyer     |
    And I am on the 'Change your password' page
    Then the page should pass the accessibility checks

  Scenario: Reset your password page
    Then I should sign in as a user who needs to reset their password and with the roles:
      | st_access |
      | buyer     |
    Then I am on the 'Reset your password' page
    Then the page should pass the accessibility checks

  Scenario: You have successfully changed your password page
    Then I should sign in as a user who needs to reset their password and with the roles:
      | st_access |
      | buyer     |
    Then I am on the 'Reset your password' page
    And I enter the following details into the form:
      | New password         | ValidPassword1! |
      | Confirm new password | ValidPassword1! |
      | Verification code    | 123456          |
    And I click on 'Reset password'
    Then I am on the 'You have successfully changed your password' page
    Then the page should pass the accessibility checks
