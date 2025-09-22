@accessibility @javascript
Feature: Supply Teachers - All agencies - Accessibility

  Background: Login and then navigate to the all agencies page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page
    And I select 'A list of all agencies'
    And I click on 'Continue'
    Then I am on the 'Find an agency' page

  Scenario: All agencies page
    Then the page should pass the accessibility checks

  Scenario: Agency details page - all roles
    Given I click on 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'BARTOLETTI, KOEPP AND NIENOW' page
    And the sub title is Agency details
    Then the page should pass the accessibility checks

  Scenario: Agency details page - some roles
    Given I click on 'HAGENES-BECHTELAR'
    Then I am on the 'HAGENES-BECHTELAR' page
    And the sub title is Agency details
    Then the page should pass the accessibility checks
