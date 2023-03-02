Feature: Supply Teachers - FTA to perm - results

  Background: Navigate to the FTA to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To work out what fixed-term worker transfer fee I could be charged'
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract start?' page

  Scenario Outline: Changing the rate changes the results
    And I enter a date 0 years and 6 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 2 months into the future
    And I click on 'Continue'
    Then I am on the 'If you wait and do not employ' page
    And I click on "I don't want to wait that long - continue to calculate fee"
    Then I am on the 'What fixed term fee did you pay the worker?' page
    And I enter '<rate>' for the 'fixed term fee'
    And I click on 'Continue'
    Then I am on the '<title>' page

    Examples:
      | rate  | title                           |
      | 100   | You could be charged £140.00    |
      | 500   | You could be charged £700.00    |
      | 678   | You could be charged £949.20    |
      | 1316  | You could be charged £1,842.40  |

  Scenario Outline: Changing the length of the contract changes the results
    And I enter a date 0 years and <months> months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 2 months into the future
    And I click on 'Continue'
    Then I am on the 'If you wait and do not employ' page
    And I click on "I don't want to wait that long - continue to calculate fee"
    Then I am on the 'What fixed term fee did you pay the worker?' page
    And I enter '500' for the 'fixed term fee'
    And I click on 'Continue'
    Then I am on the '<title>' page

    Examples:
      | months  | title                           |
      | 2       | You could be charged £5,500.00  |
      | 5       | You could be charged £1,000.00  |
      | 8       | You could be charged £357.14    |
      | 10      | You could be charged £166.67    |
