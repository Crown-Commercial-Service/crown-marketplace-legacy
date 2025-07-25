@accessibility @javascript
Feature: Sign up to management consultancy - RM6187 - Accessibility

  Scenario: Create an account page
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    And I am on the 'Sign in to your management consultancy account' page
    And I click on 'Create a CCS account'
    Then I am on the 'Create a CCS account' page
    Then the page should be axe clean excluding ".ccs-contact-us"
