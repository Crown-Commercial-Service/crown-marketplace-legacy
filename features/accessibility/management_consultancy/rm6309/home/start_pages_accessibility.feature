@accessibility @javascript
Feature: Management Consultancy - Start pages accessibility

  Scenario: Service start page
    When I go to the 'management consultancy' start page for 'RM6309'
    Then I am on the 'Find management consultants' page
    Then the page should pass the accessibility checks

  Scenario: Log in page
    When I go to the 'management consultancy' start page for 'RM6309'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your management consultancy account' page
    Then the page should pass the accessibility checks

  Scenario: Start page
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Then the page should pass the accessibility checks
