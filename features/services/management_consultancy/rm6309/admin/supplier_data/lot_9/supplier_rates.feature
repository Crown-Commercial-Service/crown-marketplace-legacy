Feature: Management Consultancy - Admin - Supplier lot data - Lot 9 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GUTMANN-PFEFFER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUTMANN-PFEFFER'
    And I click on 'View rates' for the lot 'Lot 9 - Environment and Sustainability'
    Then I am on the 'Lot 9 - Environment and Sustainability - Rates' page
    And the caption is 'GUTMANN-PFEFFER'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £16                   | £17                     |
      | Managing Consultant / Director             | £14                   | £15                     |
      | Principal Consultant / Associate Director  | £12                   | £13                     |
      | Senior Consultant / Manager / Project Lead | £10                   | £11                     |
      | Consultant / Senior Analyst                | £8                    | £9                      |
      | Analyst / Junior Consultant                | £6                    | £7                      |
