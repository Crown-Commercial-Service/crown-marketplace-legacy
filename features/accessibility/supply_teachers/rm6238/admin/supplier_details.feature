@accessibility @javascript
Feature: Supply Teachers - Admin - Supplier details - Accessibility

  Scenario Outline: Supplier details page
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for "CHRISTIANSEN INC"
    Then I am on the 'Supplier details' page
    And the caption is "CHRISTIANSEN INC"
    Then the page should pass the accessibility checks
