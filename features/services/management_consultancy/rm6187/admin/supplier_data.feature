Feature: Management Consultancy - Admin - Supplier data pages

  Background: Navigate to supplier data page
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page

  @javascript
  Scenario: Supplier data page
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

  Scenario Outline: Supplier details page
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

  Scenario: Lot status
    And I click on 'View lot data' for 'BATZ, BROWN AND BREITENBERG'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BATZ, BROWN AND BREITENBERG'
    And I should see the following details in the summary for the lot 'Lot 1 - Business':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 2 - Strategy and Policy':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 3 - Complex and Transformation':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 4 - Finance':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 5 - HR':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 6 - Procurement and Supply Chain':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 7 - Health, Social Care and Community':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 8 - Infrastructure including Transport':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 9 - Environmental Sustainability and Socio-economic Development':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
