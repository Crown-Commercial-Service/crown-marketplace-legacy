Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'NIENOW-KERTZMANN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'NIENOW-KERTZMANN'
    And I click on 'View rates' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business - Rates' page
    And the caption is 'NIENOW-KERTZMANN'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £17                   | £12                     |
      | Managing Consultant / Director             | £15                   | £10                     |
      | Principal Consultant / Associate Director  | £13                   | £8                      |
      | Senior Consultant / Manager / Project Lead | £11                   | £6                      |
      | Consultant / Senior Analyst                | £9                    | £4                      |
      | Analyst / Junior Consultant                | £7                    | £2                      |
