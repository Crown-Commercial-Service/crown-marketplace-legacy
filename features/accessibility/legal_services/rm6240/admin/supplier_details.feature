@accessibility @javascript
Feature: Legal services - Admin - Supplier details - Accessibility

  Scenario: Supplier details page
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'HALEY-FAY'
    Then I am on the 'Supplier details' page
    And the caption is 'HALEY-FAY'
    Then the page should pass the accessibility checks
