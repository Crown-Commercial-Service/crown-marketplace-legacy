@pipeline
Feature: Forgot my password - Legal Services - RM6240

  Scenario: I forgot my password
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal services account' page
    When I click on 'I’ve forgotten my password'
    Then I am on the 'Reset password' page
    And I can reset my password with the roles:
      | ls_access |
      | buyer     |
    Then I am on the 'Reset your password' page
    And I enter the following details into the form:
      | New password          | ValidPassword1! |
      | Confirm new password  | ValidPassword1! |
      | Verification code     | 123456          |
    And I click on 'Reset password'
    Then I am on the 'You have successfully changed your password' page
    And I click on 'Sign in'
    And I am on the 'Sign in to your legal services account' page
