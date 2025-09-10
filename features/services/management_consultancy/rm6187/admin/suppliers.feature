@javascript
Feature: Management Consultancy - Admin - Supplier data pages

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then I should see the following suppliers on the page:
      | BATZ, BROWN AND BREITENBERG   |
      | BERNHARD INC                  |
      | BOSCO-EBERT                   |
      | O'REILLY, ZULAUF AND BEATTY   |
      | ROMAGUERA INC                 |
      | SCHUSTER, LEHNER AND KSHLERIN |
      | TREMBLAY-MOORE                |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |
    And I enter "rt" for the supplier search
    Then I should see the following suppliers on the page:
      | BOSCO-EBERT                   |
      | VANDERVORT, KOVACEK AND MORAR |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | BATZ, BROWN AND BREITENBERG   |
      | BERNHARD INC                  |
      | BOSCO-EBERT                   |
      | O'REILLY, ZULAUF AND BEATTY   |
      | ROMAGUERA INC                 |
      | SCHUSTER, LEHNER AND KSHLERIN |
      | TREMBLAY-MOORE                |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |
