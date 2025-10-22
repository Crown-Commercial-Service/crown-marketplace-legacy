Feature: Management Consultancy - Admin - Supplier lot data - Lot 8 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GOTTLIEB, HEATHCOTE AND JACOBI'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GOTTLIEB, HEATHCOTE AND JACOBI'
    And I click on 'View rates' for the lot 'Lot 8 - Infrastructure'
    Then I am on the 'Lot 8 - Infrastructure - Rates' page
    And the caption is 'GOTTLIEB, HEATHCOTE AND JACOBI'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £17                   | £15                     |
      | Managing Consultant / Director             | £15                   | £13                     |
      | Principal Consultant / Associate Director  | £13                   | £11                     |
      | Senior Consultant / Manager / Project Lead | £11                   | £9                      |
      | Consultant / Senior Analyst                | £9                    | £7                      |
      | Analyst / Junior Consultant                | £7                    | £5                      |
