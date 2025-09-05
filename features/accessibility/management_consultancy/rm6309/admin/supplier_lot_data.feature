@accessibility @javascript
Feature: Management Consultancy - Admin - Supplier lot data - Lot data - Accessibility

  Background: Navigate to supplier data
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page

  Scenario: Lot status
    And I click on 'View lot data' for 'GOTTLIEB, HEATHCOTE AND JACOBI'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GOTTLIEB, HEATHCOTE AND JACOBI'
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
      | lot_name                                  | supplier_name                  |
      | Lot 1 - Business                          | NIENOW-KERTZMANN               |
      | Lot 2 - Strategy and Policy               | MOSCISKI-CROOKS                |
      | Lot 3 - Complex and Transformation        | GREENFELDER-LEUSCHKE           |
      | Lot 4 - Finance                           | KOHLER-STOKES                  |
      | Lot 5 - HR                                | SCHINNER-LAKIN                 |
      | Lot 6 - Procurement and Supply Chain      | SCHUMM, GRANT AND SPORER       |
      | Lot 7 - Health, Social Care and Community | STROMAN-ROMAGUERA              |
      | Lot 8 - Infrastructure                    | GOTTLIEB, HEATHCOTE AND JACOBI |
      | Lot 9 - Environment and Sustainability    | GUTMANN-PFEFFER                |
      | Lot 10 - Restructuring and insolvency     | GUTMANN-PFEFFER                |

  Scenario Outline: Rates - <lot_name>
    And I click on 'View lot data' for '<supplier_name>'
    Then I am on the 'Supplier lot data' page
    And the caption is '<supplier_name>'
    And I click on 'View rates' for the lot '<lot_name>'
    Then I am on the '<lot_name> - Rates' page
    And the caption is '<supplier_name>'
    Then the page should pass the accessibility checks

    Examples:
      | lot_name                                  | supplier_name                  |
      | Lot 1 - Business                          | NIENOW-KERTZMANN               |
      | Lot 2 - Strategy and Policy               | MOSCISKI-CROOKS                |
      | Lot 3 - Complex and Transformation        | GREENFELDER-LEUSCHKE           |
      | Lot 4 - Finance                           | KOHLER-STOKES                  |
      | Lot 5 - HR                                | SCHINNER-LAKIN                 |
      | Lot 6 - Procurement and Supply Chain      | SCHUMM, GRANT AND SPORER       |
      | Lot 7 - Health, Social Care and Community | STROMAN-ROMAGUERA              |
      | Lot 8 - Infrastructure                    | GOTTLIEB, HEATHCOTE AND JACOBI |
      | Lot 9 - Environment and Sustainability    | GUTMANN-PFEFFER                |
      | Lot 10 - Restructuring and insolvency     | GUTMANN-PFEFFER                |
