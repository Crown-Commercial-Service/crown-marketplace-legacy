Feature: Legal services - Admin - Supplier lot data - Lot 1a - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'LEDNER, BAILEY AND WEISSNAT'
    Then I am on the 'Supplier lot data' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And I click on 'View rates' for the lot 'Lot 1a - Full service provision (England and Wales)'
    Then I am on the 'Lot 1a - Full service provision View rates' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And the rates in the table are:
      | Position                                           | Hourly  |
      | Partner                                            | £245.00 |
      | Senior Solicitor, Senior Associate                 | £210.00 |
      | Solicitor, Associate                               | £175.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate | £140.00 |
      | Trainee                                            | £105.00 |
      | Paralegal, Legal Assistant                         | £70.00  |
    Given I click on 'Change (Rates for the supplier)'
    Then I am on the 'Edit rates' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'

  Scenario Outline: Rates validation
    Then I enter the following rates into the form:
      | Solicitor, Associate | <rate> |
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
      | Partner                                            | 10000.00 |
      | Senior Solicitor, Senior Associate                 | 1000.00  |
      | Solicitor, Associate                               | 1000.00  |
      | NQ Solicitor/Associate, Junior Solicitor/Associate | 100.90   |
      | Trainee                                            | 123      |
      | Paralegal, Legal Assistant                         | 456.78   |
      | LMP (Legal project manager) (optional)             | 106      |
    And I click on 'Save and return'
    Then I am on the 'Lot 1a - Full service provision View rates' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And the rates in the table are:
      | Position                                           | Hourly     |
      | Partner                                            | £10,000.00 |
      | Senior Solicitor, Senior Associate                 | £1,000.00  |
      | Solicitor, Associate                               | £1,000.00  |
      | NQ Solicitor/Associate, Junior Solicitor/Associate | £100.90    |
      | Trainee                                            | £123       |
      | Paralegal, Legal Assistant                         | £456.78    |
      | LMP (Legal project manager)                        | £106.00    |
