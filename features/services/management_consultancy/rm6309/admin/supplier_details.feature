Feature: Management Consultancy - Admin - Supplier details

  Scenario Outline: Supplier details page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
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
      | supplier_name        | duns_number | sme | contact_name   | email                                       | telephone_number | website                               | address                                                |
      | GREENFELDER-LEUSCHKE | 013370637   | Yes | Darwin Block   | greenfelder_leuschke@nader.test             | 4427521029       | http://predovic.example/judith        | Apt. 885 290 Bahringer Highway, Port Martin, GA 58567  |
      | MOSCISKI-CROOKS      | 051874371   | Yes | Elton Leuschke | crooks.mosciski@powlowski-daugherty.example | 870-477-4229     | http://schultz.example/lance.cormier  | 22223 Howell Corners, East Sanfordton, PA 74031-5337   |
      | TURCOTTE GROUP       | 542049362   | No  | Hong Rau       | group_turcotte@effertz.example              | 700-074-9637     | http://buckridge.test/christa_pollich | 58729 Johns Turnpike, New Margaritoland, HI 90422-9071 |
