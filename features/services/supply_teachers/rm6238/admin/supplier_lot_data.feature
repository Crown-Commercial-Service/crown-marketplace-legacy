Feature: Supply Teachers - Admin - Supplier lot data - Lot status

  Scenario: Lot status - Lot 1
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Active        |
      | Rates      | View rates    |
      | Branches   | View branches |
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Inactive |

  Scenario: Lot status - Lot 2
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for "O'HARA LLC"
    Then I am on the 'Supplier lot data' page
    And the caption is "O'HARA LLC"
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Active     |
      | Rates      | View rates |
    And I should see the following details in the summary for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)':
      | Lot status | Active     |
      | Rates      | View rates |
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Inactive |

  Scenario: Lot status - Lot 4
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BOYLE, KOEPP AND TURNER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BOYLE, KOEPP AND TURNER'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Active     |
      | Rates      | View rates |
