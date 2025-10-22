@accessibility @javascript
Feature: Management Consultancy - Admin - Supplier data pages - Accessibility

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    Then the page should pass the accessibility checks
