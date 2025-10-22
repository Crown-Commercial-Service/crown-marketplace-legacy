Feature: Management Consultancy - Admin - Supplier details - Supplier information

  Scenario: Supplier information can be updated
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'BERNHARD INC'
    Then I am on the 'Supplier details' page
    And the caption is 'BERNHARD INC'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | BERNHARD INC |
      | DUNS Number | 614904125    |
      | Is an SME?  | No           |
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'BERNHARD INC'
    And I enter the following details into the form:
      | Supplier name | To th Nth |
      | DUNS Number   | 987654321 |
    And I select 'Yes'
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'To th Nth'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | To th Nth |
      | DUNS Number | 987654321 |
      | Is an SME?  | Yes       |
