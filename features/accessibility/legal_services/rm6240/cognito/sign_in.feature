@accessibility @javascript
Feature: Sign in to my account - Legal Services - RM6240 - Accessibility

  Background: Navigate to the sign in page
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal services account' page

  Scenario: Sign in page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Enter your access code page
    Then I should sign in with MFA and with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Enter your access code' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Change your password page
    Then I should sign in for the first time with the roles:
      | ls_access |
      | buyer     |
    And I am on the 'Change your password' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Activate your account page
    Then I should sign in as user who just created their account and with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Activate your account' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Reset your password page
    Then I should sign in as a user who needs to reset their password and with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Reset your password' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: You have successfully changed your password page
    Then I should sign in as a user who needs to reset their password and with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Reset your password' page
    And I enter the following details into the form:
      | New password          | ValidPassword1! |
      | Confirm new password  | ValidPassword1! |
      | Verification code     | 123456          |
    And I click on 'Reset password'
    Then I am on the 'You have successfully changed your password' page
    Then the page should be axe clean excluding ".ccs-contact-us"
