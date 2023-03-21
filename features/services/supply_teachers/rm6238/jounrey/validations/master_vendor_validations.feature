Feature: Supply Teachers - Master Vendor validations

  Scenario: Is your contract likely to be worth more than £2.5 million? validations
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
    And I click on 'Continue'
    Then I should see the following error messages:
      | Select an option  |
