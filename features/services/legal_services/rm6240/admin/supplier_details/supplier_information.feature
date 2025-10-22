Feature: Legal services - Admin - Supplier details - Supplier information

  Scenario: Supplier information can be updated
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'HALEY-FAY'
    Then I am on the 'Supplier details' page
    And the caption is 'HALEY-FAY'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | HALEY-FAY |
      | DUNS Number | 634050459 |
      | Is an SME?  | Yes       |
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'HALEY-FAY'
    And I enter the following details into the form:
      | Supplier name | Kora      |
      | DUNS Number   | 987654321 |
    And I select 'No'
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'Kora'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | Kora      |
      | DUNS Number | 987654321 |
      | Is an SME?  | No        |
