Feature: Management Consultancy - Admin - Supplier lot data - Lot 10 - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GUTMANN-PFEFFER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUTMANN-PFEFFER'
    And I should see the following details in the summary for the lot 'Lot 10 - Restructuring and insolvency':
      | Lot status | Enabled       |
      | Services   | View services |
      | Rates      | View rates    |
    And I click on 'Change Lot status (Lot 10 - Restructuring and insolvency)'
    Then I am on the 'Edit lot status' page
    And the caption is 'GUTMANN-PFEFFER'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUTMANN-PFEFFER'
    And I should see the following details in the summary for the lot 'Lot 10 - Restructuring and insolvency':
      | Lot status | Disabled      |
      | Services   | View services |
      | Rates      | View rates    |
