@accessibility @javascript
Feature: Legal services - Non Central Government - Lot 1 - Accessibility

  Background: Login and then navigate to the start page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
  
  Scenario: Select the lot you need page
    Then the page should be axe clean

  Scenario: Select the legal services you need page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    Then the page should be axe clean

  Scenario: Select the legal services you need page - some services selected
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Education             |
      | Intellectual property |
      | Pensions              |
    Then the basket should say '3 services selected'
    And the following items should appear in the basket:
      | Education             |
      | Intellectual property |
      | Pensions              |
    Then the page should be axe clean

  Scenario: Select the regions where you need legal services page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Social housing |
    Then I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And the page should be axe clean

  Scenario: Select the regions where you need legal services page - some regions selected
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Social housing |
    Then I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | Wales             |
      | Scotland          |
      | Northern Ireland  |
    Then the basket should say '3 regions selected'
    And the following items should appear in the basket:
      | Wales             |
      | Scotland          |
      | Northern Ireland  |
    And the page should be axe clean
