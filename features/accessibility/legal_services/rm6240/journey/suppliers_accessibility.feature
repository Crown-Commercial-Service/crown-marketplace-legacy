@accessibility @javascript
Feature: Legal services - Suppliers - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page

  Scenario Outline: Results page - central govenrment - Lots 1 and 2
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Is this service suitable for your requirements?' page
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
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Then the page should be axe clean

    Examples:
      | lot                               | service                 | number_of_suppliers |
      | Lot 1 - Full service provision    | Information Technology  | 4                   |
      | Lot 2 - General service provision | Employment              | 3                   |

  Scenario Outline: Results page - non central govenrment - Lots 1 and 2
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
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Then the page should be axe clean

    Examples:
      | lot                               | service                 | number_of_suppliers |
      | Lot 1 - Full service provision    | Information Technology  | 4                   |
      | Lot 2 - General service provision | Employment              | 3                   |

  Scenario Outline: Supplier page - central govenrment - Lots 1 and 2
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Is this service suitable for your requirements?' page
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
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    And I click on '<supplier_name>'
    Then I am on the '<supplier_name>' page
    Then the page should be axe clean

    Examples:
      | lot                               | service                 | number_of_suppliers | supplier_name             |
      | Lot 1 - Full service provision    | Information Technology  | 4                   | DUBUQUE-PADBERG           |
      | Lot 2 - General service provision | Employment              | 3                   | COLLINS, COLE AND PACOCHA |

  Scenario Outline: Supplier page - non central govenrment - Lots 1 and 2
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
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    And I click on '<supplier_name>'
    Then I am on the '<supplier_name>' page
    Then the page should be axe clean

    Examples:
      | lot                               | service                 | number_of_suppliers | supplier_name             |
      | Lot 1 - Full service provision    | Information Technology  | 4                   | DUBUQUE-PADBERG           |
      | Lot 2 - General service provision | Employment              | 3                   | COLLINS, COLE AND PACOCHA |

  Scenario Outline: Download supplier list page - central govenrment - Lots 1 and 2
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Is this service suitable for your requirements?' page
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
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

    Examples:
      | lot                               | service                 | number_of_suppliers |
      | Lot 1 - Full service provision    | Information Technology  | 4                   |
      | Lot 2 - General service provision | Employment              | 3                   |

  Scenario Outline: Download supplier list page - non central govenrment - Lots 1 and 2
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
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '<number_of_suppliers>' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

    Examples:
      | lot                               | service                 | number_of_suppliers |
      | Lot 1 - Full service provision    | Information Technology  | 4                   |
      | Lot 2 - General service provision | Employment              | 3                   |

  Scenario: Results page - central govenrment - Lot 3
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Is this service suitable for your requirements?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal services
    Then the page should be axe clean

  Scenario: Supplier page - central govenrment - Lot 3
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Is this service suitable for your requirements?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal services
    And I click on 'LUETTGEN LLC'
    Then I am on the 'LUETTGEN LLC' page
    Then the page should be axe clean

  Scenario: Download supplier list page - central govenrment - Lot 3
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Is this service suitable for your requirements?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean

  Scenario: Results page - non central govenrment - Lot 3
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal services
    Then the page should be axe clean

  Scenario: Supplier page - non central govenrment - Lot 3
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal services
    And I click on 'LUETTGEN LLC'
    Then I am on the 'LUETTGEN LLC' page
    Then the page should be axe clean

  Scenario: Download supplier list page - non central govenrment - Lot 3
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal services
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    Then the page should be axe clean
