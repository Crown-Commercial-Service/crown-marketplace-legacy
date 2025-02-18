@accessibility @javascript
Feature: Management Consultancy - Accessibility statement accessibility

  Scenario: Accessibility statement
    Given I go to the 'management consultancy' start page for 'RM6309'
    When I click on 'Accessibility statement'
    Then I am on the 'Management Consultancy (MC) Accessibility statement' page
    Then the page should be axe clean
