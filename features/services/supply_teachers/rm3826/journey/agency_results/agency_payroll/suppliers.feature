@geocode_liverpool
Feature: Supply Teachers - Agency results - Agency payroll - Agencies

  Background: Navigate to the Agency results page
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
    And I enter 'L3 4AA' for the 'postcode'
    And I select 'Qualified teacher: non-SEN roles'
    And I select '4 weeks to 8 weeks'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  @pipeline
  Scenario: The agency details shown are correct
    And there are 5 agencies
    And the listed agencies with rates and distances are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool | 22.6% | 0.6   |
      | BEATTY-DICKENS                | Southport | 28.5% | 17.2  |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool | 29.8% | 2.6   |
      | PAGAC INC                     | Southport | 40.6% | 17.2  |
      | JOHNS, GLEASON AND WHITE      | Liverpool | 46.5% | 7.3   |

  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

  Examples:
    | agency_name                   | branch    |
    | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool |
    | VANDERVORT, CRONA AND TRANTOW | Liverpool |
    | PAGAC INC                     | Southport |

  @pipeline
  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  @pipeline
  Scenario: I can download the shortlist document with markup calculator
    And I click on 'Download shortlist (with markup calculator)'
    Then the spreadsheet 'Shortlist of agencies (with calculator)' is downloaded

  Scenario: Back buttons work
    Given I click on 'BEATTY-DICKENS'
    Then I am on the 'BEATTY-DICKENS' page
    And the sub title is Agency details
    And the 'Branch' is 'Southport'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'School postcode and worker requirements' page
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 5 agencies
    And the listed agencies for agency results are:
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool |
      | BEATTY-DICKENS                | Southport |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool |
      | PAGAC INC                     | Southport |
      | JOHNS, GLEASON AND WHITE      | Liverpool |
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
