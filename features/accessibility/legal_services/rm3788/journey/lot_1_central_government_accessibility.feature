@accessibility @javascript
Feature: Legal services - Central Government - Lot 1 - Accessibility

  Background: Login and then navigate to the start page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page

  Scenario: Do you work for central government? page
    Then the page should be axe clean

  Scenario: Will the fees be under £20,000 per matter? page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    Then the page should be axe clean

  Scenario: Sorry, this panel isn't suitable for you page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the "Sorry, this panel isn't suitable for you" page
    Then the page should be axe clean

  Scenario: Select the legal services you need page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    Then the page should be axe clean

  Scenario: Select the legal services you need page - some services selected
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Property and construction |
    Then the basket should say '1 service selected'
    And the following items should appear in the basket:
      | Property and construction |
    Then the page should be axe clean
  
  Scenario: Select the regions where you need legal services page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Property and construction |
    Then I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And the page should be axe clean

  Scenario: Select the regions where you need legal services page - some regions selected
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I check the following items:
      | Property and construction |
    Then I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | East Midlands |
      | West Midlands |
    Then the basket should say '2 regions selected'
    And the following items should appear in the basket:
      | East Midlands |
      | West Midlands |
    And the page should be axe clean
