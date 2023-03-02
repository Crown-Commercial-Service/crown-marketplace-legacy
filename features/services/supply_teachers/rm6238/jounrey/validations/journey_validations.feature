Feature: Supply Teachers - Jounrey validations

  Scenario: What is your school looking for? validations
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I click on 'Continue'
    Then I should see the following error messages:
      | Select individual worker, managed service provider, or calculate temp-to-perm fee |
