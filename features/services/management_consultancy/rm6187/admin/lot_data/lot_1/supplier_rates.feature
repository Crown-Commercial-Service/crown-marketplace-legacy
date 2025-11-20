Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'TREMBLAY-MOORE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'TREMBLAY-MOORE'
    And I click on 'View rates' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business View rates' page
    And the caption is 'TREMBLAY-MOORE'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £6           |
      | Consultant                                            | £8           |
      | Senior Consultant / Engagement Manager / Project Lead | £10          |
      | Principal Consultant / Associate Director             | £12          |
      | Managing Consultant / Director                        | £14          |
      | Partner                                               | £16          |
    Given I click on 'Change (Rates for the supplier)'
    Then I am on the 'Edit rates' page
    And the caption is 'TREMBLAY-MOORE'

  Scenario Outline: Rates validation
    Then I enter the following rates into the form:
      | Managing Consultant / Director | <rate> |
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
      | Analyst / Junior Consultant                           | 10000.00 |
      | Consultant                                            | 1000.00  |
      | Senior Consultant / Engagement Manager / Project Lead | 1000.00  |
      | Principal Consultant / Associate Director             | 100.90   |
      | Managing Consultant / Director                        | 123      |
      | Partner                                               | 456.78   |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Business View rates' page
    And the caption is 'TREMBLAY-MOORE'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £10,000      |
      | Consultant                                            | £1,000       |
      | Senior Consultant / Engagement Manager / Project Lead | £1,000       |
      | Principal Consultant / Associate Director             | £101         |
      | Managing Consultant / Director                        | £123         |
      | Partner                                               | £457         |
