Feature: Supply Teachers - Temp to perm - Notice given - hiring between 9 and 12 weeks

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '150' for the 'day rate'
    And I enter '20' for the 'markup rate'
    And I enter '19/06/2021' for the 'hire' date
    And I enter '30/05/2021' for the 'notice' date

  @pipeline
  Scenario Outline: Changing the length of the notice period changes the result
    Given I enter '<date>' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | date        | fee     |
      | 19/06/2021  | £500.00 |
      | 12/06/2021  | £500.00 |
      | 05/06/2021  | £475.00 |
      | 30/05/2021  | £375.00 |
      | 23/05/2021  | £250.00 |
      | 20/05/2021  | £200.00 |
      | 01/05/2021  | £200.00 |

  Scenario Outline: Changing the number of days per week changes the result
    And I enter '<days_per_week>' for the 'days per week'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | days_per_week | fee     |
      | 1             | £75.00  |
      | 2             | £150.00 |
      | 3             | £225.00 |
      | 4             | £300.00 |
      | 5             | £375.00 |

  Scenario Outline: Changing the day rate changes the result
    And I enter '<day_rate>' for the 'day rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | day_rate  | fee         |
      | 50        | £125.00     |
      | 123       | £307.50     |
      | 150       | £375.00     |
      | 235       | £587.50     |
      | 4321      | £10,802.50  |

  Scenario Outline: Changing the markup rate changes the result
    And I enter '<markup_rate>' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '<fee>'

    Examples:
      | markup_rate | fee       |
      | 12.5        | £250.00   |
      | 20          | £375.00   |
      | 47.99       | £729.63   |
      | 100         | £1,125.00 |

  @pipeline
  Scenario: When the markup rate is 0%, the result is £0
    And I enter '0' for the 'markup rate'
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£0'
