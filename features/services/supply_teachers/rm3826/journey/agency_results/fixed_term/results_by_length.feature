@geocode_london
Feature: Supply Teachers - Agency results - Fixed term - Results by length

  Background: I navigate to the employee to start date page
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

  @pipeline
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
      | BOSCO INC                     | Twickenham  | 9.0   | 28000 | <number_of_months> months  | <agency_1_rate>  | 13.3% |
      | BEATTY-DICKENS                | London      | 6.0   | 28000 | <number_of_months> months  | <agency_2_rate>  | 16.7% |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham  | 9.0   | 28000 | <number_of_months> months  | <agency_3_rate>  | 17.4% |
      | NIKOLAUS AND SONS             | London      | 5.2   | 28000 | <number_of_months> months  | <agency_4_rate>  | 21.9% |
      | PAGAC INC                     | London      | 6.0   | 28000 | <number_of_months> months  | <agency_5_rate>  | 23.8% |
      | JOHNS, GLEASON AND WHITE      | London      | 0.2   | 28000 | <number_of_months> months  | <agency_6_rate>  | 27.2% |
      | PFANNERSTILL-KUTCH            | London      | 5.2   | 28000 | <number_of_months> months  | <agency_7_rate>  | 28.3% |
      | MOSCISKI-ROHAN                | London      | 0.2   | 28000 | <number_of_months> months  | <agency_8_rate>  | 29.0% |
    And the choices used to generate the list are:
      | Looking for: Individual worker  |
      | Worker type: Supplied by agency |
      | Payroll provider: School        |
      | Postcode: SW1A 1AA              |
      | Search distance: 25 miles       |

    Examples:
      | date        | number_of_months  | agency_1_rate | agency_2_rate | agency_3_rate | agency_4_rate | agency_5_rate | agency_6_rate | agency_7_rate | agency_8_rate |
      | 06/05/2022  | 0                 | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         | £0.00         |
      | 06/07/2022  | 2                 | £620.67       | £779.33       | £812.00       | £1,022.00     | £1,110.67     | £1,269.33     | £1,320.67     | £1,353.33     |
      | 06/09/2022  | 4                 | £1,241.33     | £1,558.67     | £1,624.00     | £2,044.00     | £2,221.33     | £2,538.67     | £2,641.33     | £2,706.67     |
      | 06/02/2023  | 9                 | £2,793.00     | £3,507.00     | £3,654.00     | £4,599.00     | £4,998.00     | £5,712.00     | £5,943.00     | £6,090.00     |
      | 06/05/2023  | 12                | £3,724.00     | £4,676.00     | £4,872.00     | £6,132.00     | £6,664.00     | £7,616.00     | £7,924.00     | £8,120.00     |
      | 06/08/2024  | 27                | £3,724.00     | £4,676.00     | £4,872.00     | £6,132.00     | £6,664.00     | £7,616.00     | £7,924.00     | £8,120.00     |

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
