@accessibility @javascript
Feature: Legal Services - Accessibility statement accessibility

  Scenario: Accessibility statement
    Given I go to the 'legal services' start page for 'RM6240'
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Services (LS) Accessibility statement' page
    Then the page should pass the accessibility checks
