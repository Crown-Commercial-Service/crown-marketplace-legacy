@geocode_london
Feature: Supply Teachers - Agency results - Agency payroll - Results by role

  Background: Navigate to the postcode page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    And I select '4 weeks to 8 weeks'
    And I enter 'SW1A 1AA' for the 'postcode'

  @pipeline
  Scenario: When the role is Qualified teacher: non-SEN roles
    And I select 'Qualified teacher: non-SEN roles'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | PAGAC INC                     | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | PFANNERSTILL-KUTCH            | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: SW1A 1AA                          |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |

  Scenario: When the role is Qualified teacher: SEN roles
    And I select 'Qualified teacher: SEN roles'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for 'agency results' are:
      | BOSCO INC                     | Twickenham  |
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: SW1A 1AA                          |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: SEN roles      |
      | Term: 4 weeks to 8 weeks                    |

  Scenario: When the role is Unqualified teacher: non-SEN roles
    And I select 'Unqualified teacher: non-SEN roles'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BOSCO INC                     | Twickenham  |
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | PAGAC INC                     | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                |
      | Worker type: Supplied by agency               |
      | Payroll provider: Agency                      |
      | Postcode: SW1A 1AA                            |
      | Search distance: 25 miles                     |
      | Job type: Unqualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                      |

  @pipeline
  Scenario: When the role is Unqualified teacher: SEN roles
    And I select 'Unqualified teacher: SEN roles'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 4 agencies
    And the listed agencies for 'agency results' are:
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: SW1A 1AA                          |
      | Search distance: 25 miles                   |
      | Job type: Unqualified teacher: SEN roles    |
      | Term: 4 weeks to 8 weeks                    |

  Scenario: When the role is Educational support staff: non-SEN
    And I select 'Educational support staff: non-SEN roles (including cover supervisor and teaching assistant)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | PAGAC INC                     | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                                          |
      | Worker type: Supplied by agency                                                                         |
      | Payroll provider: Agency                                                                                |
      | Postcode: SW1A 1AA                                                                                      |
      | Search distance: 25 miles                                                                               |
      | Job type: Educational support staff: non-SEN roles (including cover supervisor and teaching assistant)  |
      | Term: 4 weeks to 8 weeks                                                                                |

  Scenario: When the role is Educational support staff: SEN
    And I select 'Educational support staff: SEN roles (including cover supervisor and teaching assistant)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BOSCO INC                     | Twickenham  |
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | PFANNERSTILL-KUTCH            | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                                      |
      | Worker type: Supplied by agency                                                                     |
      | Payroll provider: Agency                                                                            |
      | Postcode: SW1A 1AA                                                                                  |
      | Search distance: 25 miles                                                                           |
      | Job type: Educational support staff: SEN roles (including cover supervisor and teaching assistant)  |
      | Term: 4 weeks to 8 weeks                                                                            |

  @pipeline
  Scenario: When the role is Headteacher and senior leadership positions
    And I select 'Headteacher and senior leadership positions'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | PFANNERSTILL-KUTCH            | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                        |
      | Worker type: Supplied by agency                       |
      | Payroll provider: Agency                              |
      | Postcode: SW1A 1AA                                    |
      | Search distance: 25 miles                             |
      | Job type: Headteacher and senior leadership positions |
      | Term: 4 weeks to 8 weeks                              |

  Scenario: When the role is Administrative and clerical staff
    And I select 'Administrative and clerical staff, IT staff, finance staff and cleaners'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for 'agency results' are:
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                                    |
      | Worker type: Supplied by agency                                                   |
      | Payroll provider: Agency                                                          |
      | Postcode: SW1A 1AA                                                                |
      | Search distance: 25 miles                                                         |
      | Job type: Administrative and clerical staff, IT staff, finance staff and cleaners |
      | Term: 4 weeks to 8 weeks                                                          |
