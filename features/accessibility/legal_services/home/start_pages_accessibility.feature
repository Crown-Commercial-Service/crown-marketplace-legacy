@accessibility @javascript
Feature: Legal Services - Start pages accessibility

  Scenario: Service start page
    When I go to the 'legal services' start page
    Then I am on the 'Find legal services for the wider public sector' page
    Then the page should be axe clean

  Scenario: Log in page
    When I go to the 'legal services' start page
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your legal services buyer account' page
    Then the page should be axe clean

  Scenario: Start page
    Given I sign in and navigate to the start page for 'legal services'
    Then the page should be axe clean
