Feature: Supply Teachers - Temp to perm - No notice given - hiring between 9 and 12 weeks

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    Given I enter '19/06/2021' for the 'hire' date

  Scenario Outline: Changing the length of the current contract changes the result
    Given I enter '<date>' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '<min_fee>' and '£500'

    Examples:
      | date        | min_fee |
      | 05/06/2021  | £450.00 |
      | 12/06/2021  | £325.00 |
      | 19/06/2021  | £200.00 |
      | 20/06/2021  | £200.00 |
      | 21/06/2021  | £200.00 |
      | 26/06/2021  | £75.00  |

  Scenario Outline: Changing the number of days per week changes the result
    And I enter '<days_per_week>' for the 'days per week'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '<min_fee>' and '<max_fee>'

    Examples:
      | days_per_week | min_fee | max_fee |
      | 1             | £40.00  | £100    |
      | 2             | £80.00  | £200    |
      | 3             | £120.00 | £300    |
      | 4             | £160.00 | £400    |
      | 5             | £200.00 | £500    |

  Scenario Outline: Changing the daily fee changes the result
    And I enter '<daily_fee>' for the 'daily fee'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '<min_fee>' and '<max_fee>'

    Examples:
      | daily_fee | min_fee | max_fee   |
      | 12.5      | £100.00 | £250.00   |
      | 20        | £160.00 | £400.00   |
      | 47.99     | £383.92 | £959.80   |
      | 100       | £800.00 | £2,000.00 |
