@allow_list
Feature: Sign up to legal services - RM6360

  Scenario: I sign in to my existing account
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal panel for government account' page
    And I click on 'Create a CCS account'
    Then I am on the 'Create a CCS account' page
    And I am able to create an 'ls' account
    Then I am on the 'Activate your account' page
    And I enter the following details into the form:
      | Confirmation code | 123456 |
    And I click on 'Continue'
    Then I am on the 'Do you work for central government?' page
