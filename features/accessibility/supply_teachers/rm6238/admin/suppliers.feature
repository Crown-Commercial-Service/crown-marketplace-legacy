@accessibility @javascript
Feature: Supply Teachers - Admin - Supplier data pages - Accessibility

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then the page should pass the accessibility checks
