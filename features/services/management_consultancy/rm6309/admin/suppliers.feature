@javascript
Feature: Management Consultancy - Admin - Supplier data pages

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then I should see the following suppliers on the page:
      | GOTTLIEB, HEATHCOTE AND JACOBI |
      | GREENFELDER-LEUSCHKE           |
      | GUTMANN-PFEFFER                |
      | KOHLER-STOKES                  |
      | MOSCISKI-CROOKS                |
      | NIENOW-KERTZMANN               |
      | SCHINNER-LAKIN                 |
      | SCHUMM, GRANT AND SPORER       |
      | STROMAN-ROMAGUERA              |
      | TURCOTTE GROUP                 |
    And I enter "en" for the supplier search
    Then I should see the following suppliers on the page:
      | GREENFELDER-LEUSCHKE |
      | NIENOW-KERTZMANN     |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | GOTTLIEB, HEATHCOTE AND JACOBI |
      | GREENFELDER-LEUSCHKE           |
      | GUTMANN-PFEFFER                |
      | KOHLER-STOKES                  |
      | MOSCISKI-CROOKS                |
      | NIENOW-KERTZMANN               |
      | SCHINNER-LAKIN                 |
      | SCHUMM, GRANT AND SPORER       |
      | STROMAN-ROMAGUERA              |
      | TURCOTTE GROUP                 |
