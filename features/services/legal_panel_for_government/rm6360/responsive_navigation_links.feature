@mobile @javascript
Feature: Legal Panel for Government - Headers are responsive

  Scenario: Signed in and the navigation links are responsive
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Search for suppliers'
    And I am on the 'Do you work for central government or an arms length body?' page
    And the header navigation links 'are not' visible
    Then I click on 'Menu'
    And the header navigation links 'are' visible
    Then I click on the header link 'My account'
    And I am on the 'Your account' page
