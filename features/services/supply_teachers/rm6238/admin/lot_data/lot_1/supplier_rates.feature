Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I click on 'View rates' for the lot 'Lot 1 - Direct provision'
    Then I am on the 'Lot 1 - Direct provision View rates' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And the rates in the table are:
      | Job type                                                                              | Agency mark-up Daily Supply | Agency mark-up Long Term (6 weeks+) |
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | £27.59                      | £26.21                              |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | £24.83                      | £23.58                              |
      | Senior Roles: Headteacher and Senior Leadership positions                             | £30.34                      | £28.82                              |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | £26.21                      | £24.89                              |
      | Over 12 Week Reduction                                                                | 1.0%                        | 1.0%                                |
      | Nominated Worker                                                                      | £22.07                      | £22.07                              |
      | Fixed Term                                                                            | 16.6%                       | 16.6%                               |
    Given I click on 'Change (Rates for the supplier)'
    Then I am on the 'Edit rates' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'

  Scenario Outline: Rates validation - Money
    Then I enter the following rates into the form:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) | <rate> | 10.00 |
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
      | Over 12 Week Reduction | <rate> |
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
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | 123.11 | 456.55 |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | 123.22 | 456.66 |
      | Senior Roles: Headteacher and Senior Leadership positions                             | 123.33 | 456.77 |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | 123.44 | 456.88 |
      | Over 12 Week Reduction                                                                | 12.5   |        |
      | Nominated Worker                                                                      | 35     |        |
      | Fixed Term                                                                            | 99.0   |        |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Direct provision View rates' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And the rates in the table are:
      | Job type                                                                              | Agency mark-up Daily Supply | Agency mark-up Long Term (6 weeks+) |
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | £123.11                     | £456.55                             |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | £123.22                     | £456.66                             |
      | Senior Roles: Headteacher and Senior Leadership positions                             | £123.33                     | £456.77                             |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | £123.44                     | £456.88                             |
      | Over 12 Week Reduction                                                                | 12.5%                       | 12.5%                               |
      | Nominated Worker                                                                      | £35.00                      | £35.00                              |
      | Fixed Term                                                                            | 99.0%                       | 99.0%                               |
