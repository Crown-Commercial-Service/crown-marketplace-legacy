@accessibility @javascript
Feature: Legal Panel for Government - Suppliers comparison - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page

  Scenario Outline: Suppliers comparisons page - Lots 1, 2, 3 and 5
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    And I click on "Compare the supplier rates"
    Then I am on the "Select suppliers for comparison" page
    When I check the following items:
      | <supplier_1> |
      | <supplier_2> |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '2' suppliers have been selected for comparison
    Then the page should pass the accessibility checks

    Examples:
      | lot                                       | service           | number_of_suppliers | supplier_1             | supplier_2        |
      | Lot 1 - Core Legal Services               | Assimilated Law   | 5                   | CORMIER INC            | GOYETTE AND SONS  |
      | Lot 2 - Major Projects and Complex Advice | Assimilated Law   | 3                   | BALISTRERI-MURAZIK     | CORMIER INC       |
      | Lot 3 - Finance and High Risk/Innovation  | Corporate Finance | 5                   | CORMIER INC            | O'CONNER AND SONS |
      | Lot 5 - Rail Legal Services               | Competition law   | 3                   | DICKI, QUITZON AND KUB | JOHNSON-ROMAGUERA |

  Scenario Outline: Suppliers comparisons page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    And I select 'No'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    And I click on "Compare the supplier rates"
    Then I am on the "Select suppliers for comparison" page
    When I check the following items:
      | <supplier_1> |
      | <supplier_2> |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '2' suppliers have been selected for comparison
    Then the page should pass the accessibility checks

    Examples:
      | lot                                        | service                                 | number_of_suppliers | supplier_1               | supplier_2             |
      | Lot 4a - Trade and Investment Negotiations | Assimilated Law                         | 5                   | DICKI, QUITZON AND KUB   | O'CONNER AND SONS      |
      | Lot 4b - International Trade Disputes      | Compliance with international law       | 3                   | ADAMS, WOLFF AND STROMAN | VEUM, TORPHY AND NOLAN |
      | Lot 4c - International Investment Disputes | Domestic law of jurisdictions for trade | 3                   | JOHNSON-ROMAGUERA        | ZIEME-LEANNON          |
