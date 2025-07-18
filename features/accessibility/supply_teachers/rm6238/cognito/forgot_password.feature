@accessibility @javascript
Feature: Forgot my password - Supply Teachers - RM6238 - Accessibility

  Scenario: I forgot my password
    When I go to the 'supply teachers' start page for 'RM6238'
    Then I am on the 'Find supply teachers and agency workers' page
    When I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    And I click on 'Sign in with CCS'
    And I am on the 'Sign in to your supply teachers account' page
    When I click on 'I’ve forgotten my password'
    Then I am on the 'Reset password' page
    Then the page should be axe clean excluding ".ccs-contact-us"
