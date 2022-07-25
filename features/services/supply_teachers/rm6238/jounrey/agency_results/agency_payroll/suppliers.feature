@geocode_liverpool
Feature: Supply Teachers - Agency results - Agency payroll - Agencies

  Background: Navigate to the Agency results page
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
    And I enter 'L3 4AA' for the 'postcode'
    And I select 'Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)'
    And I select 'Daily Supply'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  @pipeline
  Scenario: The agency details shown are correct
    And there are 5 agencies
    And the listed agencies with rates and distances are:
      | BARTOLETTI, KOEPP AND NIENOW  | Southport | £27.59  | 17.2  |
      | STANTON, FADEL AND BOSCO      | Liverpool | £41.45  | 2.6   |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool | £47.94  | 0.6   |
      | EMARD AND SONS                | Liverpool | £58.35  | 2.6   |
      | FEEST-MULLER                  | Liverpool | £59.55  | 7.3   |

  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

  Examples:
    | agency_name                   | branch    |
    | BARTOLETTI, KOEPP AND NIENOW  | Southport |
    | KERLUKE, TORP AND HEATHCOTE   | Liverpool |
    | FEEST-MULLER                  | Liverpool |

  @pipeline
  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  Scenario: Back buttons work
    Given I click on 'EMARD AND SONS'
    Then I am on the 'EMARD AND SONS' page
    And the sub title is Agency details
    And the 'Branch' is 'Liverpool'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'School postcode and worker requirements' page
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for 'agency results' are:
      | BARTOLETTI, KOEPP AND NIENOW  | Southport |
      | STANTON, FADEL AND BOSCO      | Liverpool |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool |
      | EMARD AND SONS                | Liverpool |
      | FEEST-MULLER                  | Liverpool |
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
