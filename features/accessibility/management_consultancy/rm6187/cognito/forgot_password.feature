@accessibility @javascript
Feature: Forgot my password - Management Consultancy - RM6187 - Accessibility

  Scenario: I forgot my password
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    And I am on the 'Sign in to your management consultancy account' page
    When I click on 'I’ve forgotten my password'
    Then I am on the 'Reset password' page
    Then the page should be axe clean excluding ".ccs-contact-us"
