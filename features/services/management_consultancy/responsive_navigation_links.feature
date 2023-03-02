@mobile @javascript
Feature: Management Consultancy - Headers are responsive

  Scenario: Signed in and the navigation links are responsive
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    And the header navigation links 'are not' visible
    Then I click on 'Menu'
    And the header navigation links 'are' visible
    Then I click on 'Back to start'
    And I am on the 'Find management consultants' page
