Feature: Legal Panel for Government - Admin - Supplier details - Supplier information

  Scenario: Supplier information can be updated
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'CORMIER INC'
    Then I am on the 'Supplier details' page
    And the caption is 'CORMIER INC'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | CORMIER INC |
      | DUNS Number | 650210078   |
      | Is an SME?  | No          |
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'CORMIER INC'
    And I enter the following details into the form:
      | Supplier name | Naga Ghost |
      | DUNS Number   | 987654321  |
    And I select 'Yes'
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'Naga Ghost'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | Naga Ghost |
      | DUNS Number | 987654321  |
      | Is an SME?  | Yes        |
