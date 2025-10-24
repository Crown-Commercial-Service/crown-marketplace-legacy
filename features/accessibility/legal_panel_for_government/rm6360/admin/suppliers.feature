@accessibility @javascript
Feature: Legal Panel for Government - Admin - Supplier data pages - Accessibility

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    Then the page should pass the accessibility checks
