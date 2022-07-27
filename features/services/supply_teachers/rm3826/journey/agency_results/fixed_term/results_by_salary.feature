@pipeline @geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Results by length

  Scenario Outline: Changing the salary of the contract changes the result values only
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
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool | 0.6   | <annual_salary> | 3 months  | <agency_1_rate>  | 13.2% |
      | BOSCO INC                     | Liverpool | 2.6   | <annual_salary> | 3 months  | <agency_2_rate>  | 13.3% |
      | BEATTY-DICKENS                | Southport | 17.2  | <annual_salary> | 3 months  | <agency_3_rate>  | 16.7% |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool | 2.6   | <annual_salary> | 3 months  | <agency_4_rate>  | 17.4% |  
      | PAGAC INC                     | Southport | 17.2  | <annual_salary> | 3 months  | <agency_5_rate>  | 23.8% |
      | KULAS-OKUNEVA                 | Liverpool | 0.6   | <annual_salary> | 3 months  | <agency_6_rate>  | 26.0% |
      | JOHNS, GLEASON AND WHITE      | Liverpool | 7.3   | <annual_salary> | 3 months  | <agency_7_rate>  | 27.2% |
      | MOSCISKI-ROHAN                | Liverpool | 7.3   | <annual_salary> | 3 months  | <agency_8_rate>  | 29.0% |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 4AA                |
      | Search distance: 25 miles       |

    Examples:
      | annual_salary | agency_1_rate | agency_2_rate | agency_3_rate | agency_4_rate | agency_5_rate | agency_6_rate | agency_7_rate | agency_8_rate |
      | 10000         | £330.00       | £332.50       | £417.50       | £435.00       | £595.00       | £650.00       | £680.00       | £725.00       |
      | 20000         | £660.00       | £665.00       | £835.00       | £870.00       | £1,190.00     | £1,300.00     | £1,360.00     | £1,450.00     | 
      | 28000         | £924.00       | £931.00       | £1,169.00     | £1,218.00     | £1,666.00     | £1,820.00     | £1,904.00     | £2,030.00     |
      | 34781         | £1,147.77     | £1,156.47     | £1,452.11     | £1,512.97     | £2,069.47     | £2,260.77     | £2,365.11     | £2,521.62     |
      | 886422        | £29,251.93    | £29,473.53    | £37,008.12    | £38,559.36   | £52,742.11     | £57,617.43    | £60,276.70    | £64,265.59    |
