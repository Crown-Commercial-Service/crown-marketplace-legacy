Feature: Sign in to my account - Legal Panel for Government - RM6360 - Buyer details - Validations

  Background: Navigate to Buyer Details page
    Given I sign in without details and navigate to the start page for the 'RM6360' framework in 'legal panel for government'

  Scenario: Save and return - Personal details - empty field
    And I click on 'Answer questions (Personal details)'
    Then I am on the 'Manage your personal details' page
    When I click on 'Save and return'
    Then I should see the following error messages:
      | Enter your full name |
      | Enter your job title |

  Scenario: Save and return - Organisation details - empty field
    And I click on 'Answer questions (Organisation details)'
    Then I am on the 'Manage your organisation details' page
    When I click on 'Save and return'
    Then I should see the following error messages:
      | Enter your organisation name                                    |
      | Select the type of public sector organisation you’re buying for |
