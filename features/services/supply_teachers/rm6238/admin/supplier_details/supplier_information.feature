Feature: Supply Teachers - Admin - Supplier details - Supplier information

  Scenario: Supplier information can be updated
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'CHRISTIANSEN INC'
    Then I am on the 'Supplier details' page
    And the caption is 'CHRISTIANSEN INC'
    And I should see the following details in the 'Supplier information' summary:
      | Name | CHRISTIANSEN INC |
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'CHRISTIANSEN INC'
    And I enter the following details into the form:
      | Supplier name | The Antidote Is in the Poison |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'The Antidote Is in the Poison'
    And I should see the following details in the 'Supplier information' summary:
      | Name | The Antidote Is in the Poison |
