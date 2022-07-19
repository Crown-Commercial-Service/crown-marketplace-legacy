@pipeline @javascript @geocode_liverpool
Feature: Supply Teachers - Agency results - Nominated worker - Daily rate

  Background: Navigate to the Agency results page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  Scenario Outline: Using the calculator for CREMIN, SCHUSTER AND LUBOWITZ
    And I enter the rate '<rate>' for the supplier 'CREMIN, SCHUSTER AND LUBOWITZ'
    Then for the agency 'CREMIN, SCHUSTER AND LUBOWITZ' I should see '<cost_of_worker>' for the 'cost of the worker'
    Then for the agency 'CREMIN, SCHUSTER AND LUBOWITZ' I should see '<agency_fee>' for the 'agency fee'

    Examples:
      | rate  | cost_of_worker  | agency_fee  |
      | 50    | £44.17          | £5.83       |
      | 67    | £59.19          | £7.81       |
      | 100   | £88.34          | £11.66      |
      | 200   | £176.68         | £23.32      |
      | 5193  | £4587.46        | £605.54     |

  Scenario Outline: Using the calculator for MOSCISKI-ROHAN
    And I enter the rate '<rate>' for the supplier 'MOSCISKI-ROHAN'
    Then for the agency 'MOSCISKI-ROHAN' I should see '<cost_of_worker>' for the 'cost of the worker'
    Then for the agency 'MOSCISKI-ROHAN' I should see '<agency_fee>' for the 'agency fee'

    Examples:
      | rate  | cost_of_worker  | agency_fee  |
      | 50    | £38.76          | £11.24      |
      | 89    | £68.99          | £20.01      |
      | 100   | £77.52          | £22.48      |
      | 200   | £155.04         | £44.96      |
      | 2981  | £2310.85        | £670.15     |