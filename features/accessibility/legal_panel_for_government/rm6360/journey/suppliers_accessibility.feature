@accessibility @javascript
Feature: Legal Panel for Government - Suppliers - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government or an arms length body?' page

  Scenario Outline: Results page - Lots 1, 2, 3 and 5
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal specialisms you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Then the page should pass the accessibility checks

    Examples:
      | lot                                       | service           | number_of_suppliers |
      | Lot 1 - Core Legal Services               | Assimilated Law   | 5                   |
      | Lot 2 - Major Projects and Complex Advice | Assimilated Law   | 3                   |
      | Lot 3 - Finance and High Risk/Innovation  | Corporate Finance | 5                   |
      | Lot 5 - Rail Legal Services               | Competition law   | 3                   |

  Scenario Outline: Results page - Lot 4
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    And I select 'No'
    And I click on 'Continue'
    And I am on the 'Select the legal specialisms you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Then the page should pass the accessibility checks

    Examples:
      | lot                                        | service                                 | number_of_suppliers |
      | Lot 4a - Trade and Investment Negotiations | Assimilated Law                         | 5                   |
      | Lot 4b - International Trade Disputes      | Compliance with international law       | 3                   |
      | Lot 4c - International Investment Disputes | Domestic law of jurisdictions for trade | 3                   |

  Scenario Outline: Suppliers page - Lots 1, 2, 3 and 5
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal specialisms you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    And I click on '<supplier_name>'
    Then I am on the '<supplier_name>' page
    Then the page should pass the accessibility checks

    Examples:
      | lot                                       | service           | number_of_suppliers | supplier_name                 |
      | Lot 1 - Core Legal Services               | Assimilated Law   | 5                   | LOCKMAN, NITZSCHE AND BARTELL |
      | Lot 2 - Major Projects and Complex Advice | Assimilated Law   | 3                   | CORMIER INC                   |
      | Lot 3 - Finance and High Risk/Innovation  | Corporate Finance | 5                   | TILLMAN, LUBOWITZ AND GOYETTE |
      | Lot 5 - Rail Legal Services               | Competition law   | 3                   | STANTON-GOYETTE               |

  Scenario Outline: Suppliers page - Lot 4
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    And I select 'No'
    And I click on 'Continue'
    And I am on the 'Select the legal specialisms you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    And I click on '<supplier_name>'
    Then I am on the '<supplier_name>' page
    Then the page should pass the accessibility checks

    Examples:
      | lot                                        | service                                 | number_of_suppliers | supplier_name     |
      | Lot 4a - Trade and Investment Negotiations | Assimilated Law                         | 5                   | CROOKS AND SONS   |
      | Lot 4b - International Trade Disputes      | Compliance with international law       | 3                   | SANFORD INC       |
      | Lot 4c - International Investment Disputes | Domestic law of jurisdictions for trade | 3                   | JOHNSON-ROMAGUERA |

  Scenario Outline: Download supplier list page - Lots 1, 2, 3 and 5
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal specialisms you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should pass the accessibility checks

    Examples:
      | lot                                       | service           | number_of_suppliers |
      | Lot 1 - Core Legal Services               | Assimilated Law   | 5                   |
      | Lot 2 - Major Projects and Complex Advice | Assimilated Law   | 3                   |
      | Lot 3 - Finance and High Risk/Innovation  | Corporate Finance | 5                   |
      | Lot 5 - Rail Legal Services               | Competition law   | 3                   |

  Scenario Outline: Download supplier list page - Lot 4
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    And I select 'No'
    And I click on 'Continue'
    And I am on the 'Select the legal specialisms you need' page
    And the sub title is '<lot>'
    Given I check '<service>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should pass the accessibility checks

    Examples:
      | lot                                        | service                                 | number_of_suppliers |
      | Lot 4a - Trade and Investment Negotiations | Assimilated Law                         | 5                   |
      | Lot 4b - International Trade Disputes      | Compliance with international law       | 3                   |
      | Lot 4c - International Investment Disputes | Domestic law of jurisdictions for trade | 3                   |
