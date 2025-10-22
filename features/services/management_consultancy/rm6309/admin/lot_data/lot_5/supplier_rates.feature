Feature: Management Consultancy - Admin - Supplier lot data - Lot 5 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SCHINNER-LAKIN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SCHINNER-LAKIN'
    And I click on 'View rates' for the lot 'Lot 5 - HR'
    Then I am on the 'Lot 5 - HR - Rates' page
    And the caption is 'SCHINNER-LAKIN'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £12                   | £18                     |
      | Managing Consultant / Director             | £10                   | £16                     |
      | Principal Consultant / Associate Director  | £8                    | £14                     |
      | Senior Consultant / Manager / Project Lead | £6                    | £12                     |
      | Consultant / Senior Analyst                | £4                    | £10                     |
      | Analyst / Junior Consultant                | £2                    | £8                      |
