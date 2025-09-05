Feature: Legal services - Admin - Supplier lot data - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'COLLINS, COLE AND PACOCHA'
    Then I am on the 'Supplier lot data' page
    And the caption is 'COLLINS, COLE AND PACOCHA'
    And I should see the following details in the summary for the lot 'Lot 1a - Full service provision (England and Wales)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 1b - Full service provision (Scotland)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 1c - Full service provision (Northern Ireland)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2a - General service provision (England and Wales)':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 2b - General service provision (Scotland)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2c - General service provision (Northern Ireland)':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 3 - Transport rail legal services':
      | Lot status | Inactive |
