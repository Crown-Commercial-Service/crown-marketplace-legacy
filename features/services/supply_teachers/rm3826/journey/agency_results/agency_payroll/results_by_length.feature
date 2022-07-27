@geocode_liverpool
Feature: Supply Teachers - Agency results - Agency payroll - Results by length

  Background: Navigate to the School postcode and worker requirements page
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
    And I enter 'L3 4AA' for the 'postcode'

  Scenario: A length less than 1 week has the correct rates
    And I select 'Up to 1 week'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies with rates and distances are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool | 23.8% | 0.6   |
      | BEATTY-DICKENS                | Southport | 30.1% | 17.2  |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool | 31.4% | 2.6   |
      | PAGAC INC                     | Southport | 42.8% | 17.2  |
      | JOHNS, GLEASON AND WHITE      | Liverpool | 49.0% | 7.3   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: Up to 1 week                          |

  @pipeline
  Scenario Outline: A length between 1 and 12 weeks has the correct rates
    And I select '<length>'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies with rates and distances are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool | 22.6% | 0.6   |
      | BEATTY-DICKENS                | Southport | 28.5% | 17.2  |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool | 29.8% | 2.6   |
      | PAGAC INC                     | Southport | 40.6% | 17.2  |
      | JOHNS, GLEASON AND WHITE      | Liverpool | 46.5% | 7.3   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: <length>                              |

    Examples:
      | length              |
      | 1 week to 4 weeks   |
      | 4 weeks to 8 weeks  |
      | 8 weeks to 12 weeks |

  Scenario: A length over 12 weeks has the correct rates
    And I select 'Over 12 weeks'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies with rates and distances are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool | 21.4% | 0.6   |
      | BEATTY-DICKENS                | Southport | 27.0% | 17.2  |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool | 28.2% | 2.6   |
      | PAGAC INC                     | Southport | 38.5% | 17.2  |
      | JOHNS, GLEASON AND WHITE      | Liverpool | 44.1% | 7.3   |
    And the choices used to generate the list are:
      | Looking for: Individual worker              |
      | Worker type: Supplied by agency             |
      | Payroll provider: Agency                    |
      | Postcode: L3 4AA                            |
      | Search distance: 25 miles                   |
      | Job type: Qualified teacher: non-SEN roles  |
      | Term: Over 12 weeks                         |
