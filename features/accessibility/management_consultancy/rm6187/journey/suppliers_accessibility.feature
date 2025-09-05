@accessibility @javascript
Feature: Management Consultancy - Suppliers - Accessibility

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 1 - Business'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | BATZ, BROWN AND BREITENBERG   |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Supplier results page
    Then the page should pass the accessibility checks

  Scenario: Supplier page
    Then I click on 'BATZ, BROWN AND BREITENBERG'
    And I am on the 'BATZ, BROWN AND BREITENBERG' page
    Then the page should pass the accessibility checks

  Scenario: Download supplier list page
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should pass the accessibility checks
