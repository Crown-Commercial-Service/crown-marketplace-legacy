Feature: Management Consultancy - Admin - Supplier details

  Scenario Outline: Supplier details page
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
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
      | Contact name             | <contact_name>     |
      | Contact email            | <email>            |
      | Contact telephone number | <telephone_number> |
      | Website                  | <website>          |
    And I should see the following details in the 'Additional information' summary:
      | Address | <address> |

    Examples:
      | supplier_name                 | duns_number | sme | contact_name     | email                                          | telephone_number    | website                               | address                                           |
      | BERNHARD INC                  | 614904125   | No  | Rev. Dave Kemmer | bernhard.inc@harris-dietrich.info              | 117.153.6094        | http://homenick.info/walter           | 65238 Davis Shores, Ikeshire, KS 98575-1023       |
      | ROMAGUERA INC                 | 587892530   | Yes | Astrid Hickle DC | romaguera.inc@feeney.biz                       | 1-321-071-7291      | http://schimmel-yundt.name/jan.heller | 170 Carmelo Meadow, New Susieside, UT 28036       |
      | VANDERVORT, KOVACEK AND MORAR | 271939704   | No  | Judson Sauer     | morar_kovacek_vandervort_and@farrell-grady.org | 337.949.3012 x62512 | http://jerde.org/vallie_bergstrom     | 6632 Rodolfo Highway, Port Caryton, IA 90303-6001 |
