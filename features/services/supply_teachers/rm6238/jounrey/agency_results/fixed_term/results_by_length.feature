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
    And I enter '06/05/2022' for the date
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
      | BARTOLETTI, KOEPP AND NIENOW  | London      | 6.0   | 28000 | <number_of_months> months  | <agency_1_rate>  | 16.6% |
      | MCGLYNN GROUP                 | London      | 5.2   | 28000 | <number_of_months> months  | <agency_2_rate>  | 23.9% |
      | STANTON, FADEL AND BOSCO      | Twickenham  | 9.0   | 28000 | <number_of_months> months  | <agency_3_rate>  | 24.9% |
      | DIETRICH-BORER                | London      | 6.0   | 28000 | <number_of_months> months  | <agency_4_rate>  | 25.6% |
      | HAGENES-BECHTELAR             | London      | 5.2   | 28000 | <number_of_months> months  | <agency_5_rate>  | 30.0% |
      | ZIEMANN-HERMANN               | London      | 0.2   | 28000 | <number_of_months> months  | <agency_6_rate>  | 32.1% |
      | EMARD AND SONS                | Twickenham  | 9.0   | 28000 | <number_of_months> months  | <agency_7_rate>  | 35.0% |
      | FEEST-MULLER                  | London      | 0.2   | 28000 | <number_of_months> months  | <agency_8_rate>  | 35.7% |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 25 miles       |

    Examples:
      | date        | number_of_months  | agency_1_rate | agency_2_rate | agency_3_rate | agency_4_rate | agency_5_rate | agency_6_rate | agency_7_rate | agency_8_rate |
      | 06/05/2022  | 0                 | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         |
      | 06/07/2022  | 2                 | £772.33       | £1,115.33     | £1,160.60     | £1,194.20     | £1,399.07     | £1,499.87     | £1,633.80     | £1,667.40     |
      | 06/09/2022  | 4                 | £1,544.67     | £2,230.67     | £2,321.20     | £2,388.40     | £2,798.13     | £2,999.73     | £3,267.60     | £3,334.80     |
      | 06/02/2023  | 9                 | £3,475.50     | £5,019.00     | £5,222.70     | £5,373.90     | £6,295.80     | £6,749.40     | £7,352.10     | £7,503.30     |
      | 06/05/2023  | 12                | £4,634.00     | £6,692.00     | £6,963.60     | £7,165.20     | £8,394.40     | £8,999.20     | £9,802.80     | £10,004.40    |
      | 06/08/2024  | 27                | £4,634.00     | £6,692.00     | £6,963.60     | £7,165.20     | £8,394.40     | £8,999.20     | £9,802.80     | £10,004.40    |

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
      | date        | number_of_months  |
      | 01/01/2022  | 0                 |
      | 16/01/2022  | 0                 |
      | 17/01/2022  | 0.5               |
      | 30/01/2022  | 0.5               |
      | 01/02/2022  | 1                 |
      | 18/04/2022  | 3.5               |
