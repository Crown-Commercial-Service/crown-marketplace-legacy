@accessibility @javascript
Feature: Management Consultancy - Admin - Supplier details - Accessibility

  Scenario: Supplier details page
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'BERNHARD INC'
    Then I am on the 'Supplier details' page
    And the caption is 'BERNHARD INC'
    Then the page should pass the accessibility checks
