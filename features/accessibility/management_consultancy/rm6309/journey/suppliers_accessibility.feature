@accessibility @javascript
Feature: Management Consultancy - Suppliers - Accessibility

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 1 - Business'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC     |
      | PURDY-KEMMER      |
      | STROSIN-MEDHURST  |
  
  Scenario: Supplier results page
    Then the page should be axe clean

  Scenario: Supplier page
    Then I click on 'GREENHOLT INC'
    And I am on the 'GREENHOLT INC' page
    Then the page should be axe clean

  Scenario: Download supplier list page
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean
