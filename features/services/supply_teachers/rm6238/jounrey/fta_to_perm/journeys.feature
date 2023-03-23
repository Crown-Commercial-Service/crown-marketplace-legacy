Feature: Supply Teachers - FTA to perm - results

  Background: Navigate to the FTA to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To work out what fixed-term worker transfer fee I could be charged'
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract start?' page

  Scenario: Contract ended within 6 months and the length is more then tweleve months
    And I enter a date 1 years and 2 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    And the reason for no transfer fee is:
      | Based on the information you have provided, no fee is required as the employee has been continually employed for more than 12 months. |
    And I click on 'Check another fixed term contract'
    And I am on the 'What date did the workers fixed term contract start?' page

  Scenario: Contract ended after 6 months and the length is more then tweleve months
    And I enter a date 1 years and 8 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 7 months into the past
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    And the reason for no transfer fee is:
      | Based on the information you have provided, no fee is required as the employee's contract ended more than 6 months ago. |
    And I click on 'Check another fixed term contract'
    And I am on the 'What date did the workers fixed term contract start?' page

  Scenario: Contract ended after 6 months and the length is less then tweleve months
    And I enter a date 0 years and 9 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 7 months into the past
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    And the reason for no transfer fee is:
      | Based on the information you have provided, no fee is required as the employee's contract ended more than 6 months ago. |
    And I click on 'Check another fixed term contract'
    And I am on the 'What date did the workers fixed term contract start?' page

  Scenario: Hire date 6 months after the contract end
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
    And I click on 'Check another fixed term contract'
    And I am on the 'What date did the workers fixed term contract start?' page

  Scenario: I can view the rate at which I will be charged
    And I enter a date 0 years and 6 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 2 months into the future
    And I click on 'Continue'
    Then I am on the 'If you wait and do not employ' page
    And the date I need to wait until is six months after 1 months ago in the 'title'
    And I click on "I don't want to wait that long - continue to calculate fee"
    Then I am on the 'What fixed term fee did you pay the worker?' page
    And I enter '500' for the 'fixed term fee'
    And I click on 'Continue'
    Then I am on the 'You could be charged £700.00' page
    And the date I need to wait until is six months after 1 months ago in the 'panel'
    And I click on 'Check another fixed term contract'
    And I am on the 'What date did the workers fixed term contract start?' page

  Scenario: Back buttons
    When I click on 'Back'
    Then I am on the 'What is your school looking for?' page
    Given I select 'To work out what fixed-term worker transfer fee I could be charged'
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract start?' page
    And I enter a date 0 years and 9 months into the past
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    When I click on 'Back'
    Then I am on the 'What date did the workers fixed term contract start?' page
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 7 months into the past
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    When I click on 'Back'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter a date 0 years and 1 months into the past
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    When I click on 'Back'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 6 months into the future
    And I click on 'Continue'
    Then I am on the 'No transfer fee required' page
    When I click on 'Back'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter a date 0 years and 1 months into the future
    And I click on 'Continue'
    Then I am on the 'If you wait and do not employ' page
    When I click on 'Back'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I click on 'Continue'
    Then I am on the 'If you wait and do not employ' page
    And I click on "I don't want to wait that long - continue to calculate fee"
    Then I am on the 'What fixed term fee did you pay the worker?' page
    When I click on 'Back'
    Then I am on the 'If you wait and do not employ' page
    And I click on "I don't want to wait that long - continue to calculate fee"
    Then I am on the 'What fixed term fee did you pay the worker?' page
    And I enter '500' for the 'fixed term fee'
    And I click on 'Continue'
    Then I am on the 'You could be charged £250.00' page
    When I click on 'Back'
    Then I am on the 'What fixed term fee did you pay the worker?' page
    And I click on 'Continue'
    Then I am on the 'You could be charged £250.00' page
