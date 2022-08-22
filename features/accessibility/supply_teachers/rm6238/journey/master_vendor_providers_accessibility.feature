@accessibility @javascript
Feature: Supply Teachers - Managed service providers - Accessibility

  Background: Navigate to What type of managed service do you want?
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider - Master Vendor'"
    And I click on 'Continue'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page

  Scenario: Is your contract likely to be worth more than £2.5 million? page
    Then the page should be axe clean

  Scenario Outline: Master vendor managed service providers page
    And I select '<option>'
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    And the caption is '<caption>'
    Then the page should be axe clean

    Examples:
      | option  | caption                               |
      | Yes     | Contract worth more than £2.5 million |
      | No      | Contract worth less than £2.5 million |
