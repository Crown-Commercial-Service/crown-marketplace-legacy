Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'NIENOW-KERTZMANN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'NIENOW-KERTZMANN'
    And I click on 'View rates' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business View rates' page
    And the caption is 'NIENOW-KERTZMANN'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £17                   | £12                     |
      | Managing Consultant / Director             | £15                   | £10                     |
      | Principal Consultant / Associate Director  | £13                   | £8                      |
      | Senior Consultant / Manager / Project Lead | £11                   | £6                      |
      | Consultant / Senior Analyst                | £9                    | £4                      |
      | Analyst / Junior Consultant                | £7                    | £2                      |
    Given I click on 'Change (Rates for the supplier)'
    Then I am on the 'Edit rates' page
    And the caption is 'NIENOW-KERTZMANN'

  Scenario Outline: Rates validation
    Then I enter the following rates into the form:
      | Principal Consultant / Associate Director | <rate> | 10.00 |
    And I click on 'Save and return'
    Then I am on the 'Edit rates' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | rate        | error_message                                            |
      |             | You must enter a value for this rate                     |
      | Not a rate  | The rate must be formatted as money, for example £350.50 |
      | 55.5        | The rate must be formatted as money, for example £350.50 |
      | 10000000.00 | The rate must be less than £1,000,000                    |

  Scenario: Set rates
    Then I enter the following rates into the form:
      | Partner / Managing Director                | 123.12  | 23.12  |
      | Managing Consultant / Director             | 456.34  | 56.34  |
      | Principal Consultant / Associate Director  | 789.54  | 89.54  |
      | Senior Consultant / Manager / Project Lead | 1123.78 | 123.78 |
      | Consultant / Senior Analyst                | 4456.87 | 456.87 |
      | Analyst / Junior Consultant                | 7789.88 | 789.88 |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Business View rates' page
    And the caption is 'NIENOW-KERTZMANN'
    And the rates in the table are:
      | Position                                   | Max day rate (Advice) | Max day rate (Delivery) |
      | Partner / Managing Director                | £123                  | £23                     |
      | Managing Consultant / Director             | £456                  | £56                     |
      | Principal Consultant / Associate Director  | £790                  | £90                     |
      | Senior Consultant / Manager / Project Lead | £1,124                | £124                    |
      | Consultant / Senior Analyst                | £4,457                | £457                    |
      | Analyst / Junior Consultant                | £7,790                | £790                    |
