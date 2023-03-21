@javascript @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Daily rate

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
    And I enter a date 2 and a half months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  Scenario Outline: Using the calculator for CORKERY INC
    Then for the agency 'CORKERY INC' I should see '£1,381.33' for the 'finders fee'
    And I enter the rate '<annual_salary>' for the supplier 'CORKERY INC'
    Then for the agency 'CORKERY INC' I should see '<finders_fee>' for the 'finders fee'

    Examples:
      | annual_salary | finders_fee |
      | 10000         | £493.33     |
      | 20000         | £986.67     |
      | 28000         | £1,381.33   |
      | 41036         | £2024.44    |
      | 819320        | £40419.79   |

  Scenario Outline: Using the calculator for DIETRICH-BORER
    Then for the agency 'DIETRICH-BORER' I should see '£1,492.75' for the 'finders fee'
    And I enter the rate '<annual_salary>' for the supplier 'DIETRICH-BORER'
    Then for the agency 'DIETRICH-BORER' I should see '<finders_fee>' for the 'finders fee'

    Examples:
      | annual_salary | finders_fee |
      | 10000         | £533.13     |
      | 20000         | £1066.25    |
      | 28000         | £1,492.75   |
      | 40142         | £2140.07    |
      | 9104123       | £485363.56  |

  Scenario: When nothing is entered the result is blank and the colours are muted
    Then for the agency 'STANTON, FADEL AND BOSCO' I should see '£1,450.75' for the 'finders fee'
    And I enter the rate '' for the supplier 'STANTON, FADEL AND BOSCO'
    Then for the agency 'STANTON, FADEL AND BOSCO' I should see '' for the 'finders fee'
    And the results for 'STANTON, FADEL AND BOSCO' are muted
