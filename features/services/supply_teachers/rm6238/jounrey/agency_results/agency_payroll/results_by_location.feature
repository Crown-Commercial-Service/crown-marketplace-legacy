Feature: Supply Teachers - Agency results - Agency payroll - Results by location

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
    And I select 'Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)'
    And I select 'Daily Supply'

  @geocode_london @pipeline
  Scenario: London postcode results
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for 'agency results' are:
      | BARTOLETTI, KOEPP AND NIENOW  | London      |
      | MCGLYNN GROUP                 | London      |
      | STANTON, FADEL AND BOSCO      | Twickenham  |
      | EMARD AND SONS                | Twickenham  |
      | FEEST-MULLER                  | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 25 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 1 agencies
    And the listed agencies for 'agency results' are:
      | FEEST-MULLER                  | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 1 mile                                               |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 1 agencies
    And the listed agencies for 'agency results' are:
      | FEEST-MULLER                  | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 5 miles                                              |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for 'agency results' are:
      | BARTOLETTI, KOEPP AND NIENOW  | London      |
      | MCGLYNN GROUP                 | London      |
      | STANTON, FADEL AND BOSCO      | Twickenham  |
      | EMARD AND SONS                | Twickenham  |
      | FEEST-MULLER                  | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 10 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BARTOLETTI, KOEPP AND NIENOW  | London          |
      | MCGLYNN GROUP                 | London          |
      | STANTON, FADEL AND BOSCO      | Twickenham      |
      | KERLUKE, TORP AND HEATHCOTE   | Southend-on-Sea |
      | EMARD AND SONS                | Twickenham      |
      | FEEST-MULLER                  | London          |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: SW1A 1AA                                                    |
      | Search distance: 50 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |

  @geocode_liverpool
  Scenario: Liverpool postcode results
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for 'agency results' are:
      | BARTOLETTI, KOEPP AND NIENOW  | Southport   |
      | STANTON, FADEL AND BOSCO      | Liverpool   |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool   |
      | EMARD AND SONS                | Liverpool   |
      | FEEST-MULLER                  | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: L3 4AA                                                      |
      | Search distance: 25 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 1 agencies
    And the listed agencies for 'agency results' are:
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: L3 4AA                                                      |
      | Search distance: 1 mile                                               |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 3 agencies
    And the listed agencies for 'agency results' are:
      | STANTON, FADEL AND BOSCO      | Liverpool   |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool   |
      | EMARD AND SONS                | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: L3 4AA                                                      |
      | Search distance: 5 miles                                              |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 4 agencies
    And the listed agencies for 'agency results' are:
      | STANTON, FADEL AND BOSCO      | Liverpool   |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool   |
      | EMARD AND SONS                | Liverpool   |
      | FEEST-MULLER                  | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: L3 4AA                                                      |
      | Search distance: 10 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | BARTOLETTI, KOEPP AND NIENOW  | Southport   |
      | MCGLYNN GROUP                 | Manchester  |
      | STANTON, FADEL AND BOSCO      | Liverpool   |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool   |
      | EMARD AND SONS                | Liverpool   |
      | FEEST-MULLER                  | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: L3 4AA                                                      |
      | Search distance: 50 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |

  @geocode_birmingham
  Scenario: Birmingham postcode results
    And I enter 'B6 6HE' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 0 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: B6 6HE                                                      |
      | Search distance: 25 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 0 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker                                        |
      | Worker type: Supplied by agency                                       |
      | Payroll provider: Agency                                              |
      | Postcode: B6 6HE                                                      |
      | Search distance: 50 miles                                             |
      | Job type: Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) |
      | Term: Daily Supply                                                    |
