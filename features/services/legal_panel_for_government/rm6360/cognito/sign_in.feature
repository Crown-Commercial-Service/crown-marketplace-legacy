Feature: Sign in to my account - Legal Panel for Government - RM6360

  Background: Navigate to the sign in page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal panel for government account' page

  Scenario: I sign in to my existing account
    Then I should sign in with the roles:
      | ls_access |
      | buyer     |
    And I am on the 'Do you work for central government?' page

  Scenario: I sign in with MFA
    Then I should sign in with MFA and with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Enter your access code' page
    And I enter the following details into the form:
      | Access code | 123456 |
    And I click on 'Continue'
    Then I am on the 'Do you work for central government?' page

  Scenario: I sign in for the first time
    Then I should sign in for the first time with the roles:
      | ls_access |
      | buyer     |
    And I am on the 'Change your password' page
    And I enter the following details into the form:
      | Create a password you'll remember | ValidPassword1! |
      | Confirm your password             | ValidPassword1! |
    And I click on 'Change password and sign in'
    Then I am on the 'Do you work for central government?' page

  Scenario: I sign in for the first time with MFA
    Then I should sign in for the first time with MFA Enabled and with the roles:
      | ls_access |
      | buyer     |
    And I am on the 'Change your password' page
    And I enter the following details into the form:
      | Create a password you'll remember | ValidPassword1! |
      | Confirm your password             | ValidPassword1! |
    And I click on 'Change password and sign in'
    Then I am on the 'Enter your access code' page
    And I enter the following details into the form:
      | Access code | 123456 |
    And I click on 'Continue'
    Then I am on the 'Do you work for central government?' page

  Scenario: I sign in for the first time after creating an account
    Then I should sign in as user who just created their account and with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Activate your account' page
    And I enter the following details into the form:
      | Confirmation code | 123456 |
    And I click on 'Continue'
    Then I am on the 'Do you work for central government?' page

  Scenario: I sign in and need to reset my password
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
    And I click on the Sign in link
    And I am on the 'Sign in to your legal panel for government account' page
