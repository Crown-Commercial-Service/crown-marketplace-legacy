@accessibility @javascript
Feature: Legal Panel for Government - Start pages accessibility

  Scenario: Service start page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    Then the page should pass the accessibility checks

  Scenario: Log in page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your legal panel for government account' page
    Then the page should pass the accessibility checks

  Scenario: Start page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then the page should pass the accessibility checks
