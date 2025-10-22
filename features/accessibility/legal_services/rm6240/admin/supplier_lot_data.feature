@accessibility @javascript
Feature: Legal services - Admin - Supplier lot data - Lot data - Accessibility

  Background: Navigate to supplier data
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page

  Scenario: Lot status
    And I click on 'View lot data' for 'COLLINS, COLE AND PACOCHA'
    Then I am on the 'Supplier lot data' page
    And the caption is 'COLLINS, COLE AND PACOCHA'
    Then the page should pass the accessibility checks

  Scenario Outline: Services - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View services' for the lot '<full_lot_name>'
    Then I am on the '<lot_name> - Services' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | full_lot_name                                          | lot_name                              | supplier_name               |
      | Lot 1a - Full service provision (England and Wales)    | Lot 1a - Full service provision       | LEDNER, BAILEY AND WEISSNAT |
      | Lot 1b - Full service provision (Scotland)             | Lot 1b - Full service provision       | MERTZ-HOMENICK              |
      | Lot 1c - Full service provision (Northern Ireland)     | Lot 1c - Full service provision       | WILLIAMSON-BERGSTROM        |
      | Lot 2a - General service provision (England and Wales) | Lot 2a - General service provision    | GUSIKOWSKI, BOSCO AND CRIST |
      | Lot 2b - General service provision (Scotland)          | Lot 2b - General service provision    | WEHNER, STEHR AND KULAS     |
      | Lot 2c - General service provision (Northern Ireland)  | Lot 2c - General service provision    | TREUTEL, GERLACH AND SPORER |
      | Lot 3 - Transport rail legal services                  | Lot 3 - Transport rail legal services | ZIEME GROUP                 |

  Scenario Outline: Rates - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View rates' for the lot '<full_lot_name>'
    Then I am on the '<lot_name> - Rates' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | full_lot_name                                          | lot_name                              | supplier_name               |
      | Lot 1a - Full service provision (England and Wales)    | Lot 1a - Full service provision       | LEDNER, BAILEY AND WEISSNAT |
      | Lot 1b - Full service provision (Scotland)             | Lot 1b - Full service provision       | MERTZ-HOMENICK              |
      | Lot 1c - Full service provision (Northern Ireland)     | Lot 1c - Full service provision       | WILLIAMSON-BERGSTROM        |
      | Lot 2a - General service provision (England and Wales) | Lot 2a - General service provision    | GUSIKOWSKI, BOSCO AND CRIST |
      | Lot 2b - General service provision (Scotland)          | Lot 2b - General service provision    | WEHNER, STEHR AND KULAS     |
      | Lot 2c - General service provision (Northern Ireland)  | Lot 2c - General service provision    | TREUTEL, GERLACH AND SPORER |
      | Lot 3 - Transport rail legal services                  | Lot 3 - Transport rail legal services | ZIEME GROUP                 |
