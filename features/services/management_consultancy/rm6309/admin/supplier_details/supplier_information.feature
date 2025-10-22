Feature: Management Consultancy - Admin - Supplier details - Supplier information

  Scenario: Supplier information can be updated
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'GREENFELDER-LEUSCHKE'
    Then I am on the 'Supplier details' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | GREENFELDER-LEUSCHKE |
      | DUNS Number | 013370637            |
      | Is an SME?  | Yes                  |
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I enter the following details into the form:
      | Supplier name | Atomised  |
      | DUNS Number   | 987654321 |
    And I select 'No'
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'Atomised'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | Atomised  |
      | DUNS Number | 987654321 |
      | Is an SME?  | No        |
