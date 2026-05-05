@geocode_liverpool
Feature: Supply Teachers - Agency results - Agency payroll - Agencies

  Background: Navigate to the Agency results page
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
    And I enter 'L3 9PP' for the 'postcode'
    And I select 'STEM Teacher (Inc. Qualified Teachers, Tutors)'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  Scenario: The agency details shown are correct
    And there are 12 agencies
    And the listed agencies with rates and distances are:
      | ROHAN LLC                  | Liverpool | £37.34 | 7.3  |
      | GLOVER-ONDRICKA            | Liverpool | £40.47 | 7.3  |
      | SATTERFIELD AND SONS       | Liverpool | £52.28 | 0.6  |
      | NADER, CONN AND REINGER    | Liverpool | £52.62 | 0.6  |
      | GULGOWSKI-HUDSON           | Liverpool | £54.45 | 0.6  |
      | DANIEL AND SONS            | Liverpool | £60.24 | 2.6  |
      | ROSENBAUM-HINTZ            | Southport | £62.70 | 17.2 |
      | DARE-ROHAN                 | Liverpool | £68.79 | 2.6  |
      | FRITSCH-HAHN               | Southport | £80.77 | 17.2 |
      | TILLMAN-EMMERICH           | Southport | £81.26 | 17.2 |
      | GRADY AND SONS             | Liverpool | £81.82 | 7.3  |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool | £83.36 | 2.6  |

  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

    Examples:
      | agency_name          | branch    |
      | GLOVER-ONDRICKA      | Liverpool |
      | SATTERFIELD AND SONS | Liverpool |
      | TILLMAN-EMMERICH     | Southport |

  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  Scenario: Back buttons work
    Given I click on 'GLOVER-ONDRICKA'
    Then I am on the 'GLOVER-ONDRICKA' page
    And the sub title is Agency details
    And the 'Branch' is 'Liverpool'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'School postcode and worker requirements' page
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | Liverpool | £37.34 | 7.3  |
      | GLOVER-ONDRICKA            | Liverpool | £40.47 | 7.3  |
      | SATTERFIELD AND SONS       | Liverpool | £52.28 | 0.6  |
      | NADER, CONN AND REINGER    | Liverpool | £52.62 | 0.6  |
      | GULGOWSKI-HUDSON           | Liverpool | £54.45 | 0.6  |
      | DANIEL AND SONS            | Liverpool | £60.24 | 2.6  |
      | ROSENBAUM-HINTZ            | Southport | £62.70 | 17.2 |
      | DARE-ROHAN                 | Liverpool | £68.79 | 2.6  |
      | FRITSCH-HAHN               | Southport | £80.77 | 17.2 |
      | TILLMAN-EMMERICH           | Southport | £81.26 | 17.2 |
      | GRADY AND SONS             | Liverpool | £81.82 | 7.3  |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool | £83.36 | 2.6  |
    Then I click on 'Back'
    Then I am on the 'School postcode and worker requirements' page
    Then I click on 'Back'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    Then I click on 'Back'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    Then I click on 'Back'
    And I am on the 'What is your school looking for?' page
    And I click on 'Continue'
    And I am on the 'Do you want an agency to supply the worker?' page
