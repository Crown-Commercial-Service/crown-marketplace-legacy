Feature: Supply Teachers - Admin - Supplier lot data - Lot 2.2 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MCGLYNN, BAILEY AND NIKOLAUS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MCGLYNN, BAILEY AND NIKOLAUS'
    And I click on 'View rates' for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)'
    Then I am on the 'Lot 2.2 - Master vendor (more than 2.5 million) - Rates' page
    And the caption is 'MCGLYNN, BAILEY AND NIKOLAUS'
    And the rates in the table are:
      | Job type                                                                              | Agency mark-up Daily Supply | Agency mark-up Long Term (6 weeks+) |
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | £56.38                      | £53.56                              |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | £50.74                      | £48.20                              |
      | Senior Roles: Headteacher and Senior Leadership positions                             | £62.01                      | £58.90                              |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | £53.56                      | £50.88                              |
      | Over 12 Week Reduction                                                                | 10.0%                       | 10.0%                               |
      | Nominated Worker                                                                      | £45.10                      | £45.10                              |
      | Fixed Term                                                                            | 33.8%                       | 33.8%                               |
