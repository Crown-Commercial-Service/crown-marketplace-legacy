Feature: Supply Teachers - Agency results - Fixed term - Results by location

  Background: Navigate to the What is your school’s postcode? page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
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
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW | London     |
      | MCGLYNN GROUP                | London     |
      | STANTON, FADEL AND BOSCO     | Twickenham |
      | DIETRICH-BORER               | London     |
      | HAGENES-BECHTELAR            | London     |
      | ZIEMANN-HERMANN              | London     |
      | EMARD AND SONS               | Twickenham |
      | FEEST-MULLER                 | London     |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 25 miles       |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for agency results are:
      | ZIEMANN-HERMANN | London |
      | FEEST-MULLER    | London |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 1 mile         |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for agency results are:
      | ZIEMANN-HERMANN | London |
      | FEEST-MULLER    | London |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 5 miles        |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW | London     |
      | MCGLYNN GROUP                | London     |
      | STANTON, FADEL AND BOSCO     | Twickenham |
      | DIETRICH-BORER               | London     |
      | HAGENES-BECHTELAR            | London     |
      | ZIEMANN-HERMANN              | London     |
      | EMARD AND SONS               | Twickenham |
      | FEEST-MULLER                 | London     |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 10 miles       |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 10 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW | London          |
      | CORKERY INC                  | Southend-on-Sea |
      | MCGLYNN GROUP                | London          |
      | STANTON, FADEL AND BOSCO     | Twickenham      |
      | DIETRICH-BORER               | London          |
      | KERLUKE, TORP AND HEATHCOTE  | Southend-on-Sea |
      | HAGENES-BECHTELAR            | London          |
      | ZIEMANN-HERMANN              | London          |
      | EMARD AND SONS               | Twickenham      |
      | FEEST-MULLER                 | London          |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 50 miles       |

  @geocode_liverpool
  Scenario: Liverpool postcode results
    And I enter 'L3 9PP' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW | Southport |
      | CORKERY INC                  | Liverpool |
      | STANTON, FADEL AND BOSCO     | Liverpool |
      | DIETRICH-BORER               | Southport |
      | KERLUKE, TORP AND HEATHCOTE  | Liverpool |
      | ZIEMANN-HERMANN              | Liverpool |
      | EMARD AND SONS               | Liverpool |
      | FEEST-MULLER                 | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 9PP                |
      | Search distance: 25 miles       |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 2 agencies
    And the listed agencies for agency results are:
      | CORKERY INC                 | Liverpool |
      | KERLUKE, TORP AND HEATHCOTE | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 9PP                |
      | Search distance: 1 mile         |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 4 agencies
    And the listed agencies for agency results are:
      | CORKERY INC                 | Liverpool |
      | STANTON, FADEL AND BOSCO    | Liverpool |
      | KERLUKE, TORP AND HEATHCOTE | Liverpool |
      | EMARD AND SONS              | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 9PP                |
      | Search distance: 5 miles        |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for agency results are:
      | CORKERY INC                 | Liverpool |
      | STANTON, FADEL AND BOSCO    | Liverpool |
      | KERLUKE, TORP AND HEATHCOTE | Liverpool |
      | ZIEMANN-HERMANN             | Liverpool |
      | EMARD AND SONS              | Liverpool |
      | FEEST-MULLER                | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 9PP                |
      | Search distance: 10 miles       |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 10 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW | Southport  |
      | CORKERY INC                  | Liverpool  |
      | MCGLYNN GROUP                | Manchester |
      | STANTON, FADEL AND BOSCO     | Liverpool  |
      | DIETRICH-BORER               | Southport  |
      | KERLUKE, TORP AND HEATHCOTE  | Liverpool  |
      | HAGENES-BECHTELAR            | Manchester |
      | ZIEMANN-HERMANN              | Liverpool  |
      | EMARD AND SONS               | Liverpool  |
      | FEEST-MULLER                 | Liverpool  |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 9PP                |
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
