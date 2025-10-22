Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I click on 'View rates' for the lot 'Lot 1 - Direct provision'
    Then I am on the 'Lot 1 - Direct provision - Rates' page
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
