@javascript @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Validations

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
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '1234' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 9PP' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies

  Scenario Outline: Annual salary validations
    And I enter the rate '<dayly_rate>' for the supplier 'CORKERY INC'
    Then I should see the error message 'Annual salary is invalid' for 'CORKERY INC'
    And the following agencies have no errors:
      | BARTOLETTI, KOEPP AND NIENOW  |
      | STANTON, FADEL AND BOSCO      |
      | DIETRICH-BORER                |
      | KERLUKE, TORP AND HEATHCOTE   |
      | ZIEMANN-HERMANN               |
      | EMARD AND SONS                |
      | FEEST-MULLER                  |

    Examples:
      | dayly_rate  |
      | -1          |
      | Taion       |

  Scenario: Annual salary validations - both errors at once
    And I enter the rate '-1' for the supplier 'CORKERY INC'
    Then I should see the error message 'Annual salary is invalid' for 'CORKERY INC'
    And I enter the rate 'Sena' for the supplier 'CORKERY INC'
    Then I should see the error message 'Annual salary is invalid' for 'CORKERY INC'

  Scenario: Annual salary validations - error message disapears with valid data
    And I enter the rate '-1' for the supplier 'CORKERY INC'
    Then I should see the error message 'Annual salary is invalid' for 'CORKERY INC'
    And I enter the rate '20000' for the supplier 'CORKERY INC'
    And the following agencies have no errors:
      | BARTOLETTI, KOEPP AND NIENOW  |
      | CORKERY INC                   |
      | STANTON, FADEL AND BOSCO      |
      | DIETRICH-BORER                |
      | KERLUKE, TORP AND HEATHCOTE   |
      | ZIEMANN-HERMANN               |
      | EMARD AND SONS                |
      | FEEST-MULLER                  |

  Scenario: Rate validations - multiple agencies
    And I enter the rate '-1' for the supplier 'CORKERY INC'
    And I enter the rate 'Sena' for the supplier 'DIETRICH-BORER'
    And I enter the rate 'L3 9PP' for the supplier 'EMARD AND SONS'
    Then I should see the error message 'Annual salary is invalid' for 'CORKERY INC'
    Then I should see the error message 'Annual salary is invalid' for 'DIETRICH-BORER'
    Then I should see the error message 'Annual salary is invalid' for 'EMARD AND SONS'
    And the following agencies have no errors:
      | BARTOLETTI, KOEPP AND NIENOW  |
      | STANTON, FADEL AND BOSCO      |
      | KERLUKE, TORP AND HEATHCOTE   |
      | ZIEMANN-HERMANN               |
      | FEEST-MULLER                  |
