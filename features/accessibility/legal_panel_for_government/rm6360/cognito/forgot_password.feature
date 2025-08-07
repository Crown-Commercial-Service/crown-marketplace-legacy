@accessibility @javascript
Feature: Forgot my password - Legal Panel for Government - RM6360 - Accessibility

  Scenario: Reset password page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal panel for government account' page
    When I click on 'I’ve forgotten my password'
    Then I am on the 'Reset password' page
    Then the page should be axe clean excluding ".ccs-contact-us"
