Feature: Supply Teachers - Agency results - Nominated worker - Results by location

  Background: Navigate to the What is your school’s postcode? page
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page

  @geocode_london
  Scenario: London postcode results
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | London     |
      | GLOVER-ONDRICKA            | London     |
      | ROOB, CORWIN AND DICKI     | London     |
      | DANIEL AND SONS            | Twickenham |
      | TREMBLAY-WEST              | London     |
      | ROSENBAUM-HINTZ            | London     |
      | HEANEY GROUP               | London     |
      | DARE-ROHAN                 | Twickenham |
      | FRITSCH-HAHN               | London     |
      | TILLMAN-EMMERICH           | London     |
      | GRADY AND SONS             | London     |
      | SWANIAWSKI, CORWIN AND KUB | Twickenham |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: SW1A 1AA             |
      | Search distance: 25 miles      |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 3 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC       | London |
      | GLOVER-ONDRICKA | London |
      | GRADY AND SONS  | London |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: SW1A 1AA             |
      | Search distance: 1 mile        |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 3 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC       | London |
      | GLOVER-ONDRICKA | London |
      | GRADY AND SONS  | London |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: SW1A 1AA             |
      | Search distance: 5 miles       |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | London     |
      | GLOVER-ONDRICKA            | London     |
      | ROOB, CORWIN AND DICKI     | London     |
      | DANIEL AND SONS            | Twickenham |
      | TREMBLAY-WEST              | London     |
      | ROSENBAUM-HINTZ            | London     |
      | HEANEY GROUP               | London     |
      | DARE-ROHAN                 | Twickenham |
      | FRITSCH-HAHN               | London     |
      | TILLMAN-EMMERICH           | London     |
      | GRADY AND SONS             | London     |
      | SWANIAWSKI, CORWIN AND KUB | Twickenham |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: SW1A 1AA             |
      | Search distance: 10 miles      |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 15 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | London          |
      | GLOVER-ONDRICKA            | London          |
      | ROOB, CORWIN AND DICKI     | London          |
      | SATTERFIELD AND SONS       | Southend-on-Sea |
      | NADER, CONN AND REINGER    | Southend-on-Sea |
      | GULGOWSKI-HUDSON           | Southend-on-Sea |
      | DANIEL AND SONS            | Twickenham      |
      | TREMBLAY-WEST              | London          |
      | ROSENBAUM-HINTZ            | London          |
      | HEANEY GROUP               | London          |
      | DARE-ROHAN                 | Twickenham      |
      | FRITSCH-HAHN               | London          |
      | TILLMAN-EMMERICH           | London          |
      | GRADY AND SONS             | London          |
      | SWANIAWSKI, CORWIN AND KUB | Twickenham      |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: SW1A 1AA             |
      | Search distance: 50 miles      |

  @geocode_liverpool
  Scenario: Liverpool postcode results
    And I enter 'L3 9PP' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | Liverpool |
      | GLOVER-ONDRICKA            | Liverpool |
      | SATTERFIELD AND SONS       | Liverpool |
      | NADER, CONN AND REINGER    | Liverpool |
      | GULGOWSKI-HUDSON           | Liverpool |
      | DANIEL AND SONS            | Liverpool |
      | ROSENBAUM-HINTZ            | Southport |
      | DARE-ROHAN                 | Liverpool |
      | FRITSCH-HAHN               | Southport |
      | TILLMAN-EMMERICH           | Southport |
      | GRADY AND SONS             | Liverpool |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: L3 9PP               |
      | Search distance: 25 miles      |
    And I click on '1 mile'
    Then I am on the 'Agency results' page
    And there are 3 agencies
    And the listed agencies for agency results are:
      | SATTERFIELD AND SONS    | Liverpool |
      | NADER, CONN AND REINGER | Liverpool |
      | GULGOWSKI-HUDSON        | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: L3 9PP               |
      | Search distance: 1 mile        |
    And I click on '5 miles'
    Then I am on the 'Agency results' page
    And there are 6 agencies
    And the listed agencies for agency results are:
      | SATTERFIELD AND SONS       | Liverpool |
      | NADER, CONN AND REINGER    | Liverpool |
      | GULGOWSKI-HUDSON           | Liverpool |
      | DANIEL AND SONS            | Liverpool |
      | DARE-ROHAN                 | Liverpool |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: L3 9PP               |
      | Search distance: 5 miles       |
    And I click on '10 miles'
    Then I am on the 'Agency results' page
    And there are 9 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | Liverpool |
      | GLOVER-ONDRICKA            | Liverpool |
      | SATTERFIELD AND SONS       | Liverpool |
      | NADER, CONN AND REINGER    | Liverpool |
      | GULGOWSKI-HUDSON           | Liverpool |
      | DANIEL AND SONS            | Liverpool |
      | DARE-ROHAN                 | Liverpool |
      | GRADY AND SONS             | Liverpool |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: L3 9PP               |
      | Search distance: 10 miles      |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 15 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | Liverpool  |
      | GLOVER-ONDRICKA            | Liverpool  |
      | ROOB, CORWIN AND DICKI     | Manchester |
      | SATTERFIELD AND SONS       | Liverpool  |
      | NADER, CONN AND REINGER    | Liverpool  |
      | GULGOWSKI-HUDSON           | Liverpool  |
      | DANIEL AND SONS            | Liverpool  |
      | TREMBLAY-WEST              | Manchester |
      | ROSENBAUM-HINTZ            | Southport  |
      | HEANEY GROUP               | Manchester |
      | DARE-ROHAN                 | Liverpool  |
      | FRITSCH-HAHN               | Southport  |
      | TILLMAN-EMMERICH           | Southport  |
      | GRADY AND SONS             | Liverpool  |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool  |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: L3 9PP               |
      | Search distance: 50 miles      |

  @geocode_birmingham
  Scenario: Birmingham postcode results
    And I enter 'B6 6HE' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | Birmingham    |
      | GLOVER-ONDRICKA            | Birmingham    |
      | ROOB, CORWIN AND DICKI     | Wolverhampton |
      | DANIEL AND SONS            | Birmingham    |
      | TREMBLAY-WEST              | Wolverhampton |
      | ROSENBAUM-HINTZ            | Dudley        |
      | HEANEY GROUP               | Wolverhampton |
      | DARE-ROHAN                 | Birmingham    |
      | FRITSCH-HAHN               | Dudley        |
      | TILLMAN-EMMERICH           | Dudley        |
      | GRADY AND SONS             | Birmingham    |
      | SWANIAWSKI, CORWIN AND KUB | Birmingham    |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: B6 6HE               |
      | Search distance: 25 miles      |
    And I click on '50 miles'
    Then I am on the 'Agency results' page
    And there are 15 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | Birmingham    |
      | GLOVER-ONDRICKA            | Birmingham    |
      | ROOB, CORWIN AND DICKI     | Wolverhampton |
      | SATTERFIELD AND SONS       | Nottingham    |
      | NADER, CONN AND REINGER    | Nottingham    |
      | GULGOWSKI-HUDSON           | Nottingham    |
      | DANIEL AND SONS            | Birmingham    |
      | TREMBLAY-WEST              | Wolverhampton |
      | ROSENBAUM-HINTZ            | Dudley        |
      | HEANEY GROUP               | Wolverhampton |
      | DARE-ROHAN                 | Birmingham    |
      | FRITSCH-HAHN               | Dudley        |
      | TILLMAN-EMMERICH           | Dudley        |
      | GRADY AND SONS             | Birmingham    |
      | SWANIAWSKI, CORWIN AND KUB | Birmingham    |
    And the choices used to generate the list are:
      | Looking for: Individual worker |
      | Worker type: Nominated         |
      | Postcode: B6 6HE               |
      | Search distance: 50 miles      |
