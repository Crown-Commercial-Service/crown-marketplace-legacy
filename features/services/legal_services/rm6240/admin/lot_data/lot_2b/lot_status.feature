Feature: Legal services - Admin - Supplier lot data - Lot 2b - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WEHNER, STEHR AND KULAS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And I should see the following details in the summary for the lot 'Lot 2b - General service provision (Scotland)':
      | Lot status | Enabled       |
      | Services   | View services |
      | Rates      | View rates    |
    And I click on 'Change Lot status (Lot 2b - General service provision (Scotland))'
    Then I am on the 'Edit lot status' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And I should see the following details in the summary for the lot 'Lot 2b - General service provision (Scotland)':
      | Lot status | Disabled      |
      | Services   | View services |
      | Rates      | View rates    |
