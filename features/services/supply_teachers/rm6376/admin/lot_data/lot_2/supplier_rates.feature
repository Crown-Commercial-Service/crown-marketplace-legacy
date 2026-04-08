Feature: Supply Teachers - Admin - Supplier lot data - Lot 2.1 - View rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'LANG INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'LANG INC'
    And I click on 'View rates' for the lot 'Lot 2 - Managed service provider'
    Then I am on the 'Lot 2 - Managed service provider View rates' page
    And the caption is 'LANG INC'
    And the rates in the table are:
      | Job type                                                                                                 | Agency mark-up |
      | STEM Teacher (Inc. Qualified Teachers, Tutors)                                                           | £44.94         |
      | Non - STEM Teacher (Inc. Qualified Teachers, Tutors)                                                     | £37.45         |
      | Educational Support Staff non SEND (inc. Cover Supervisor, Teaching Assistants and unqualified teachers) | £26.21         |
      | Educational Support Staff SEND (inc. Cover Supervisor, Teaching Assistants and unqualified teachers)     | £33.70         |
      | Senior Roles (inc. Headteacher and Senior Leadership positions)                                          | £44.94         |
      | Facilities Management (Inc. Caretakers, site roles etc)                                                  | £29.96         |
      | Admin & Clerical (Inc. Office Staff, Finance support)                                                    | £28.08         |
      | Other (Inc. invigilators, cleaners, etc)                                                                 | £18.72         |
      | Over 12 Week Reduction                                                                                   | 35.6%          |
      | Nominated Workers                                                                                        | 39.3%          |
      | Fixed Term / Permanent Roles (on School Payroll)                                                         | 31.8%          |