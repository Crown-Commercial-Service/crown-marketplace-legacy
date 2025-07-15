@accessibility @javascript
Feature: Sign up to legal services - RM6360 - Accessibility

  Scenario: Create an account page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal panel for government account' page
    And I click on 'Create a CCS account'
    Then I am on the 'Create a CCS account' page
    Then the page should be axe clean
