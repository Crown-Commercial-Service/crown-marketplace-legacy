@pipeline @javascript @geocode_london
Feature: Supply Teachers - Agency results - Nominated worker - Validations

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
    And there are 8 agencies

  Scenario Outline: Rate validations
    And I enter the rate '<dayly_rate>' for the supplier 'BOSCO INC'
    Then I should see the error message 'Daily rate is invalid' for 'BOSCO INC'
    And the following agencies have no errors:
      | BEATTY-DICKENS                |
      | VANDERVORT, CRONA AND TRANTOW |
      | NIKOLAUS AND SONS             |
      | PAGAC INC                     |
      | JOHNS, GLEASON AND WHITE      |
      | PFANNERSTILL-KUTCH            |
      | MOSCISKI-ROHAN                |

    Examples:
      | dayly_rate  |
      | -8.7        |
      | Lanz        |

  Scenario: Rate validations - both errors at once
    And I enter the rate '-8.7' for the supplier 'BOSCO INC'
    Then I should see the error message 'Daily rate is invalid' for 'BOSCO INC'
    And I enter the rate 'Lanz' for the supplier 'BOSCO INC'
    Then I should see the error message 'Daily rate is invalid' for 'BOSCO INC'

  Scenario: Rate validations - error message disapears with valid data
    And I enter the rate '-8.7' for the supplier 'BOSCO INC'
    Then I should see the error message 'Daily rate is invalid' for 'BOSCO INC'
    And I enter the rate '100' for the supplier 'BOSCO INC'
    And the following agencies have no errors:
      | BOSCO INC                     |
      | BEATTY-DICKENS                |
      | VANDERVORT, CRONA AND TRANTOW |
      | NIKOLAUS AND SONS             |
      | PAGAC INC                     |
      | JOHNS, GLEASON AND WHITE      |
      | PFANNERSTILL-KUTCH            |
      | MOSCISKI-ROHAN                |

  Scenario: Rate validations - multiple agencies
    And I enter the rate '-8.7' for the supplier 'BOSCO INC'
    And I enter the rate 'Lanz' for the supplier 'VANDERVORT, CRONA AND TRANTOW'
    And I enter the rate 'SW1A 1AA' for the supplier 'NIKOLAUS AND SONS'
    Then I should see the error message 'Daily rate is invalid' for 'BOSCO INC'
    Then I should see the error message 'Daily rate is invalid' for 'VANDERVORT, CRONA AND TRANTOW'
    Then I should see the error message 'Daily rate is invalid' for 'NIKOLAUS AND SONS'
    And the following agencies have no errors:
      | BEATTY-DICKENS                |
      | PAGAC INC                     |
      | JOHNS, GLEASON AND WHITE      |
      | PFANNERSTILL-KUTCH            |
      | MOSCISKI-ROHAN                |
