@pipeline @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Results by length

  Scenario Outline: Changing the salary of the contract changes the result values only
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
    And I enter '<annual_salary>' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 4AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies with distances, fees and lengths are:
      | BARTOLETTI, KOEPP AND NIENOW  | Southport | 17.2  | <annual_salary> | 3 months  | <agency_1_rate> | 16.6% |
      | CORKERY INC                   | Liverpool | 0.6   | <annual_salary> | 3 months  | <agency_2_rate> | 23.7% |
      | STANTON, FADEL AND BOSCO      | Liverpool | 2.6   | <annual_salary> | 3 months  | <agency_3_rate> | 24.9% |
      | DIETRICH-BORER                | Southport | 17.2  | <annual_salary> | 3 months  | <agency_4_rate> | 25.6% |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool | 0.6   | <annual_salary> | 3 months  | <agency_5_rate> | 28.8% |
      | ZIEMANN-HERMANN               | Liverpool | 7.3   | <annual_salary> | 3 months  | <agency_6_rate> | 32.1% |
      | EMARD AND SONS                | Liverpool | 2.6   | <annual_salary> | 3 months  | <agency_7_rate> | 35.0% |
      | FEEST-MULLER                  | Liverpool | 7.3   | <annual_salary> | 3 months  | <agency_8_rate> | 35.7% |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 25 miles       |

    Examples:
      | annual_salary | agency_1_rate | agency_2_rate | agency_3_rate | agency_4_rate | agency_5_rate | agency_6_rate | agency_7_rate | agency_8_rate |
      | 10000         | £413.75       | £592.00       | £621.75       | £639.75       | £719.00       | £803.50       | £875.25       | £893.25       |
      | 20000         | £827.50       | £1,184.00     | £1,243.50     | £1,279.50     | £1,438.00     | £1,607.00     | £1,750.50     | £1,786.50     |
      | 28000         | £1,158.50     | £1,657.60     | £1,740.90     | £1,791.30     | £2,013.20     | £2,249.80     | £2,450.70     | £2,501.10     |
      | 34781         | £1,439.06     | £2,059.04     | £2,162.51     | £2,225.11     | £2,500.75     | £2,794.65     | £3,044.21     | £3,106.81     |
      | 886422        | £36,675.71    | £52,476.18    | £55,113.29    | £56,708.85    | £63,733.74    | £71,224.01    | £77,584.09    | £79,179.65    |
