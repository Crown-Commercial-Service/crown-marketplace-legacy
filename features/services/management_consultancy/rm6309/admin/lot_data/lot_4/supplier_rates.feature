Feature: Management Consultancy - Admin - Supplier lot data - Lot 4 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'KOHLER-STOKES'
    Then I am on the 'Supplier lot data' page
    And the caption is 'KOHLER-STOKES'
    And I click on 'View rates' for the lot 'Lot 4 - Finance'
    Then I am on the 'Lot 4 - Finance - Rates' page
    And the caption is 'KOHLER-STOKES'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £13                   | £15                     |
      | Managing Consultant / Director             | £11                   | £13                     |
      | Principal Consultant / Associate Director  | £9                    | £11                     |
      | Senior Consultant / Manager / Project Lead | £7                    | £9                      |
      | Consultant / Senior Analyst                | £5                    | £7                      |
      | Analyst / Junior Consultant                | £3                    | £5                      |
