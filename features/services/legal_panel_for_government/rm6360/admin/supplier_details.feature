Feature: Legal Panel for Government - Admin - Supplier details

  Scenario Outline: Supplier details page
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
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
      | GOYETTE AND SONS | 223625107   | No  | goyette.and.sons@weimann-berge.test | 776-585-1010     | http://bednar-metz.test/mei          | 653 Magan Common, Wardport, MO 16271-8890            | http://krajcik.example/tisa_kilback | http://carroll-brown.test/krystyna.okuneva | http://halvorson.example/nelda.jacobson  | http://mayer-greenholt.example/chuck_veum | http://murray.example/rich         | http://labadie.example/adrianne     | http://langosh.test/ursula             |
      | SANFORD INC      | 674282134   | Yes | sanford.inc@hartmann.test           | 728-370-0504     | http://zemlak.example/evonne_treutel | Suite 830 5709 Simonis Valley, Lake Vernie, UT 13705 | http://wintheiser.test/thad         | http://wolf.test/delmer.graham             | http://bauch.example/maurine_heidenreich | http://schmitt.test/dudley                | http://murazik-bechtelar.test/neda | http://sanford.test/asa             | http://block-stokes.test/ellen_ruecker |
