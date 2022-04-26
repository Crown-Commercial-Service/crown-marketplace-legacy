@accessibility @javascript
Feature: Supply Teachers - Accessibility statement accessibility

  Scenario: Accessibility statement
    Given I go to the 'supply teachers' start page
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    Then the page should be axe clean
