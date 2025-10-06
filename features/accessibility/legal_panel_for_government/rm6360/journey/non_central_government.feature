@accessibility @javascript
Feature: Legal Panel for Government - Non central government - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government?' page

  Scenario: Sorry, this panel isn't suitable for you
    And I select 'No'
    And I click on 'Continue'
    Then I am on the "Sorry, this panel isn't suitable for you" page
    Then the page should pass the accessibility checks
