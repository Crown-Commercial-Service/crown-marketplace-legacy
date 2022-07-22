@accessibility @javascript
Feature: Supply Teachers - All agencies - Accessibility

  Background: Login and then navigate to the all agencies page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page
    And I select 'A list of all agencies'
    And I click on 'Continue'
    Then I am on the 'All agencies' page
  
  Scenario: All agencies page
    Then the page should be axe clean
  
  Scenario: Agecny details page - all roles
    Given I click on the supplier 'BARTOLETTI, KOEPP AND NIENOW' and it's branch 'Southport'
    Then I am on the 'BARTOLETTI, KOEPP AND NIENOW' page
    And the sub title is Agency details
    And the 'Branch' is 'Southport'
    Then the page should be axe clean

  Scenario: Agecny details page - some roles
    Given I click on the supplier 'HAGENES-BECHTELAR' and it's branch 'London'
    Then I am on the 'HAGENES-BECHTELAR' page
    And the sub title is Agency details
    And the 'Branch' is 'London'
    Then the page should be axe clean
