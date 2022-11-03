@accessibility @javascript
Feature: Forgot my password - Legal Services - RM6240 - Accessibility

  Scenario: Reset password page
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal services account' page
    When I click on 'I’ve forgotten my password'
    Then I am on the 'Reset password' page
    Then the page should be axe clean
