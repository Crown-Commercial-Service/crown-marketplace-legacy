@javascript
Feature: Legal services - Admin - Supplier data pages

  Scenario: Supplier data page
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    Then I should see the following suppliers on the page:
      | COLLINS, COLE AND PACOCHA        |
      | DUBUQUE-PADBERG                  |
      | GUSIKOWSKI, BOSCO AND CRIST      |
      | HALEY-FAY                        |
      | JACOBSON-NIENOW                  |
      | LEDNER, BAILEY AND WEISSNAT      |
      | LUETTGEN LLC                     |
      | MCLAUGHLIN, RATKE AND KONOPELSKI |
      | MERTZ-HOMENICK                   |
      | TREUTEL, GERLACH AND SPORER      |
      | WEHNER, STEHR AND KULAS          |
      | WILLIAMSON-BERGSTROM             |
      | WITTING-OLSON                    |
      | ZEMLAK INC                       |
      | ZIEME GROUP                      |
    And I enter "la" for the supplier search
    Then I should see the following suppliers on the page:
      | MCLAUGHLIN, RATKE AND KONOPELSKI |
      | TREUTEL, GERLACH AND SPORER      |
      | WEHNER, STEHR AND KULAS          |
      | ZEMLAK INC                       |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | COLLINS, COLE AND PACOCHA        |
      | DUBUQUE-PADBERG                  |
      | GUSIKOWSKI, BOSCO AND CRIST      |
      | HALEY-FAY                        |
      | JACOBSON-NIENOW                  |
      | LEDNER, BAILEY AND WEISSNAT      |
      | LUETTGEN LLC                     |
      | MCLAUGHLIN, RATKE AND KONOPELSKI |
      | MERTZ-HOMENICK                   |
      | TREUTEL, GERLACH AND SPORER      |
      | WEHNER, STEHR AND KULAS          |
      | WILLIAMSON-BERGSTROM             |
      | WITTING-OLSON                    |
      | ZEMLAK INC                       |
      | ZIEME GROUP                      |
