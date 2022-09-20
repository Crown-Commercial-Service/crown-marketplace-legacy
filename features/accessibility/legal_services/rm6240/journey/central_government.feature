@accessibility @javascript
Feature: Legal services - Central government - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page

  Scenario: Do you work for central government?
    Then the page should be axe clean
    
  Scenario: Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    Then the page should be axe clean

  Scenario: Sorry, this panel isn't suitable for you
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the "Sorry, this panel isn't suitable for you" page
    Then the page should be axe clean

  Scenario: Select the lot you need
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    Then the page should be axe clean

  Scenario Outline: Select the legal services you need
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Then the page should be axe clean

    Examples:
      | lot                               |
      | Lot 1 - Full service provision    |
      | Lot 2 - General service provision |

  Scenario Outline: Select the Select the jurisdiction you need you need
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
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
    Then the page should be axe clean

    Examples:
      | lot                               | service                 |
      | Lot 1 - Full service provision    | Information Technology  |
      | Lot 2 - General service provision | Employment              |
