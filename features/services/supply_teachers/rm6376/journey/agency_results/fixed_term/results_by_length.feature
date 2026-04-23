@geocode_london
Feature: Supply Teachers - Agency results - Fixed term - Results by length

  Background: I navigate to the employee to start date page
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

  Scenario Outline: Changing the length of the contract changes the result values only
    And I enter '03/04/2026' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter '<date>' for the date
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies with distances, fees and lengths are:
      | ROHAN LLC                  | London     | 0.2 | 28000 | <number_of_months> months | <agency_1_rate>  | 26.5% |
      | GLOVER-ONDRICKA            | London     | 0.2 | 28000 | <number_of_months> months | <agency_2_rate>  | 28.7% |
      | ROOB, CORWIN AND DICKI     | London     | 5.2 | 28000 | <number_of_months> months | <agency_3_rate>  | 33.8% |
      | DANIEL AND SONS            | Twickenham | 9.0 | 28000 | <number_of_months> months | <agency_4_rate>  | 42.7% |
      | TREMBLAY-WEST              | London     | 5.2 | 28000 | <number_of_months> months | <agency_5_rate>  | 43.9% |
      | ROSENBAUM-HINTZ            | London     | 6.0 | 28000 | <number_of_months> months | <agency_6_rate>  | 44.4% |
      | HEANEY GROUP               | London     | 5.2 | 28000 | <number_of_months> months | <agency_7_rate>  | 47.2% |
      | DARE-ROHAN                 | Twickenham | 9.0 | 28000 | <number_of_months> months | <agency_8_rate>  | 48.7% |
      | FRITSCH-HAHN               | London     | 6.0 | 28000 | <number_of_months> months | <agency_9_rate>  | 57.2% |
      | TILLMAN-EMMERICH           | London     | 6.0 | 28000 | <number_of_months> months | <agency_10_rate> | 57.6% |
      | GRADY AND SONS             | London     | 0.2 | 28000 | <number_of_months> months | <agency_11_rate> | 58.0% |
      | SWANIAWSKI, CORWIN AND KUB | Twickenham | 9.0 | 28000 | <number_of_months> months | <agency_12_rate> | 59.0% | 
   And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 25 miles       |

    Examples:
      | date       | number_of_months | agency_1_rate | agency_2_rate | agency_3_rate | agency_4_rate | agency_5_rate | agency_6_rate | agency_7_rate | agency_8_rate | agency_9_rate | agency_10_rate | agency_11_rate | agency_12_rate |
      | 03/04/2026 | 0                | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00          | £0.00          | £0.00          |
      | 03/06/2026 | 2                | £1,234.33     | £1,337.93     | £1,576.87     | £1,991.27     | £2,047.27     | £2,072.47     | £2,202.67     | £2,274.07     | £2,669.80     | £2,686.13      | £2,704.80      | £2,755.20      |
      | 03/08/2026 | 4                | £2,468.67     | £2,675.87     | £3,153.73     | £3,982.53     | £4,094.53     | £4,144.93     | £4,405.33     | £4,548.13     | £5,339.60     | £5,372.27      | £5,409.60      | £5,510.40      |
      | 03/01/2027 | 9                | £5,554.50     | £6,020.70     | £7,095.90     | £8,960.70     | £9,212.70     | £9,326.10     | £9,912.00     | £10,233.30    | £12,014.10    | £12,087.60     | £12,171.60     | £12,398.40     |
      | 03/04/2027 | 12               | £7,406.00     | £8,027.60     | £9,461.20     | £11,947.60    | £12,283.60    | £12,434.80    | £13,216.00    | £13,644.40    | £16,018.80    | £16,116.80     | £16,228.80     | £16,531.20     |
      | 03/07/2028 | 27               | £7,406.00     | £8,027.60     | £9,461.20     | £11,947.60    | £12,283.60    | £12,434.80    | £13,216.00    | £13,644.40    | £16,018.80    | £16,116.80     | £16,228.80     | £16,531.20     |
  Scenario Outline: Half months are shown correctly
    And I enter '01/01/2022' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter '<date>' for the date
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 25 miles       |
    And the number of months in the results is '<number_of_months>'

    Examples:
      | date       | number_of_months |
      | 01/01/2022 | 0                |
      | 16/01/2022 | 0                |
      | 17/01/2022 | 0.5              |
      | 30/01/2022 | 0.5              |
      | 01/02/2022 | 1                |
      | 18/04/2022 | 3.5              |
