@accessibility @javascript
Feature: Supply Teachers - FTA to perm - Accessibility

  Background: Login and then navigate to the What date did the workers fixed term contract start? page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page
    And I select 'To work out what fixed-term worker transfer fee I could be charged'
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract start?' page

  Scenario: Contract start date page
    Then the page should be axe clean

  Scenario: Contract end date page
    And I enter a date 1 years and 2 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    Then the page should be axe clean

  Scenario: No transfer fee required page - contract ended within 6 months and was more than 12 months
    And I enter a date 1 years and 2 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    And the reason for no transfer fee is:
      | Based on the information you have provided, no fee is required as the employee has been continually employed for more than 12 months. |
    Then the page should be axe clean

  Scenario: No transfer fee required page - contract ended after 6 months and was more than 12 months
    And I enter a date 1 years and 8 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 7 months into the past
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    And the reason for no transfer fee is:
      | Based on the information you have provided, no fee is required as the employee's contract ended more than 6 months ago. |
    Then the page should be axe clean

  Scenario: No transfer fee required page - hire date 6 months after the contract end
    And I enter a date 0 years and 6 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 6 months into the future
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    And the reason for no transfer fee is:
      | Based on the information you have provided, no fee is required as the gap between the employee's contract finishing and fully permanent position starting is greater than or equal to 6 months. |

  Scenario: Employment start date page
    And I enter a date 0 years and 6 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    Then the page should be axe clean
  
  Scenario: Employment start date page
    And I enter a date 0 years and 6 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    Then the page should be axe clean
  
  Scenario: If you wait and do not employ page
    And I enter a date 0 years and 6 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 2 months into the future
    And I click on 'Continue'
    Then I am on the 'If you wait and do not employ' page
    Then the page should be axe clean

  Scenario: Entering the fee page
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
    Then the page should be axe clean

  Scenario: Final page with results
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
    And I enter '500' for the 'fixed term fee'
    And I click on 'Continue'
    Then I am on the 'You could be charged £700.00' page
    Then the page should be axe clean
