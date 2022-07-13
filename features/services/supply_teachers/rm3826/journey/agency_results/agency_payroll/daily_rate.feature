@pipeline @javascript @geocode_london
Feature: Supply Teachers - Agency results - Agency payroll - Daily rate

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
    And I select 'Unqualified teacher: non-SEN roles'
    And I select 'Up to 1 week'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  Scenario Outline: Using the calculator for BEATTY-DICKENS
    And I enter the rate '<rate>' for the supplier 'BEATTY-DICKENS'
    Then for the agency 'BEATTY-DICKENS' I should see '<cost_of_worker>' for the 'cost of the worker'
    Then for the agency 'BEATTY-DICKENS' I should see '<agency_fee>' for the 'agency fee'

    Examples:
      | rate  | cost_of_worker  | agency_fee  |
      | 50    | £37.45          | £12.55      |
      | 72    | £53.93          | £18.07      |
      | 100   | £74.91          | £25.09      |
      | 200   | £149.81         | £50.19      |
      | 2684  | £2010.49        | £673.51     |

  Scenario Outline: Using the calculator for VANDERVORT, CRONA AND TRANTOW
    And I enter the rate '<rate>' for the supplier 'VANDERVORT, CRONA AND TRANTOW'
    Then for the agency 'VANDERVORT, CRONA AND TRANTOW' I should see '<cost_of_worker>' for the 'cost of the worker'
    Then for the agency 'VANDERVORT, CRONA AND TRANTOW' I should see '<agency_fee>' for the 'agency fee'

    Examples:
      | rate  | cost_of_worker  | agency_fee  |
      | 43    | £31.88          | £11.12      |
      | 50    | £37.06          | £12.94      |
      | 100   | £74.13          | £25.87      |
      | 200   | £148.26         | £51.74      |
      | 6242  | £4627.13        | £1614.87    |