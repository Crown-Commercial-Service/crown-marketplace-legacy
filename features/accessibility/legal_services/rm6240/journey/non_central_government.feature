@accessibility @javascript
Feature: Legal services - Non central government - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page

  Scenario: Select the lot you need
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    Then the page should pass the accessibility checks

  Scenario Outline: Select the legal services you need
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Then the page should pass the accessibility checks

    Examples:
      | lot                               |
      | Lot 1 - Full service provision    |
      | Lot 2 - General service provision |

  Scenario Outline: Select the Select the jurisdiction you need you need
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is '<lot>'
    Then the page should pass the accessibility checks

    Examples:
      | lot                               | service                |
      | Lot 1 - Full service provision    | Information Technology |
      | Lot 2 - General service provision | Employment             |
