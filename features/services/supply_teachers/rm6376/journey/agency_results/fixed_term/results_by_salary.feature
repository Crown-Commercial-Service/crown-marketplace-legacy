@geocode_liverpool
Feature: Supply Teachers - Agency results - Fixed term - Results by length

  Scenario Outline: Changing the salary of the contract changes the result values only
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
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '<annual_salary>' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'L3 9PP' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies with distances, fees and lengths are:
      | ROHAN LLC                  | Liverpool | 7.3  | <annual_salary> | 3 months | <agency_1_rate>  | 26.5% |
      | GLOVER-ONDRICKA            | Liverpool | 7.3  | <annual_salary> | 3 months | <agency_2_rate>  | 28.7% |
      | SATTERFIELD AND SONS       | Liverpool | 0.6  | <annual_salary> | 3 months | <agency_3_rate>  | 37.0% |
      | NADER, CONN AND REINGER    | Liverpool | 0.6  | <annual_salary> | 3 months | <agency_4_rate>  | 37.3% |
      | GULGOWSKI-HUDSON           | Liverpool | 0.6  | <annual_salary> | 3 months | <agency_5_rate>  | 38.6% |
      | DANIEL AND SONS            | Liverpool | 2.6  | <annual_salary> | 3 months | <agency_6_rate>  | 42.7% |
      | ROSENBAUM-HINTZ            | Southport | 17.2 | <annual_salary> | 3 months | <agency_7_rate>  | 44.4% |
      | DARE-ROHAN                 | Liverpool | 2.6  | <annual_salary> | 3 months | <agency_8_rate>  | 48.7% |
      | FRITSCH-HAHN               | Southport | 17.2 | <annual_salary> | 3 months | <agency_9_rate>  | 57.2% |
      | TILLMAN-EMMERICH           | Southport | 17.2 | <annual_salary> | 3 months | <agency_10_rate> | 57.6% |
      | GRADY AND SONS             | Liverpool | 7.3  | <annual_salary> | 3 months | <agency_11_rate> | 58.0% |
      | SWANIAWSKI, CORWIN AND KUB | Liverpool | 2.6  | <annual_salary> | 3 months | <agency_12_rate> | 59.0% |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: L3 9PP                |
      | Search distance: 25 miles       |

    Examples:
      | annual_salary | agency_1_rate | agency_2_rate | agency_3_rate | agency_4_rate | agency_5_rate | agency_6_rate | agency_7_rate | agency_8_rate | agency_9_rate | agency_10_rate | agency_11_rate | agency_12_rate |
      | 10000         | £661.25       | £716.75       | £925.75       | £931.75       | £964.25       | £1,066.75     | £1,110.25     | £1,218.25     | £1,430.25     | £1,439.00      | £1,449.00      | £1,476.00      |
      | 20000         | £1,322.50     | £1,433.50     | £1,851.50     | £1,863.50     | £1,928.50     | £2,133.50     | £2,220.50     | £2,436.50     | £2,860.50     | £2,878.00      | £2,898.00      | £2,952.00      |
      | 28000         | £1,851.50     | £2,006.90     | £2,592.10     | £2,608.90     | £2,699.90     | £2,986.90     | £3,108.70     | £3,411.10     | £4,004.70     | £4,029.20      | £4,057.20      | £4,132.80      |
      | 34781         | £2,299.89     | £2,492.93     | £3,219.85     | £3,240.72     | £3,353.76     | £3,710.26     | £3,861.56     | £4,237.20     | £4,974.55     | £5,004.99      | £5,039.77      | £5,133.68      |
      | 886422        | £58,614.65    | £63,534.30    | £82,060.52    | £82,592.37    | £85,473.24    | £94,559.07    | £98,415.00    | £107,988.36   | £126,780.51   | £127,556.13    | £128,442.55    | £130,835.89    |