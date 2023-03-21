Feature: Sign in to my account - Supply Teachers - RM6238

  Background: Navigate to the sign in page
    When I go to the 'supply teachers' start page for 'RM6238'
    Then I am on the 'Find supply teachers and agency workers' page
    When I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    And I click on 'Sign in with CCS'
    And I am on the 'Sign in to your supply teachers account' page

  Scenario: I sign in to my existing account
    Then I should sign in with the roles:
      | st_access |
      | buyer     |
    And I am on the 'What is your school looking for?' page

  Scenario: I sign in with MFA
    Then I should sign in with MFA and with the roles:
      | st_access |
      | buyer     |
    Then I am on the 'Enter your access code' page
    And I enter the following details into the form:
      | Access code | 123456 |
    And I click on 'Continue'
    Then I am on the 'What is your school looking for?' page

  Scenario: I sign in for the first time
    Then I should sign in for the first time with the roles:
      | st_access |
      | buyer     |
    And I am on the 'Change your password' page
    And I enter the following details into the form:
      | Create a password you'll remember | ValidPassword1! |
      | Confirm your password             | ValidPassword1! |
    And I click on 'Change password and sign in'
    Then I am on the 'What is your school looking for?' page

  Scenario: I sign in for the first time with MFA
    Then I should sign in for the first time with MFA Enabled and with the roles:
      | st_access |
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
    Then I am on the 'What is your school looking for?' page

  Scenario: I sign in and need to reset my password
    Then I should sign in as a user who needs to reset their password and with the roles:
      | st_access |
      | buyer     |
    Then I am on the 'Reset your password' page
    And I enter the following details into the form:
      | New password          | ValidPassword1! |
      | Confirm new password  | ValidPassword1! |
      | Verification code     | 123456          |
    And I click on 'Reset password'
    Then I am on the 'You have successfully changed your password' page
    And I click on 'Sign in'
    And I am on the 'Sign in to find supply teachers and agency workers' page
