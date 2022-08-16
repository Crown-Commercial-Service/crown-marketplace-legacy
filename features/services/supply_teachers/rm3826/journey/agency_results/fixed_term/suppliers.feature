@geocode_london
Feature: Supply Teachers - Agency results - Fixed term - Agencies

  Background: Navigate to the Agency results page
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
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
  
  @pipeline
  Scenario: The agency details shown are correct
    And there are 8 agencies
    And the listed agencies with distances, fees and lengths are:
      | BOSCO INC                     | Twickenham  | 9.0   | 28000 | 3 months  | £931.00   | 13.3% |
      | BEATTY-DICKENS                | London      | 6.0   | 28000 | 3 months  | £1,169.00 | 16.7% |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  | 9.0   | 28000 | 3 months  | £1,218.00 | 17.4% |
      | NIKOLAUS AND SONS             | London      | 5.2   | 28000 | 3 months  | £1,533.00 | 21.9% |
      | PAGAC INC                     | London      | 6.0   | 28000 | 3 months  | £1,666.00 | 23.8% |
      | JOHNS, GLEASON AND WHITE      | London      | 0.2   | 28000 | 3 months  | £1,904.00 | 27.2% |
      | PFANNERSTILL-KUTCH            | London      | 5.2   | 28000 | 3 months  | £1,981.00 | 28.3% |
      | MOSCISKI-ROHAN                | London      | 0.2   | 28000 | 3 months  | £2,030.00 | 29.0% |

  @pipeline
  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

  Examples:
    | agency_name         | branch  |
    | BEATTY-DICKENS      | London  |
    | PAGAC INC           | London  |
    | PFANNERSTILL-KUTCH  | London  |

  @pipeline
  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  Scenario: Back buttons work
    Given I click on 'MOSCISKI-ROHAN'
    Then I am on the 'MOSCISKI-ROHAN' page
    And the sub title is Agency details
    And the 'Branch' is 'London'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'What is your school’s postcode?' page
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for agency results are:
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
    And I am on the "What would the employee's annual salary be?" page
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    Then I click on 'Back'
    And I am on the "What would the employee's annual salary be?" page
    Then I click on 'Back'
    And I am on the 'What date do you want the employee to stop working?' page
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    Then I click on 'Back'
    And I am on the 'What date do you want the employee to stop working?' page
    Then I click on 'Back'
    And I am on the 'What date do you want the employee to start?' page
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    Then I click on 'Back'
    And I am on the 'What date do you want the employee to start?' page
    Then I click on 'Back'
    And I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    Then I click on 'Back'
    And I am on the 'Do you want the agency to manage the worker’s pay?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    And I click on 'Continue'
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
