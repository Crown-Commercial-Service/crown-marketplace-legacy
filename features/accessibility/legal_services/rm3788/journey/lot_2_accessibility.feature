@accessibility @javascript
Feature: Legal services - Non Central Government - Lot 2 - Accessibility

  Background: Login and then navigate to the Select the jurisdiction you need page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page

  Scenario: Select the jurisdiction you need page
    Then the page should be axe clean

  Scenario: Select the legal services you need page
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    Then the page should be axe clean

  Scenario: Select the legal services you need page - some services selected
    And I select 'Northern Ireland'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Corporate and M&A                   |
      | Data protection and information law |
      | EU                                  |
      | Education law                       |
    Then the basket should say '4 services selected'
    And the following items should appear in the basket:
      | Corporate and M&A                   |
      | Data protection and information law |
      | EU                                  |
      | Education law                       |
    Then the page should be axe clean
