@javascript
Feature: Supply Teachers - Admin - Supplier data pages

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then I should see the following suppliers on the page:
      | BARTOLETTI, KOEPP AND NIENOW |
      | BOGAN, REICHERT AND COLLIER  |
      | BOYLE, KOEPP AND TURNER      |
      | BRAUN INC                    |
      | CHRISTIANSEN INC             |
      | CORKERY INC                  |
      | DIETRICH-BORER               |
      | EMARD AND SONS               |
      | FEEST-MULLER                 |
      | HAGENES-BECHTELAR            |
      | KERLUKE, TORP AND HEATHCOTE  |
      | LEFFLER AND SONS             |
      | LUETTGEN-GUTMANN             |
      | MCGLYNN GROUP                |
      | MCGLYNN, BAILEY AND NIKOLAUS |
      | O'HARA LLC                   |
      | STANTON, FADEL AND BOSCO     |
      | ZIEMANN-HERMANN              |
    And I enter "ko" for the supplier search
    Then I should see the following suppliers on the page:
      | BARTOLETTI, KOEPP AND NIENOW |
      | BOYLE, KOEPP AND TURNER      |
      | MCGLYNN, BAILEY AND NIKOLAUS |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | BARTOLETTI, KOEPP AND NIENOW |
      | BOGAN, REICHERT AND COLLIER  |
      | BOYLE, KOEPP AND TURNER      |
      | BRAUN INC                    |
      | CHRISTIANSEN INC             |
      | CORKERY INC                  |
      | DIETRICH-BORER               |
      | EMARD AND SONS               |
      | FEEST-MULLER                 |
      | HAGENES-BECHTELAR            |
      | KERLUKE, TORP AND HEATHCOTE  |
      | LEFFLER AND SONS             |
      | LUETTGEN-GUTMANN             |
      | MCGLYNN GROUP                |
      | MCGLYNN, BAILEY AND NIKOLAUS |
      | O'HARA LLC                   |
      | STANTON, FADEL AND BOSCO     |
      | ZIEMANN-HERMANN              |
