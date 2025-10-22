Feature: Legal Panel for Government - Admin - View supplier data pages

  Background: Navigate to supplier data page
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page

  @javascript
  Scenario: Supplier data page
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

  Scenario Outline: Supplier details page
    And I click on 'View details' for '<supplier_name>'
    Then I am on the 'Supplier details' page
    And the caption is '<supplier_name>'
    And I should see the following details in the 'Supplier information' summary:
      | Name        | <supplier_name> |
      | DUNS Number | <duns_number>   |
      | Is an SME?  | <sme>           |
    And I should see the following details in the 'Contact information' summary:
      | Contact email            | <email>            |
      | Contact telephone number | <telephone_number> |
      | Website                  | <website>          |
    And I should see the following details in the 'Additional information' summary:
      | Address                | <address>                |
      | Lot 1 prospectus link  | <lot_1_prospectus_link>  |
      | Lot 2 prospectus link  | <lot_2_prospectus_link>  |
      | Lot 3 prospectus link  | <lot_3_prospectus_link>  |
      | Lot 4a prospectus link | <lot_4a_prospectus_link> |
      | Lot 4b prospectus link | <lot_4b_prospectus_link> |
      | Lot 4c prospectus link | <lot_4c_prospectus_link> |
      | Lot 5 prospectus link  | <lot_5_prospectus_link>  |

    Examples:
      | supplier_name    | duns_number | sme | email                               | telephone_number | website                              | address                                              | lot_1_prospectus_link               | lot_2_prospectus_link                      | lot_3_prospectus_link                    | lot_4a_prospectus_link                    | lot_4b_prospectus_link             | lot_4c_prospectus_link              | lot_5_prospectus_link                  |
      | CORMIER INC      | 650210078   | No  | cormier.inc@jerde.example           | 767-310-7249     | http://hahn.example/marybelle_cronin | 1830 Marisha Crest, Bayermouth, OK 02096-6821        | http://block.test/blossom.gulgowski | http://mayer-willms.test/daphine           | http://mosciski.test/augustine           | http://gerlach-kohler.test/ria_nitzsche   | http://jenkins-waelchi.test/wava   | http://corkery.example/jospeh_kunze | http://oconnell.test/maranda           |
      | GOYETTE AND SONS | 223625107   | No  | goyette.and.sons@weimann-berge.test | 07765 851010     | http://bednar-metz.test/mei          | 653 Magan Common, Wardport, MO 16271-8890            | http://krajcik.example/tisa_kilback | http://carroll-brown.test/krystyna.okuneva | http://halvorson.example/nelda.jacobson  | http://mayer-greenholt.example/chuck_veum | http://murray.example/rich         | http://labadie.example/adrianne     | http://langosh.test/ursula             |
      | SANFORD INC      | 674282134   | Yes | sanford.inc@hartmann.test           | 728-370-0504     | http://zemlak.example/evonne_treutel | Suite 830 5709 Simonis Valley, Lake Vernie, UT 13705 | http://wintheiser.test/thad         | http://wolf.test/delmer.graham             | http://bauch.example/maurine_heidenreich | http://schmitt.test/dudley                | http://murazik-bechtelar.test/neda | http://sanford.test/asa             | http://block-stokes.test/ellen_ruecker |

  Scenario: Lot status
    And I click on 'View lot data' for 'ADAMS, WOLFF AND STROMAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'ADAMS, WOLFF AND STROMAN'
    And I should see the following details in the summary for the lot 'Lot 1 - Core Legal Services':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2 - Major Projects and Complex Advice':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 3 - Finance and High Risk/Innovation':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 4a - Trade and Investment Negotiations':
      | Lot status    | Active             |
      | Services      | View services      |
      | Rates         | View rates         |
      | Jurisdictions | View jurisdictions |
    And I should see the following details in the summary for the lot 'Lot 4b - International Trade Disputes':
      | Lot status    | Active             |
      | Services      | View services      |
      | Rates         | View rates         |
      | Jurisdictions | View jurisdictions |
    And I should see the following details in the summary for the lot 'Lot 4c - International Investment Disputes':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 5 - Rail Legal Services':
      | Lot status | Inactive |
