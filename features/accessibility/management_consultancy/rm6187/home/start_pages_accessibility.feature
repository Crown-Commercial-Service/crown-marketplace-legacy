@accessibility @javascript
Feature: Management Consultancy - Start pages accessibility

  Scenario: Service start page
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Log in page
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your management consultancy account' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Start page
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Then the page should be axe clean excluding ".ccs-contact-us"
