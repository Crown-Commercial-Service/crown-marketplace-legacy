@pipeline @javascript @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Daily rate

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
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  Scenario Outline: Using the calculator for BOSCO INC
    Then for the agency 'BOSCO INC' I should see '£775.83' for the 'finders fee'
    And I enter the rate '<annual_salary>' for the supplier 'BOSCO INC'
    Then for the agency 'BOSCO INC' I should see '<finders_fee>' for the 'finders fee'

    Examples:
      | annual_salary | finders_fee |
      | 10000         | £277.08     |
      | 20000         | £554.17     |
      | 28000         | £775.83     |
      | 34781         | £963.72     |
      | 886422        | £24561.28   |

  Scenario Outline: Using the calculator for VANDERVORT, CRONA AND TRANTOW
    Then for the agency 'VANDERVORT, CRONA AND TRANTOW' I should see '£1,015.00' for the 'finders fee'
    And I enter the rate '<annual_salary>' for the supplier 'VANDERVORT, CRONA AND TRANTOW'
    Then for the agency 'VANDERVORT, CRONA AND TRANTOW' I should see '<finders_fee>' for the 'finders fee'

    Examples:
      | annual_salary | finders_fee |
      | 10000         | £362.50     |
      | 20000         | £725.00     |
      | 28000         | £1,015.00   |
      | 45872         | £1662.86    |
      | 9781234       | £354569.73  |

  Scenario: When nothing is entered the rsult is blank and the colours are muted
    Then for the agency 'BEATTY-DICKENS' I should see '£974.17' for the 'finders fee'
    And I enter the rate '' for the supplier 'BEATTY-DICKENS'
    Then for the agency 'BEATTY-DICKENS' I should see '' for the 'finders fee'
    And the results for 'BEATTY-DICKENS' are muted