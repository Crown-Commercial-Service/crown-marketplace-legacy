@allow_list @pipeline
Feature: Sign up to management consultancy - RM6187

  Scenario: I sign in to my existing account
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    And I am on the 'Sign in to your management consultancy account' page
    And I click on 'Create an account'
    Then I am on the 'Create a CCS account' page
    And I am able to create an 'mc' account
    Then I am on the 'Activate your account' page
    And I enter the following details into the form:
      | Confirmation code | 123456 |
    And I click on 'Continue'
    Then I am on the 'Important changes to how you access Management Consultancy Framework Three' page
