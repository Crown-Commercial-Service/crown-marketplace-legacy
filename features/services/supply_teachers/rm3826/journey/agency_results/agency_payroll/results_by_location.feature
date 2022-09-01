Feature: Supply Teachers - Agency results - Agency payroll - Results by location

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
    And I select 'Qualified teacher: non-SEN roles'
    And I select '4 weeks to 8 weeks'

  @geocode_london @pipeline
  Scenario: London postcode results
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for agency results are:
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
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 1 agencies
    And the listed agencies for agency results are:
      | JOHNS, GLEASON AND WHITE      | London      |
      And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: SW1A 1AA                          |
      | Search distance: 1 mile                     |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 1 agencies
    And the listed agencies for agency results are:
      | JOHNS, GLEASON AND WHITE      | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: SW1A 1AA                          |
      | Search distance: 5 miles                    |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for agency results are:
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
      | Search distance: 10 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 7 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Southend-on-Sea |
      | BEATTY-DICKENS                | London          |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham      |
      | NIKOLAUS AND SONS             | London          |
      | PAGAC INC                     | London          |
      | JOHNS, GLEASON AND WHITE      | London          |
      | PFANNERSTILL-KUTCH            | London          |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: SW1A 1AA                          |
      | Search distance: 50 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |

  @geocode_liverpool
  Scenario: Liverpool postcode results
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | BEATTY-DICKENS                | Southport   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | PAGAC INC                     | Southport   |
      | JOHNS, GLEASON AND WHITE      | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 1 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 1 mile                     |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 5 miles                    |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 3 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | JOHNS, GLEASON AND WHITE      | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 10 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 7 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | BEATTY-DICKENS                | Southport   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | NIKOLAUS AND SONS             | Manchester  |
      | PAGAC INC                     | Southport   |
      | JOHNS, GLEASON AND WHITE      | Liverpool   |
      | PFANNERSTILL-KUTCH            | Manchester  |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 50 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |

  @geocode_birmingham
  Scenario: Birmingham postcode results
    And I enter 'B6 6HE' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 0 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: B6 6HE                            |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 0 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: B6 6HE                            |
      | Search distance: 50 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: 4 weeks to 8 weeks                    |
