Feature: Supply Teachers - Temp to perm - No notice given - hiring between 9 and 12 weeks

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '150' for the 'day rate'
    And I enter '20' for the 'markup rate'
    Given I enter '19/06/2021' for the 'hire' date

  @pipeline
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

  Scenario Outline: Changing the day rate changes the result
    And I enter '<day_rate>' for the 'day rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '<min_fee>' and '<max_fee>'

    Examples:
      | day_rate  | min_fee   | max_fee     |
      | 50        | £66.67    | £166.67     |
      | 123       | £164.00   | £410.00     |
      | 150       | £200.00   | £500.00     |
      | 235       | £313.33   | £783.33     |
      | 4321      | £5,761.33 | £14,403.33  |

  @pipeline
  Scenario Outline: Changing the markup rate changes the result
    And I enter '<markup_rate>' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '<min_fee>' and '<max_fee>'

    Examples:
      | markup_rate | min_fee | max_fee   |
      | 12.5        | £133.33 | £333.33   |
      | 20          | £200.00 | £500.00   |
      | 47.99       | £389.13 | £972.84   |
      | 100         | £600.00 | £1,500.00 |

  Scenario: When the markup rate is 0%, the result is £0
    And I enter '0' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£0'
