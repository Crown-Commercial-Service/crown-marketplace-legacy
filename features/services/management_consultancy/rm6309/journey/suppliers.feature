Feature: Management Consultancy - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 1 - Business'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE  |
      | MOSCISKI-CROOKS       |
      | TURCOTTE GROUP        |

  Scenario Outline: Check the supplier data
    Given I click on '<supplier>'
    Then I am on the '<supplier>' page
    Then the supplier '<sme>' an SME
    And the rate types are 'Advice' and 'Delivery'
    And the rates for the 'Partner / Managing Director' are '<rate_1>'
    And the rates for the 'Managing Consultant / Director' are '<rate_2>'
    And the rates for the 'Principal Consultant / Associate Director' are '<rate_3>'
    And the rates for the 'Senior Consultant / Manager / Project Lead' are '<rate_4>'
    And the rates for the 'Consultant / Senior Analyst' are '<rate_5>'
    And the rates for the 'Analyst / Junior Consultant' are '<rate_6>'
    And the contact details for the supplier are:
      | <contact_name>    |
      | <contact_email>   |
      | <contact_number>  |
      | <website>         |
      | <address>         |

    Examples:
      | supplier              | sme     | rate_1  | rate_2  | rate_3  | rate_4  | rate_5  | rate_6  | contact_name    | contact_email                               | contact_number  | website                               | address                                                 |
      | GREENFELDER-LEUSCHKE  | is      | £13:£19 | £11:£17 | £9:£15  | £7:£13  | £5:£11  | £3:£9   | Darwin Block    | greenfelder_leuschke@nader.test             | 4427521029      | http://predovic.example/judith        | Apt. 885 290 Bahringer Highway, Port Martin, GA 58567   |
      | MOSCISKI-CROOKS       | is      | £14:£12 | £12:£10 | £10:£8  | £8:£6   | £6:£4   | £4:£2   | Elton Leuschke  | crooks.mosciski@powlowski-daugherty.example | 870-477-4229    | http://schultz.example/lance.cormier  | 22223 Howell Corners, East Sanfordton, PA 74031-5337    |
      | TURCOTTE GROUP        | is not  | £12:£15 | £10:£13 | £8:£11  | £6:£9   | £4:£7   | £2:£5   | Hong Rau        | group_turcotte@effertz.example              | 700-074-9637    | http://buckridge.test/christa_pollich | 58729 Johns Turnpike, New Margaritoland, HI 90422-9071  |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'shortlist_of_management_consultancy_suppliers' is downloaded
