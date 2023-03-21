@allow_list
Feature: Sign up to legal services - RM6240

  Scenario: I sign in to my existing account
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal services account' page
    And I click on 'Create an account'
    Then I am on the 'Create a CCS account' page
    And I am able to create an 'ls' account
    Then I am on the 'Activate your account' page
    And I enter the following details into the form:
      | Confirmation code | 123456 |
    And I click on 'Continue'
    Then I am on the 'Do you work for central government?' page
