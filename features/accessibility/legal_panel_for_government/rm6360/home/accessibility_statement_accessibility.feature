@accessibility @javascript
Feature: Legal Panel for Government - Accessibility statement accessibility

  Scenario: Accessibility statement
    Given I go to the 'legal panel for government' start page for 'RM6360'
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Panel for Government (LPG) Accessibility statement' page
    Then the page should pass the accessibility checks
