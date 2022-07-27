@accessibility @javascript
Feature: Supply Teachers - All agencies - Accessibility

  Background: Login and then navigate to the all agencies page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page
    And I select 'A list of all agencies'
    And I click on 'Continue'
    Then I am on the 'All agencies' page
  
  Scenario: All agencies page
    Then the page should be axe clean
  
  Scenario: Agecny details page - all roles
    Given I click on the supplier 'JOHNS, GLEASON AND WHITE' and it's branch 'Liverpool'
    Then I am on the 'JOHNS, GLEASON AND WHITE' page
    And the sub title is Agency details
    And the 'Branch' is 'Liverpool'
    Then the page should be axe clean

  Scenario: Agecny details page - some roles
    Given I click on the supplier 'BOSCO INC' and it's branch 'Twickenham'
    Then I am on the 'BOSCO INC' page
    And the sub title is Agency details
    And the 'Branch' is 'Twickenham'
    Then the page should be axe clean
