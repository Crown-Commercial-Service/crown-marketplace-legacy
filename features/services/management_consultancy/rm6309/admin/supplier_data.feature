Feature: Management Consultancy - Admin - Supplier data pages

  Background: Navigate to supplier data page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page

  @javascript
  Scenario: Supplier data page
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
      | supplier_name        | duns_number | sme | contact_name   | email                                       | telephone_number | website                               | address                                                |
      | GREENFELDER-LEUSCHKE | 013370637   | Yes | Darwin Block   | greenfelder_leuschke@nader.test             | 4427521029       | http://predovic.example/judith        | Apt. 885 290 Bahringer Highway, Port Martin, GA 58567  |
      | MOSCISKI-CROOKS      | 051874371   | Yes | Elton Leuschke | crooks.mosciski@powlowski-daugherty.example | 870-477-4229     | http://schultz.example/lance.cormier  | 22223 Howell Corners, East Sanfordton, PA 74031-5337   |
      | TURCOTTE GROUP       | 542049362   | No  | Hong Rau       | group_turcotte@effertz.example              | 700-074-9637     | http://buckridge.test/christa_pollich | 58729 Johns Turnpike, New Margaritoland, HI 90422-9071 |

  Scenario: Lot status
    And I click on 'View lot data' for 'GOTTLIEB, HEATHCOTE AND JACOBI'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GOTTLIEB, HEATHCOTE AND JACOBI'
    And I should see the following details in the summary for the lot 'Lot 1 - Business':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2 - Strategy and Policy':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 3 - Complex and Transformation':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 4 - Finance':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 5 - HR':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 6 - Procurement and Supply Chain':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 7 - Health, Social Care and Community':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 8 - Infrastructure':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 9 - Environment and Sustainability':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 10 - Restructuring and insolvency':
      | Lot status | Inactive |
