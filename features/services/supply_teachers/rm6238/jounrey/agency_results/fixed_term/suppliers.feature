@geocode_london
Feature: Supply Teachers - Agency results - Fixed term - Agencies

  Background: Navigate to the Agency results page
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
      | BARTOLETTI, KOEPP AND NIENOW  | London      | 6.0 | 28000 | 3 months  | £1,158.50 | 16.6% |
      | MCGLYNN GROUP                 | London      | 5.2 | 28000 | 3 months  | £1,673.00 | 23.9% |
      | STANTON, FADEL AND BOSCO      | Twickenham  | 9.0 | 28000 | 3 months  | £1,740.90 | 24.9% |
      | DIETRICH-BORER                | London      | 6.0 | 28000 | 3 months  | £1,791.30 | 25.6% |
      | HAGENES-BECHTELAR             | London      | 5.2 | 28000 | 3 months  | £2,098.60 | 30.0% |
      | ZIEMANN-HERMANN               | London      | 0.2 | 28000 | 3 months  | £2,249.80 | 32.1% |
      | EMARD AND SONS                | Twickenham  | 9.0 | 28000 | 3 months  | £2,450.70 | 35.0% |
      | FEEST-MULLER                  | London      | 0.2 | 28000 | 3 months  | £2,501.10 | 35.7% |

  @pipeline
  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

  Examples:
    | agency_name                   | branch      |
    | BARTOLETTI, KOEPP AND NIENOW  | London      |
    | DIETRICH-BORER                | London      |
    | EMARD AND SONS                | Twickenham  |

  @pipeline
  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  Scenario: Back buttons work
    Given I click on 'MCGLYNN GROUP'
    Then I am on the 'MCGLYNN GROUP' page
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
      | BARTOLETTI, KOEPP AND NIENOW  | London      |
      | MCGLYNN GROUP                 | London      |
      | STANTON, FADEL AND BOSCO      | Twickenham  |
      | DIETRICH-BORER                | London      |
      | HAGENES-BECHTELAR             | London      |
      | ZIEMANN-HERMANN               | London      |
      | EMARD AND SONS                | Twickenham  |
      | FEEST-MULLER                  | London      |
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
