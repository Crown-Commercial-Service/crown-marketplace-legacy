Feature: Management Consultancy - Admin - Supplier lot data - Lot 2 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MOSCISKI-CROOKS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MOSCISKI-CROOKS'
    And I click on 'View rates' for the lot 'Lot 2 - Strategy and Policy'
    Then I am on the 'Lot 2 - Strategy and Policy - Rates' page
    And the caption is 'MOSCISKI-CROOKS'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £14                   | £13                     |
      | Managing Consultant / Director             | £12                   | £11                     |
      | Principal Consultant / Associate Director  | £10                   | £9                      |
      | Senior Consultant / Manager / Project Lead | £8                    | £7                      |
      | Consultant / Senior Analyst                | £6                    | £5                      |
      | Analyst / Junior Consultant                | £4                    | £3                      |
