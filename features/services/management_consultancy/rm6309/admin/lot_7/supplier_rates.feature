Feature: Management Consultancy - Admin - Supplier lot data - Lot 7 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'STROMAN-ROMAGUERA'
    Then I am on the 'Supplier lot data' page
    And the caption is 'STROMAN-ROMAGUERA'
    And I click on 'View rates' for the lot 'Lot 7 - Health, Social Care and Community'
    Then I am on the 'Lot 7 - Health, Social Care and Community - Rates' page
    And the caption is 'STROMAN-ROMAGUERA'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £18                   | £15                     |
      | Managing Consultant / Director             | £16                   | £13                     |
      | Principal Consultant / Associate Director  | £14                   | £11                     |
      | Senior Consultant / Manager / Project Lead | £12                   | £9                      |
      | Consultant / Senior Analyst                | £10                   | £7                      |
      | Analyst / Junior Consultant                | £8                    | £5                      |
