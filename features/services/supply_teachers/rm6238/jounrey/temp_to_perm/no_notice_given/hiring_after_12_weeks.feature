Feature: Supply Teachers - Temp to perm - No notice given - hiring after 12 weeks

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    Given I enter '03/08/2021' for the 'hire' date

  Scenario Outline: Changing the length of the current contract does not change the result
    Given I enter '<date>' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£0' and '£500'

    Examples:
      | date        |
      | 03/07/2021  |
      | 03/08/2021  |
      | 03/09/2021  |
      | 03/10/2021  |

  Scenario Outline: Changing the number of days per week changes the result
    And I enter '<days_per_week>' for the 'days per week'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£0' and '<max_fee>'

    Examples:
      | days_per_week | max_fee |
      | 1             | £100.00 |
      | 2             | £200.00 |
      | 3             | £300.00 |
      | 4             | £400.00 |
      | 5             | £500.00 |

  Scenario Outline: Changing the daily fee changes the result
    And I enter '<daily_fee>' for the 'daily fee'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£0' and '<max_fee>'

    Examples:
      | daily_fee | max_fee   |
      | 25        | £500.00   |
      | 30        | £600.00   |
      | 35        | £700.00   |
      | 35.50     | £710.00   |
      | 261.99    | £5,239.80 |
