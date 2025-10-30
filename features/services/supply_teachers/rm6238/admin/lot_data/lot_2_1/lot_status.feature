Feature: Supply Teachers - Admin - Supplier lot data - Lot 2.1 - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BOGAN, REICHERT AND COLLIER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BOGAN, REICHERT AND COLLIER'
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Enabled    |
      | Rates      | View rates |
    And I click on 'Change Lot status (Lot 2.1 - Master vendor (less than 2.5 million))'
    Then I am on the 'Edit lot status' page
    And the caption is 'BOGAN, REICHERT AND COLLIER'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BOGAN, REICHERT AND COLLIER'
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Disabled   |
      | Rates      | View rates |
