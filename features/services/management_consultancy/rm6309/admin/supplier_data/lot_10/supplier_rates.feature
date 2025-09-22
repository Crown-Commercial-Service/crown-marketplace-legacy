Feature: Management Consultancy - Admin - Supplier lot data - Lot 10 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GUTMANN-PFEFFER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUTMANN-PFEFFER'
    And I click on 'View rates' for the lot 'Lot 10 - Restructuring and insolvency'
    Then I am on the 'Lot 10 - Restructuring and insolvency - Rates' page
    And the caption is 'GUTMANN-PFEFFER'
    And the rates in the table are:
      | Position                                   | Max day rate (Complex) | Max day rate (Non-Complex) |
      | Partner / Managing Director                | £17                    | £15                        |
      | Managing Consultant / Director             | £15                    | £13                        |
      | Principal Consultant / Associate Director  | £13                    | £11                        |
      | Senior Consultant / Manager / Project Lead | £11                    | £9                         |
      | Consultant / Senior Analyst                | £9                     | £7                         |
      | Analyst / Junior Consultant                | £7                     | £5                         |
