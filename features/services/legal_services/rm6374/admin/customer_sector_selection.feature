Feature: Legal services - RM6374 - Admin - Customer sector selection

  Background:
    Given I sign in as an admin for the 'RM6374' framework in 'legal services'

  Scenario: Admin updates customer sector selection for a supplier
    When I click on 'Manage supplier data'
    And I click on 'View details' in the row for 'A&L Goodbody Northern Ireland LLP'
    And I click on 'Change' for 'Customer sector selection'
    Then I am on the 'Customer sector selection' page
    When I check 'Health'
    And I check 'Education'
    And I click on 'Save and return'
    Then the following content should be displayed on the page:
      | Supplier information updated successfully |
      | Health                                    |
      | Education                                 |