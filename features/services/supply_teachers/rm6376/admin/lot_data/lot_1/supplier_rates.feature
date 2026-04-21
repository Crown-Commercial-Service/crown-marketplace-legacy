Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'NADER, CONN AND REINGER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'NADER, CONN AND REINGER'
    And I click on 'View rates' for the lot 'Lot 1 - Direct provision'
    Then I am on the 'Lot 1 - Direct provision View rates' page
    And the caption is 'NADER, CONN AND REINGER'
    And the rates in the table are:
      | Job type                                                                                                 | Agency mark-up |
      | STEM Teacher (Inc. Qualified Teachers, Tutors)                                                           | £52.62         |
      | Non-STEM Teachers (Inc. Qualified Teachers, Tutors)                                                      | £43.85         |
      | Educational Support Staff non SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers) | £30.69         |
      | Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers)     | £39.46         |
      | Senior Roles (Inc. Headteacher and Senior Leadership positions)                                          | £52.62         |
      | Facilities Management (Inc. Caretakers, site roles etc)                                                  | £35.08         |
      | Admin & Clerical (Inc. Office Staff, Finance Support)                                                    | £32.88         |
      | Other (Inc. Invigilators, cleaners)                                                                      | £21.92         |
      | Over 12 Week Reduction                                                                                   | 41.7%          |
      | Nominated Workers                                                                                        | 46.0%          |
      | Fixed Term / Permanent Roles (on School Payroll)                                                         | 37.3%          |
    Given I click on 'Change (Rates for the supplier)'
    Then I am on the 'Edit rates' page
    And the caption is 'NADER, CONN AND REINGER'

  Scenario Outline: Rates validation - Money
    Then I enter the following rates into the form:
      | STEM Teacher (Inc. Qualified Teachers, Tutors) | <rate> |
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
      | STEM Teacher (Inc. Qualified Teachers, Tutors)                                                           | 123.11 |
      | Non-STEM Teachers (Inc. Qualified Teachers, Tutors)                                                      | 123.11 |
      | Educational Support Staff non SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers) | 123.11 |
      | Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers)     | 123.11 |
      | Senior Roles (Inc. Headteacher and Senior Leadership positions)                                          | 123.11 |
      | Facilities Management (Inc. Caretakers, site roles etc)                                                  | 123.11 |
      | Admin & Clerical (Inc. Office Staff, Finance Support)                                                    | 123.11 |
      | Other (Inc. Invigilators, cleaners)                                                                      | 123.11 |
      | Over 12 Week Reduction                                                                                   | 12.5   |
      | Nominated Workers                                                                                        | 35     |
      | Fixed Term / Permanent Roles (on School Payroll)                                                         | 99.0   |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Direct provision View rates' page
    And the caption is 'NADER, CONN AND REINGER'
    And the rates in the table are:
      | Job type                                                                                                 | Agency mark-up |
      | STEM Teacher (Inc. Qualified Teachers, Tutors)                                                           | 123.11         |
      | Non-STEM Teachers (Inc. Qualified Teachers, Tutors)                                                      | 123.11         |
      | Educational Support Staff non SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers) | 123.11         |
      | Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers)     | 123.11         |
      | Senior Roles (Inc. Headteacher and Senior Leadership positions)                                          | 123.11         |
      | Facilities Management (Inc. Caretakers, site roles etc)                                                  | 123.11         |
      | Admin & Clerical (Inc. Office Staff, Finance Support)                                                    | 123.11         |
      | Other (Inc. Invigilators, cleaners)                                                                      | 123.11         |
      | Over 12 Week Reduction                                                                                   | 12.5           |
      | Nominated Workers                                                                                        | 35             |
      | Fixed Term / Permanent Roles (on School Payroll)                                                         | 99.0           |
