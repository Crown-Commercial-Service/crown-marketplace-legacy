@accessibility @javascript
Feature: Management Consultancy - Admin - Supplier details - Accessibility

  Scenario: Supplier details page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'GREENFELDER-LEUSCHKE'
    Then I am on the 'Supplier details' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    Then the page should pass the accessibility checks
