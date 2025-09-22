@accessibility @javascript
Feature: Legal Panel for Government - Admin - Supplier lot data - Lot data - Accessibility

  Background: Navigate to supplier data
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page

  Scenario: Lot status
    And I click on 'View lot data' for 'ADAMS, WOLFF AND STROMAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'ADAMS, WOLFF AND STROMAN'
    Then the page should pass the accessibility checks

  Scenario Outline: Services - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View services' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Services' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                                   | supplier_name              |
      | Lot 1 - Core Legal Services                | BALISTRERI-MURAZIK         |
      | Lot 2 - Major Projects and Complex Advice  | CORMIER INC                |
      | Lot 3 - Finance and High Risk/Innovation   | SANFORD INC                |
      | Lot 4a - Trade and Investment Negotiations | DICKI, QUITZON AND KUB     |
      | Lot 4b - International Trade Disputes      | KOELPIN, HILLL AND COLLINS |
      | Lot 4c - International Investment Disputes | VEUM, TORPHY AND NOLAN     |
      | Lot 5 - Rail Legal Services                | WALKER-LEUSCHKE            |

  Scenario Outline: Rates - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View rates' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Rates' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                                   | supplier_name              |
      | Lot 1 - Core Legal Services                | BALISTRERI-MURAZIK         |
      | Lot 2 - Major Projects and Complex Advice  | CORMIER INC                |
      | Lot 3 - Finance and High Risk/Innovation   | SANFORD INC                |
      | Lot 4a - Trade and Investment Negotiations | DICKI, QUITZON AND KUB     |
      | Lot 4b - International Trade Disputes      | KOELPIN, HILLL AND COLLINS |
      | Lot 4c - International Investment Disputes | VEUM, TORPHY AND NOLAN     |
      | Lot 5 - Rail Legal Services                | WALKER-LEUSCHKE            |

  Scenario Outline: Jurisdictions - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View jurisdictions' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Jurisdictions' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                                   | supplier_name              |
      | Lot 4a - Trade and Investment Negotiations | DICKI, QUITZON AND KUB     |
      | Lot 4b - International Trade Disputes      | KOELPIN, HILLL AND COLLINS |
      | Lot 4c - International Investment Disputes | VEUM, TORPHY AND NOLAN     |
