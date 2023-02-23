@accessibility @javascript
Feature: Sign up to legal services - RM6240 - Accessibility

  Scenario: Create an account page
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal services account' page
    And I click on the Create an account link
    Then I am on the 'Create a CCS account' page
    Then the page should be axe clean
