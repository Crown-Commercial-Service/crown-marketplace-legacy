Feature: Management Consultancy - Admin - Supplier lot data - Lot 6 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SCHUMM, GRANT AND SPORER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SCHUMM, GRANT AND SPORER'
    And I click on 'View rates' for the lot 'Lot 6 - Procurement and Supply Chain'
    Then I am on the 'Lot 6 - Procurement and Supply Chain - Rates' page
    And the caption is 'SCHUMM, GRANT AND SPORER'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £16                   | £13                     |
      | Managing Consultant / Director             | £14                   | £11                     |
      | Principal Consultant / Associate Director  | £12                   | £9                      |
      | Senior Consultant / Manager / Project Lead | £10                   | £7                      |
      | Consultant / Senior Analyst                | £8                    | £5                      |
      | Analyst / Junior Consultant                | £6                    | £3                      |
