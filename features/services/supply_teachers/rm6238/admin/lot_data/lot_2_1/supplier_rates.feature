Feature: Supply Teachers - Admin - Supplier lot data - Lot 2.1 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BOGAN, REICHERT AND COLLIER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BOGAN, REICHERT AND COLLIER'
    And I click on 'View rates' for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)'
    Then I am on the 'Lot 2.1 - Master vendor (less than 2.5 million) - Rates' page
    And the caption is 'BOGAN, REICHERT AND COLLIER'
    And the rates in the table are:
      | Job type                                                                              | Agency mark-up Daily Supply | Agency mark-up Long Term (6 weeks+) |
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | £30.30                      | £28.78                              |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | £27.27                      | £25.90                              |
      | Senior Roles: Headteacher and Senior Leadership positions                             | £33.33                      | £31.66                              |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | £28.78                      | £27.34                              |
      | Over 12 Week Reduction                                                                | 0.0%                        | 0.0%                                |
      | Nominated Worker                                                                      | £24.24                      | £24.24                              |
      | Fixed Term                                                                            | 18.2%                       | 18.2%                               |
