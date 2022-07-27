@geocode_london
Feature: Supply Teachers - Agency results - Nominated worker - Agencies

  Background: Navigate to the Agency results page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
  
  @pipeline
  Scenario: The agency details shown are correct
    And there are 8 agencies
    And the listed agencies with rates and distances are:
      | BOSCO INC                     | Twickenham  | 13.3% | 9.0   |
      | BEATTY-DICKENS                | London      | 16.7% | 6.0   |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  | 17.4% | 9.0   |
      | NIKOLAUS AND SONS             | London      | 21.9% | 5.2   |
      | PAGAC INC                     | London      | 23.8% | 6.0   |
      | JOHNS, GLEASON AND WHITE      | London      | 27.2% | 0.2   |
      | PFANNERSTILL-KUTCH            | London      | 28.3% | 5.2   |
      | MOSCISKI-ROHAN                | London      | 29.0% | 0.2   |

  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

  Examples:
    | agency_name                   | branch      |
    | BOSCO INC                     | Twickenham  |
    | NIKOLAUS AND SONS             | London      |
    | JOHNS, GLEASON AND WHITE      | London      |

  @pipeline
  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  @pipeline
  Scenario: I can download the shortlist document with markup calculator
    And I click on 'Download shortlist (with markup calculator)'
    Then the spreadsheet 'Shortlist of agencies (with calculator)' is downloaded

  Scenario: Back buttons work
    Given I click on 'PAGAC INC'
    Then I am on the 'PAGAC INC' page
    And the sub title is Agency details
    And the 'Branch' is 'London'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'What is your school’s postcode?' page
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
    Then I click on 'Back'
    And I am on the 'What is your school’s postcode?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    Then I click on 'Back'
    And I am on the 'What is your school looking for?' page
    And I click on 'Continue'
    And I am on the 'Do you want an agency to supply the worker?' page
