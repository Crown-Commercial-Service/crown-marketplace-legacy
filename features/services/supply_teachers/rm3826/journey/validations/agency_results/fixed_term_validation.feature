@pipeline @javascript @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Validations

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
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '1234' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies

  Scenario Outline: Annual salary validations
    And I enter the rate '<dayly_rate>' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    Then I should see the error message 'Annual salary is invalid' for 'CREMIN, SCHUSTER AND LUBOWITZ'
    And the following agencies have no errors:
      | BOSCO INC                     |
      | BEATTY-DICKENS                |
      | VANDERVORT, CRONA AND TRANTOW |
      | PAGAC INC                     |
      | KULAS-OKUNEVA                 |
      | JOHNS, GLEASON AND WHITE      |
      | MOSCISKI-ROHAN                |

    Examples:
      | dayly_rate  |
      | -1          |
      | Taion       |

  Scenario: Annual salary validations - both errors at once
    And I enter the rate '-1' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    Then I should see the error message 'Annual salary is invalid' for 'CREMIN, SCHUSTER AND LUBOWITZ'
    And I enter the rate 'Sena' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    Then I should see the error message 'Annual salary is invalid' for 'CREMIN, SCHUSTER AND LUBOWITZ'

  Scenario: Annual salary validations - error message disapears with valid data
    And I enter the rate '-1' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    Then I should see the error message 'Annual salary is invalid' for 'CREMIN, SCHUSTER AND LUBOWITZ'
    And I enter the rate '20000' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    And the following agencies have no errors:
      | CREMIN, SCHUSTER AND LUBOWITZ |
      | BOSCO INC                     |
      | BEATTY-DICKENS                |
      | VANDERVORT, CRONA AND TRANTOW |
      | PAGAC INC                     |
      | KULAS-OKUNEVA                 |
      | JOHNS, GLEASON AND WHITE      |
      | MOSCISKI-ROHAN                |

  Scenario: Rate validations - multiple agencies
    And I enter the rate '-1' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    And I enter the rate 'Sena' for the supplier 'VANDERVORT, CRONA AND TRANTOW'
    And I enter the rate 'L3 4AA' for the supplier 'MOSCISKI-ROHAN'
    Then I should see the error message 'Annual salary is invalid' for 'CREMIN, SCHUSTER AND LUBOWITZ'
    Then I should see the error message 'Annual salary is invalid' for 'VANDERVORT, CRONA AND TRANTOW'
    Then I should see the error message 'Annual salary is invalid' for 'MOSCISKI-ROHAN'
    And the following agencies have no errors:
      | BOSCO INC                     |
      | BEATTY-DICKENS                |
      | PAGAC INC                     |
      | KULAS-OKUNEVA                 |
      | JOHNS, GLEASON AND WHITE      |
