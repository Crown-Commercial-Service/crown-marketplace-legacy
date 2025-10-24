@accessibility @javascript
Feature: Legal Panel for Government - Admin - Supplier details - Accessibility

  Scenario: Supplier details page
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'CORMIER INC'
    Then I am on the 'Supplier details' page
    And the caption is 'CORMIER INC'
    Then the page should pass the accessibility checks
