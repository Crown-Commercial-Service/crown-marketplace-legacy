@accessibility @javascript
Feature: Legal services - Suppliers - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page

  Scenario: Supplier results page for lot 1
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | Full national coverage  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    Then the page should be axe clean

  Scenario: Supplier page for lot 1
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | Full national coverage  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    Then I click on 'SCHMITT INC'
    And I am on the 'SCHMITT INC' page
    Then the page should be axe clean

  Scenario:  Download supplier list page for lot 1
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | Full national coverage  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

  Scenario: Supplier results page for lot 2
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I select 'England and Wales'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services
    Then the page should be axe clean

  Scenario: Supplier page for lot 2
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I select 'England and Wales'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services
    Then I click on 'RICE-PROHASKA'
    And I am on the 'RICE-PROHASKA' page
    Then the page should be axe clean

  Scenario:  Download supplier list page for lot 2
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I select 'England and Wales'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

  Scenario Outline: Supplier results page for lots 3 and 4
    And I select '<lot>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is '<lot>'
    And I should see that '10' suppliers can provide legal services
    Then the page should be axe clean

    Examples:
      | lot                               |
      | Lot 3 - Property and construction |
      | Lot 4 - Transport rail            |

  Scenario Outline: Supplier page for lots 3 and 4
    And I select '<lot>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is '<lot>'
    And I should see that '10' suppliers can provide legal services
    Then I click on '<supplier>'
    And I am on the '<supplier>' page
    Then the page should be axe clean

    Examples:
      | lot                               | supplier                        |
      | Lot 3 - Property and construction | HANSEN, MORISSETTE AND ONDRICKA |
      | Lot 4 - Transport rail            | DOUGLAS AND SONS                |

  Scenario Outline:  Download supplier list page for lots 3 and 4
    And I select '<lot>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is '<lot>'
    And I should see that '10' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

    Examples:
      | lot                               |
      | Lot 3 - Property and construction |
      | Lot 4 - Transport rail            |


  Scenario Outline: Supplier results page for lots 3 and 4
    And I select '<lot>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is '<lot>'
    And I should see that '10' suppliers can provide legal services
    Then the page should be axe clean

    Examples:
      | lot                               |
      | Lot 3 - Property and construction |
      | Lot 4 - Transport rail            |

  Scenario Outline: Supplier page for lots 3 and 4
    And I select '<lot>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is '<lot>'
    And I should see that '10' suppliers can provide legal services
    Then I click on '<supplier>'
    And I am on the '<supplier>' page
    Then the page should be axe clean

    Examples:
      | lot                               | supplier                        |
      | Lot 3 - Property and construction | HANSEN, MORISSETTE AND ONDRICKA |
      | Lot 4 - Transport rail            | DOUGLAS AND SONS                |

  Scenario Outline:  Download supplier list page for lots 3 and 4
    And I select '<lot>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is '<lot>'
    And I should see that '10' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

    Examples:
      | lot                               |
      | Lot 3 - Property and construction |
      | Lot 4 - Transport rail            |
