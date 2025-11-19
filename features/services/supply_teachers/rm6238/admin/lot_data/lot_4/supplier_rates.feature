Feature: Supply Teachers - Admin - Supplier lot data - Lot 4 - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'CHRISTIANSEN INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CHRISTIANSEN INC'
    And I click on 'View rates' for the lot 'Lot 4 - Education technology platforms'
    Then I am on the 'Lot 4 - Education technology platforms View rates' page
    And the caption is 'CHRISTIANSEN INC'
    And the rates in the table are:
      | Job type                                                                     | Supplier fee |
      | Agency Management Fee: Daily supply worker (per worker, per day)             | £8.31        |
      | Agency Management Fee: Long term assignment (6 weeks+) (per worker, per day) | £7.89        |
      | Nominated Worker                                                             | £7.47        |
      | Fixed Term                                                                   | 6.0%         |
    Given I click on 'Change (Rates for the supplier)'
    Then I am on the 'Edit rates' page
    And the caption is 'CHRISTIANSEN INC'

  Scenario Outline: Rates validation - Money
    Then I enter the following rates into the form:
      | Agency Management Fee: Daily supply worker (per worker, per day) | <rate> |
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

  Scenario Outline: Rates validation - Percentage
    Then I enter the following rates into the form:
      | Fixed Term | <rate> |
    And I click on 'Save and return'
    Then I am on the 'Edit rates' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | rate       | error_message                                                 |
      |            | You must enter a value for this rate                          |
      | Not a rate | The rate must be formatted as a percentage, for example 50.5% |
      | 55.5555    | The rate must be formatted as a percentage, for example 50.5% |
      | 100.0      | The rate must be less than 100%                               |

  Scenario: Set rates
    Then I enter the following rates into the form:
      | Agency Management Fee: Daily supply worker (per worker, per day)             | 100 |
      | Agency Management Fee: Long term assignment (6 weeks+) (per worker, per day) | 200 |
      | Nominated Worker                                                             | 400 |
      | Fixed Term                                                                   | 12  |
    And I click on 'Save and return'
    Then I am on the 'Lot 4 - Education technology platforms View rates' page
    And the caption is 'CHRISTIANSEN INC'
    And the rates in the table are:
      | Job type                                                                     | Supplier fee |
      | Agency Management Fee: Daily supply worker (per worker, per day)             | £100.00      |
      | Agency Management Fee: Long term assignment (6 weeks+) (per worker, per day) | £200.00      |
      | Nominated Worker                                                             | £400.00      |
      | Fixed Term                                                                   | 12.0%        |
