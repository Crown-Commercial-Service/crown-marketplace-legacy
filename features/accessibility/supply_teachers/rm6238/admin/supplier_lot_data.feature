@accessibility @javascript
Feature: Supply Teachers - Admin - Supplier lot data - Lot data - Accessibility

  Background: Navigate to supplier data
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page

  Scenario Outline: Lot status - Lot <lot_number>
    And I click on 'View lot data' for "<supplier_name>"
    Then I am on the 'Supplier lot data' page
    And the caption is "<supplier_name>"
    Then the page should pass the accessibility checks

    Examples:
      | lot_number | supplier_name                |
      | 1          | BARTOLETTI, KOEPP AND NIENOW |
      | 2          | O'HARA LLC                   |
      | 4          | BOYLE, KOEPP AND TURNER      |

  Scenario Outline: Rates - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View rates' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Rates' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                                        | supplier_name                |
      | Lot 1 - Direct provision                        | BARTOLETTI, KOEPP AND NIENOW |
      | Lot 2.1 - Master vendor (less than 2.5 million) | BOGAN, REICHERT AND COLLIER  |
      | Lot 2.2 - Master vendor (more than 2.5 million) | MCGLYNN, BAILEY AND NIKOLAUS |
      | Lot 4 - Education technology platforms          | CHRISTIANSEN INC             |

  Scenario Outline: Branches - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View branches' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Branches' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                 | supplier_name                |
      | Lot 1 - Direct provision | BARTOLETTI, KOEPP AND NIENOW |
