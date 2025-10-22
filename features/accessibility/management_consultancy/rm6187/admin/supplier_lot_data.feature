@accessibility @javascript
Feature: Management Consultancy - Admin - Supplier lot data - Lot data - Accessibility

  Background: Navigate to supplier data
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page

  Scenario: Lot status
    And I click on 'View lot data' for 'BATZ, BROWN AND BREITENBERG'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BATZ, BROWN AND BREITENBERG'
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
      | lot_name                                                            | supplier_name                 |
      | Lot 1 - Business                                                    | TREMBLAY-MOORE                |
      | Lot 2 - Strategy and Policy                                         | BERNHARD INC                  |
      | Lot 3 - Complex and Transformation                                  | ROMAGUERA INC                 |
      | Lot 4 - Finance                                                     | VEUM-RODRIGUEZ                |
      | Lot 5 - HR                                                          | BOSCO-EBERT                   |
      | Lot 6 - Procurement and Supply Chain                                | VANDERVORT, KOVACEK AND MORAR |
      | Lot 7 - Health, Social Care and Community                           | BATZ, BROWN AND BREITENBERG   |
      | Lot 8 - Infrastructure including Transport                          | WILLIAMSON, DOYLE AND GLOVER  |
      | Lot 9 - Environmental Sustainability and Socio-economic Development | SCHUSTER, LEHNER AND KSHLERIN |

  Scenario Outline: Rates - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View rates' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Rates' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                                                            | supplier_name                 |
      | Lot 1 - Business                                                    | TREMBLAY-MOORE                |
      | Lot 2 - Strategy and Policy                                         | BERNHARD INC                  |
      | Lot 3 - Complex and Transformation                                  | ROMAGUERA INC                 |
      | Lot 4 - Finance                                                     | VEUM-RODRIGUEZ                |
      | Lot 5 - HR                                                          | BOSCO-EBERT                   |
      | Lot 6 - Procurement and Supply Chain                                | VANDERVORT, KOVACEK AND MORAR |
      | Lot 7 - Health, Social Care and Community                           | BATZ, BROWN AND BREITENBERG   |
      | Lot 8 - Infrastructure including Transport                          | WILLIAMSON, DOYLE AND GLOVER  |
      | Lot 9 - Environmental Sustainability and Socio-economic Development | SCHUSTER, LEHNER AND KSHLERIN |
