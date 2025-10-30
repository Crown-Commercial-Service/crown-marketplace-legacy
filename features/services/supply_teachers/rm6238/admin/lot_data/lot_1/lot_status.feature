Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Enabled       |
      | Rates      | View rates    |
      | Branches   | View branches |
    And I click on 'Change Lot status (Lot 1 - Direct provision)'
    Then I am on the 'Edit lot status' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Disabled      |
      | Rates      | View rates    |
      | Branches   | View branches |
