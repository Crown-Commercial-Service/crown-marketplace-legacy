Feature: Supply Teachers - Admin - Supplier details - Supplier information

  Scenario: Supplier information can be updated
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'ROLFSON-COLLIER'
    Then I am on the 'Supplier details' page
    And the caption is 'ROLFSON-COLLIER'
    And I should see the following details in the 'Supplier information' summary:
      | Name                  | ROLFSON-COLLIER                      |
      | Trading name          | YUNDT GROUP                          |
      | Additional identifier | ef24ca52-1dbb-47d3-80b1-cf6a93a0ad5f |
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'ROLFSON-COLLIER'
    And I enter the following details into the form:
      | Supplier name         | Call to the Void |
      | Trading name          | Kora             |
      | Additional identifier | 12345654321      |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'Call to the Void'
    And I should see the following details in the 'Supplier information' summary:
      | Name                  | Call to the Void |
      | Trading name          | Kora             |
      | Additional identifier | 12345654321      |
