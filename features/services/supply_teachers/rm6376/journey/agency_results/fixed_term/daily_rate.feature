@javascript @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Daily rate

  Background: Navigate to the Agency results page
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
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
    And I enter 'L3 9PP' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

Scenario Outline: Using the calculator for ROHAN LLC
    Then for the agency 'ROHAN LLC' I should see '£1,542.92' for the 'finders fee'
    And I enter the rate '<annual_salary>' for the supplier 'ROHAN LLC'
    Then for the agency 'ROHAN LLC' I should see '<finders_fee>' for the 'finders fee'

    Examples:
      | annual_salary | finders_fee |
      | 10000         | £551.04     |
      | 20000         | £1102.08    |
      | 28000         | £1,542.92   |
      | 41036         | £2261.25    |
      | 819320        | £45147.95   |

  Scenario Outline: Using the calculator for GLOVER-ONDRICKA
    Then for the agency 'GLOVER-ONDRICKA' I should see '£1,672.42' for the 'finders fee'
    And I enter the rate '<annual_salary>' for the supplier 'GLOVER-ONDRICKA'
    Then for the agency 'GLOVER-ONDRICKA' I should see '<finders_fee>' for the 'finders fee'

    Examples:
      | annual_salary | finders_fee |
      | 10000         | £597.29     |
      | 20000         | £1194.58    |
      | 28000         | £1,672.42   |
      | 40142         | £2397.65    |
      | 9104123       | £543781.68  |

  Scenario: When nothing is entered the result is blank and the colours are muted
    Then for the agency 'SATTERFIELD AND SONS' I should see '£2,160.08' for the 'finders fee'
    And I enter the rate '' for the supplier 'SATTERFIELD AND SONS'
    Then for the agency 'SATTERFIELD AND SONS' I should see '' for the 'finders fee'
    And the results for 'SATTERFIELD AND SONS' are muted