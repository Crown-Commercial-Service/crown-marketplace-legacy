@javascript
Feature: Legal Panel for Government - Admin - Supplier data pages

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then I should see the following suppliers on the page:
      | ADAMS, WOLFF AND STROMAN         |
      | BALISTRERI-MURAZIK               |
      | BROWN-BEIER                      |
      | CORMIER INC                      |
      | CROOKS AND SONS                  |
      | DICKI, QUITZON AND KUB           |
      | ERDMAN INC                       |
      | GOYETTE AND SONS                 |
      | GREEN, YOST AND MCCLURE          |
      | HAUCK LLC                        |
      | JAKUBOWSKI-SATTERFIELD           |
      | JOHNSON-ROMAGUERA                |
      | KOELPIN, HILLL AND COLLINS       |
      | LOCKMAN, NITZSCHE AND BARTELL    |
      | MONAHAN-JOHNS                    |
      | O'CONNER AND SONS                |
      | SANFORD AND SONS                 |
      | SANFORD INC                      |
      | STANTON-GOYETTE                  |
      | STEUBER, BERNIER AND SATTERFIELD |
      | TILLMAN, LUBOWITZ AND GOYETTE    |
      | VEUM, TORPHY AND NOLAN           |
      | WALKER-LEUSCHKE                  |
      | ZIEME-LEANNON                    |
    And I enter "ha" for the supplier search
    Then I should see the following suppliers on the page:
      | HAUCK LLC     |
      | MONAHAN-JOHNS |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | ADAMS, WOLFF AND STROMAN         |
      | BALISTRERI-MURAZIK               |
      | BROWN-BEIER                      |
      | CORMIER INC                      |
      | CROOKS AND SONS                  |
      | DICKI, QUITZON AND KUB           |
      | ERDMAN INC                       |
      | GOYETTE AND SONS                 |
      | GREEN, YOST AND MCCLURE          |
      | HAUCK LLC                        |
      | JAKUBOWSKI-SATTERFIELD           |
      | JOHNSON-ROMAGUERA                |
      | KOELPIN, HILLL AND COLLINS       |
      | LOCKMAN, NITZSCHE AND BARTELL    |
      | MONAHAN-JOHNS                    |
      | O'CONNER AND SONS                |
      | SANFORD AND SONS                 |
      | SANFORD INC                      |
      | STANTON-GOYETTE                  |
      | STEUBER, BERNIER AND SATTERFIELD |
      | TILLMAN, LUBOWITZ AND GOYETTE    |
      | VEUM, TORPHY AND NOLAN           |
      | WALKER-LEUSCHKE                  |
      | ZIEME-LEANNON                    |
