@pipeline
Feature: Supply Teachers - Managed service provider validations

  Background: I sign and select manaed service provider
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'What type of managed service do you want?' page

  Scenario: What type of managed service do you want? validations
    And I click on 'Continue'
    Then I should see the following error messages:
      | Select master vendor or education technology platform service |
