@geocode_london
Feature: Supply Teachers - Agency results - Agency payroll - Results by role

  Background: Navigate to the postcode page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    And I select 'Daily Supply'
    And I enter 'SW1A 1AA' for the 'postcode'

  @pipeline
  Scenario: When the role is Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)
    And I select 'Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies with rates and distances are:
      | BARTOLETTI, KOEPP AND NIENOW  | London      | £27.59  | 6.0 |
      | MCGLYNN GROUP                 | London      | £39.84  | 5.2 |
      | STANTON, FADEL AND BOSCO      | Twickenham  | £41.45  | 9.0 |
      | EMARD AND SONS                | Twickenham  | £58.35  | 9.0 |
      | FEEST-MULLER                  | London      | £59.55  | 0.2 |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 25 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |

  Scenario: When the role is Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)
    And I select 'Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 4 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW  | London      | £24.83  | 6.0 |
      | MCGLYNN GROUP                 | London      | £35.85  | 5.2 |
      | EMARD AND SONS                | Twickenham  | £52.51  | 9.0 |
      | FEEST-MULLER                  | London      | £53.59  | 0.2 |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                      |
      | Worker type: Supplied by agency                                                     |
      | Payroll provider: Agency                                                            |
      | Postcode: SW1A 1AA                                                                  |
      | Search distance: 25 miles                                                           |
      | Job type: Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)  |
      | Term: Daily Supply                                                                  |

  @pipeline
  Scenario: When the role is Senior Roles: Headteacher and Senior Leadership positions
    And I select 'Senior Roles: Headteacher and Senior Leadership positions'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW  | London      | £30.34  | 6.0 |
      | MCGLYNN GROUP                 | London      | £43.82  | 5.2 |
      | DIETRICH-BORER                | London      | £46.92  | 6.0 |
      | ZIEMANN-HERMANN               | London      | £58.92  | 0.2 |
      | EMARD AND SONS                | Twickenham  | £64.18  | 9.0 |
      | FEEST-MULLER                  | London      | £65.50  | 0.2 |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                      |
      | Worker type: Supplied by agency                                     |
      | Payroll provider: Agency                                            |
      | Postcode: SW1A 1AA                                                  |
      | Search distance: 25 miles                                           |
      | Job type: Senior Roles: Headteacher and Senior Leadership positions |
      | Term: Daily Supply                                                  |

  Scenario: When the role is Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.)
    And I select 'Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW  | London      | £26.21  | 6.0 |
      | MCGLYNN GROUP                 | London      | £37.84  | 5.2 |
      | HAGENES-BECHTELAR             | London      | £47.48  | 5.2 |
      | ZIEMANN-HERMANN               | London      | £50.89  | 0.2 |
      | EMARD AND SONS                | Twickenham  | £55.43  | 9.0 |
      | FEEST-MULLER                  | London      | £56.57  | 0.2 |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                                  |
      | Worker type: Supplied by agency                                                                 |
      | Payroll provider: Agency                                                                        |
      | Postcode: SW1A 1AA                                                                              |
      | Search distance: 25 miles                                                                       |
      | Job type: Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) |
      | Term: Daily Supply                                                                              |
