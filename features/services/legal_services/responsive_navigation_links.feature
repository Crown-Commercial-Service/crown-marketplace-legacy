@mobile @javascript
Feature: Legal Services - Headers are responsive

  Scenario: Signed in and the navigation links are responsive
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    And the header navigation links 'are not' visible
    Then I click on 'Menu'
    And the header navigation links 'are' visible
    Then I click on the header link 'Back to start'
    And I am on the 'Find legal services for the wider public sector' page
