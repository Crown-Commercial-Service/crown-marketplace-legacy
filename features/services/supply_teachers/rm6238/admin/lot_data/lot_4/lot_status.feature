Feature: Supply Teachers - Admin - Supplier lot data - Lot 4 - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'CHRISTIANSEN INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CHRISTIANSEN INC'
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Enabled    |
      | Rates      | View rates |
    And I click on 'Change Lot status (Lot 4 - Education technology platforms)'
    Then I am on the 'Edit lot status' page
    And the caption is 'CHRISTIANSEN INC'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CHRISTIANSEN INC'
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Disabled   |
      | Rates      | View rates |
