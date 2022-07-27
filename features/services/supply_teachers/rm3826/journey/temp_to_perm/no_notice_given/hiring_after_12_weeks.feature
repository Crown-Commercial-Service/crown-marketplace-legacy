Feature: Supply Teachers - Temp to perm - No notice given - hiring after 12 weeks

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '150' for the 'day rate'
    And I enter '20' for the 'markup rate'
    Given I enter '03/08/2021' for the 'hire' date

  @pipeline
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

  @pipeline
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

  Scenario Outline: Changing the day rate changes the result
    And I enter '<day_rate>' for the 'day rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£0' and '<max_fee>'

    Examples:
      | day_rate  | max_fee     |
      | 50        | £166.67     |
      | 123       | £410.00     |
      | 150       | £500.00     |
      | 235       | £783.33     |
      | 4321      | £14,403.33  |

  Scenario Outline: Changing the markup rate changes the result
    And I enter '<markup_rate>' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£0' and '<max_fee>'

    Examples:
      | markup_rate | max_fee   |
      | 0           | £0.00     |
      | 12.5        | £333.33   |
      | 20          | £500.00   |
      | 47.99       | £972.84   |
      | 100         | £1,500.00 |
