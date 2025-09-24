@accessibility @javascript
Feature: Legal services - Admin - Supplier data pages - Accessibility

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then the page should pass the accessibility checks
