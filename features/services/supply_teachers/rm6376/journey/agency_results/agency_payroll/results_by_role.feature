@geocode_london
Feature: Supply Teachers - Agency results - Agency payroll - Results by role

  Background: Navigate to the postcode page
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    And I enter 'SW1A 1AA' for the 'postcode'

  Scenario: When the role is STEM Teacher (Inc. Qualified Teachers, Tutors)
    And I select 'STEM Teacher (Inc. Qualified Teachers, Tutors)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies with rates and distances are:
      | ROHAN LLC                    | London     | £37.34 | 0.2 |
      | GLOVER-ONDRICKA              | London     | £40.47 | 0.2 |
      | ROOB, CORWIN AND DICKI       | London     | £47.71 | 5.2 |
      | DANIEL AND SONS              | Twickenham | £60.24 | 9.0 |
      | TREMBLAY-WEST                | London     | £61.94 | 5.2 |
      | ROSENBAUM-HINTZ              | London     | £62.70 | 6.0 |
      | HEANEY GROUP                 | London     | £66.64 | 5.2 |
      | DARE-ROHAN                   | Twickenham | £68.79 | 9.0 |
      | FRITSCH-HAHN                 | London     | £80.77 | 6.0 |
      | TILLMAN-EMMERICH             | London     | £81.26 | 6.0 |
      | GRADY AND SONS               | London     | £81.82 | 0.2 |
      | SWANIAWSKI, CORWIN AND KUB   | Twickenham | £83.36 | 9.0 |  
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 25 miles                                             |
      | Job type: STEM Teacher (Inc. Qualified Teachers, Tutors)              |

  Scenario: When the role is Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers)
    And I select 'Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                    | London     | £28.00 | 0.2 |
      | GLOVER-ONDRICKA              | London     | £30.35 | 0.2 |
      | ROOB, CORWIN AND DICKI       | London     | £35.78 | 5.2 |
      | DANIEL AND SONS              | Twickenham | £45.18 | 9.0 |
      | TREMBLAY-WEST                | London     | £46.45 | 5.2 |
      | ROSENBAUM-HINTZ              | London     | £47.02 | 6.0 |
      | HEANEY GROUP                 | London     | £49.98 | 5.2 |
      | DARE-ROHAN                   | Twickenham | £51.59 | 9.0 |
      | FRITSCH-HAHN                 | London     | £60.57 | 6.0 |
      | TILLMAN-EMMERICH             | London     | £60.94 | 6.0 |
      | GRADY AND SONS               | London     | £61.37 | 0.2 |
      | SWANIAWSKI, CORWIN AND KUB   | Twickenham | £62.52 | 9.0 |    
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                                                 |
      | Worker type: Supplied by agency                                                                                |
      | Payroll provider: Agency                                                                                       |
      | Postcode: SW1A 1AA                                                                                             |
      | Search distance: 25 miles                                                                                      |
      | Job type: Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers) |

  Scenario: When the role is Senior Roles (Inc. Headteacher and Senior Leadership positions)
    And I select 'Senior Roles (Inc. Headteacher and Senior Leadership positions)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                    | London     | £37.34 | 0.2 |
      | GLOVER-ONDRICKA              | London     | £40.47 | 0.2 |
      | ROOB, CORWIN AND DICKI       | London     | £47.71 | 5.2 |
      | DANIEL AND SONS              | Twickenham | £60.24 | 9.0 |
      | TREMBLAY-WEST                | London     | £61.94 | 5.2 |
      | ROSENBAUM-HINTZ              | London     | £62.70 | 6.0 |
      | HEANEY GROUP                 | London     | £66.64 | 5.2 |
      | DARE-ROHAN                   | Twickenham | £68.79 | 9.0 |
      | FRITSCH-HAHN                 | London     | £80.77 | 6.0 |
      | TILLMAN-EMMERICH             | London     | £81.26 | 6.0 |
      | GRADY AND SONS               | London     | £81.82 | 0.2 |
      | SWANIAWSKI, CORWIN AND KUB   | Twickenham | £83.36 | 9.0 |    
    And the choices used to generate the list are:
      | Looking for: Individual worker                                      |
      | Worker type: Supplied by agency                                     |
      | Payroll provider: Agency                                            |
      | Postcode: SW1A 1AA                                                  |
      | Search distance: 25 miles                                           |
      | Job type: Senior Roles (Inc. Headteacher and Senior Leadership positions) |

  Scenario: When the role is Other (Inc. Invigilators, cleaners)
    And I select 'Other (Inc. Invigilators, cleaners)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                    | London     | £15.56 | 0.2 |
      | GLOVER-ONDRICKA              | London     | £16.86 | 0.2 |
      | ROOB, CORWIN AND DICKI       | London     | £19.88 | 5.2 |
      | DANIEL AND SONS              | Twickenham | £25.10 | 9.0 |
      | TREMBLAY-WEST                | London     | £25.81 | 5.2 |
      | ROSENBAUM-HINTZ              | London     | £26.12 | 6.0 |
      | HEANEY GROUP                 | London     | £27.77 | 5.2 |
      | DARE-ROHAN                   | Twickenham | £28.66 | 9.0 |
      | FRITSCH-HAHN                 | London     | £33.65 | 6.0 |
      | TILLMAN-EMMERICH             | London     | £33.86 | 6.0 |
      | GRADY AND SONS               | London     | £34.09 | 0.2 |
      | SWANIAWSKI, CORWIN AND KUB   | Twickenham | £34.73 | 9.0 |    
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                                  |
      | Worker type: Supplied by agency                                                                 |
      | Payroll provider: Agency                                                                        |
      | Postcode: SW1A 1AA                                                                              |
      | Search distance: 25 miles                                                                       |
      | Job type: Other (Inc. Invigilators, cleaners) |