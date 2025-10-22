Feature: Supply Teachers - Admin - Supplier lot data - Lot 4 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'CHRISTIANSEN INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CHRISTIANSEN INC'
    And I click on 'View rates' for the lot 'Lot 4 - Education technology platforms'
    Then I am on the 'Lot 4 - Education technology platforms - Rates' page
    And the caption is 'CHRISTIANSEN INC'
    And the rates in the table are:
      | Job type                                                                     | Supplier fee |
      | Agency Management Fee: Daily supply worker (per worker, per day)             | £8.31        |
      | Agency Management Fee: Long term assignment (6 weeks+) (per worker, per day) | £7.89        |
      | Nominated Worker                                                             | £7.47        |
      | Fixed Term                                                                   | 6.0%         |
