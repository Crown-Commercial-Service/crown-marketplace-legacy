@pipeline @javascript @geocode_london
Feature: Supply Teachers - Agency results - Agency payroll - Validations

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
    And I enter 'SW1A 1AA' for the 'postcode'
    And I select 'Qualified teacher: non-SEN roles'
    And I select 'Up to 1 week'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 6 agencies

  Scenario Outline: Rate validations
    And I enter the rate '<dayly_rate>' for the supplier 'BEATTY-DICKENS'
    Then I should see the error message 'Daily rate is invalid' for 'BEATTY-DICKENS'
    And the following agencies have no errors:
      | VANDERVORT, CRONA AND TRANTOW |
      | NIKOLAUS AND SONS             |
      | PAGAC INC                     |
      | JOHNS, GLEASON AND WHITE      |
      | PFANNERSTILL-KUTCH            |

    Examples:
      | dayly_rate  |
      | -1          |
      | The Way     |

  Scenario: Rate validations - both errors at once
    And I enter the rate '-1' for the supplier 'BEATTY-DICKENS'
    Then I should see the error message 'Daily rate is invalid' for 'BEATTY-DICKENS'
    And I enter the rate 'The Way' for the supplier 'BEATTY-DICKENS'
    Then I should see the error message 'Daily rate is invalid' for 'BEATTY-DICKENS'

  Scenario: Rate validations - error message disapears with valid data
    And I enter the rate '-1' for the supplier 'BEATTY-DICKENS'
    Then I should see the error message 'Daily rate is invalid' for 'BEATTY-DICKENS'
    And I enter the rate '100' for the supplier 'BEATTY-DICKENS'
    And the following agencies have no errors:
      | BEATTY-DICKENS                |
      | VANDERVORT, CRONA AND TRANTOW |
      | NIKOLAUS AND SONS             |
      | PAGAC INC                     |
      | JOHNS, GLEASON AND WHITE      |
      | PFANNERSTILL-KUTCH            |

  Scenario: Rate validations - multiple agencies
    And I enter the rate '-1' for the supplier 'BEATTY-DICKENS'
    And I enter the rate 'The Way' for the supplier 'PAGAC INC'
    And I enter the rate 'SW1A 1AA' for the supplier 'PFANNERSTILL-KUTCH'
    Then I should see the error message 'Daily rate is invalid' for 'BEATTY-DICKENS'
    Then I should see the error message 'Daily rate is invalid' for 'PAGAC INC'
    Then I should see the error message 'Daily rate is invalid' for 'PFANNERSTILL-KUTCH'
    And the following agencies have no errors:
      | VANDERVORT, CRONA AND TRANTOW |
      | NIKOLAUS AND SONS             |
      | JOHNS, GLEASON AND WHITE      |
