Feature: Supply Teachers - Agency results - Fixed term - Results by location

  Background: Navigate to the What is your school’s postcode? page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page

  @geocode_london
  Scenario: London postcode results
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for 'agency results' are:
      | BOSCO INC                     | Twickenham  |
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | PAGAC INC                     | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | PFANNERSTILL-KUTCH            | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 25 miles       |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for 'agency results' are:
      | JOHNS, GLEASON AND WHITE      | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 1 mile         |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for 'agency results' are:
      | JOHNS, GLEASON AND WHITE      | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 5 miles        |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for 'agency results' are:
      | BOSCO INC                     | Twickenham  |
      | BEATTY-DICKENS                | London      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  |
      | NIKOLAUS AND SONS             | London      |
      | PAGAC INC                     | London      |
      | JOHNS, GLEASON AND WHITE      | London      |
      | PFANNERSTILL-KUTCH            | London      |
      | MOSCISKI-ROHAN                | London      |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 10 miles       |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 10 agencies
    And the listed agencies for 'agency results' are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Southend-on-Sea |
      | BOSCO INC                     | Twickenham      |
      | BEATTY-DICKENS                | London          |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham      |
      | NIKOLAUS AND SONS             | London          |
      | PAGAC INC                     | London          |
      | KULAS-OKUNEVA                 | Southend-on-Sea |
      | JOHNS, GLEASON AND WHITE      | London          |
      | PFANNERSTILL-KUTCH            | London          |
      | MOSCISKI-ROHAN                | London          |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 50 miles       |

  @geocode_liverpool @pipeline
  Scenario: Liverpool postcode results
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for 'agency results' are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | BOSCO INC                     | Liverpool   |
      | BEATTY-DICKENS                | Southport   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | PAGAC INC                     | Southport   |
      | KULAS-OKUNEVA                 | Liverpool   |
      | JOHNS, GLEASON AND WHITE      | Liverpool   |
      | MOSCISKI-ROHAN                | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 25 miles       |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for 'agency results' are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | KULAS-OKUNEVA                 | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 1 mile         |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 4 agencies
    And the listed agencies for 'agency results' are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | BOSCO INC                     | Liverpool   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | KULAS-OKUNEVA                 | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 5 miles        |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for 'agency results' are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | BOSCO INC                     | Liverpool   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | KULAS-OKUNEVA                 | Liverpool   |
      | JOHNS, GLEASON AND WHITE      | Liverpool   |
      | MOSCISKI-ROHAN                | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 10 miles       |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 10 agencies
    And the listed agencies for 'agency results' are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool   |
      | BOSCO INC                     | Liverpool   |
      | BEATTY-DICKENS                | Southport   |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool   |
      | NIKOLAUS AND SONS             | Manchester  |
      | PAGAC INC                     | Southport   |
      | KULAS-OKUNEVA                 | Liverpool   |
      | JOHNS, GLEASON AND WHITE      | Liverpool   |
      | PFANNERSTILL-KUTCH            | Manchester  |
      | MOSCISKI-ROHAN                | Liverpool   |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 50 miles       |

  @geocode_birmingham
  Scenario: Birmingham postcode results
    And I enter 'B6 6HE' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 0 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: B6 6HE                |
      | Search distance: 25 miles       |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 0 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: B6 6HE                |
      | Search distance: 50 miles       |