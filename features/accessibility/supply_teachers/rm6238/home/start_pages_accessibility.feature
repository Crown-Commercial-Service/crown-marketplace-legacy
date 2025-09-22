@accessibility @javascript
Feature: Supply Teachers - Start pages accessibility

  Scenario: Service start page
    When I go to the 'supply teachers' start page for 'RM6238'
    Then I am on the 'Find supply teachers and agency workers' page
    Then the page should pass the accessibility checks

  Scenario: Gateway page
    When I go to the 'supply teachers' start page for 'RM6238'
    Then I am on the 'Find supply teachers and agency workers' page
    When I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    Then the page should pass the accessibility checks

  Scenario: Log in page
    When I go to the 'supply teachers' start page for 'RM6238'
    Then I am on the 'Find supply teachers and agency workers' page
    When I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    Then I click on 'Sign in with CCS'
    Then the page should pass the accessibility checks

  Scenario: Start page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    Then the page should pass the accessibility checks
