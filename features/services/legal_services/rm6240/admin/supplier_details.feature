Feature: Legal services - Admin - Supplier details

  Scenario Outline: Supplier details page
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
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
      | Address               | <address>               |
      | Lot 1 prospectus link | <lot_1_prospectus_link> |
      | Lot 2 prospectus link | <lot_2_prospectus_link> |
      | Lot 3 prospectus link | <lot_3_prospectus_link> |

    Examples:
      | supplier_name  | duns_number | sme | email                           | telephone_number      | website                                | address                                            | lot_1_prospectus_link                   | lot_2_prospectus_link                   | lot_3_prospectus_link                   |
      | HALEY-FAY      | 634050459   | Yes | fay.haley@walsh.name            | 1-558-665-2572        | http://mcdermott.io/allyn              | 544 Deckow Throughway, Port Dellashire, VA 82640   | N/A                                     | N/A                                     | N/A                                     |
      | MERTZ-HOMENICK | 784539181   | No  | homenick.mertz@feest-hamill.com | 245.023.1441 x39360   | http://osinski.co/francisca.bartoletti | 972 Malcolm Estates, Gottliebside, AZ 82310        | N/A                                     | N/A                                     | N/A                                     |
      | ZEMLAK INC     | 706599728   | Yes | zemlak.inc@abernathy-casper.biz | 1-501-237-7406 x63645 | http://christiansen-mann.name/ali      | Apt. 416 316 Otto Village, West Herlinda, AK 59333 | http://christiansen-mann.name/ali/lot-1 | http://christiansen-mann.name/ali/lot-2 | http://christiansen-mann.name/ali/lot-3 |
