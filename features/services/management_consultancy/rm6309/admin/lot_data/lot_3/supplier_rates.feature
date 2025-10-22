Feature: Management Consultancy - Admin - Supplier lot data - Lot 3 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GREENFELDER-LEUSCHKE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I click on 'View rates' for the lot 'Lot 3 - Complex and Transformation'
    Then I am on the 'Lot 3 - Complex and Transformation - Rates' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £19                   | £16                     |
      | Managing Consultant / Director             | £17                   | £14                     |
      | Principal Consultant / Associate Director  | £15                   | £12                     |
      | Senior Consultant / Manager / Project Lead | £13                   | £10                     |
      | Consultant / Senior Analyst                | £11                   | £8                      |
      | Analyst / Junior Consultant                | £9                    | £6                      |
