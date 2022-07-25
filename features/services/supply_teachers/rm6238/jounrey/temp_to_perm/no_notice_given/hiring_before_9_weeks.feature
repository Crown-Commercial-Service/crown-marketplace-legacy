Feature: Supply Teachers - Temp to perm - No notice given - hiring before 9 weeks

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '150' for the 'day rate'
    And I enter '20' for the 'markup rate'
    Given I enter '31/05/2021' for the 'hire' date

  @pipeline
  Scenario Outline: Changing the length of the current contract changes the result
    Given I enter '<date>' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | date        | fee       |
      | 04/04/2021  | £1,500.00 |
      | 01/05/2021  | £1,025.00 |
      | 02/05/2021  | £1,025.00 |
      | 03/05/2021  | £1,025.00 |
      | 18/05/2021  | £775.00   |
      | 31/05/2021  | £550.00   |

  Scenario Outline: Changing the number of days per week changes the result
    And I enter '<days_per_week>' for the 'days per week'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | days_per_week | fee     |
      | 1             | £110.00 |
      | 2             | £220.00 |
      | 3             | £330.00 |
      | 4             | £440.00 |
      | 5             | £550.00 |

  @pipeline
  Scenario Outline: Changing the day rate changes the result
    And I enter '<day_rate>' for the 'day rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | day_rate  | fee         |
      | 50        | £183.33     |
      | 123       | £451.00     |
      | 150       | £550.00     |
      | 235       | £861.67     |
      | 4321      | £15,843.67  |

  Scenario Outline: Changing the markup rate changes the result
    And I enter '<markup_rate>' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | markup_rate | fee       |
      | 12.5        | £366.67   |
      | 20          | £550.00   |
      | 47.99       | £1,070.12 |
      | 100         | £1,650.00 |

  Scenario: When the markup rate is 0%, the result is £0
    And I enter '0' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£0'
