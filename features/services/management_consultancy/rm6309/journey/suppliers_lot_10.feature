Feature: Management Consultancy - Suppliers - Lot 10

  Scenario Outline: Check the supplier data
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 10 - Restructuring and insolvency'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 10 - Restructuring and insolvency'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE  |
      | KOHLER-STOKES         |
      | MOSCISKI-CROOKS       |
      | TURCOTTE GROUP        |
    Given I click on '<supplier>'
    Then I am on the '<supplier>' page
    Then the supplier '<sme>' an SME
    And the rate types are 'Complex' and 'Non-Complex'
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
      | GREENFELDER-LEUSCHKE  | is      | £13:£13 | £11:£11 | £9:£9   | £7:£7   | £5:£5   | £3:£3   | Darwin Block    | greenfelder_leuschke@nader.test             | 4427521029      | http://predovic.example/judith        | Apt. 885 290 Bahringer Highway, Port Martin, GA 58567   |
      | MOSCISKI-CROOKS       | is      | £18:£14 | £16:£12 | £14:£10 | £12:£8  | £10:£6  | £8:£4   | Elton Leuschke  | crooks.mosciski@powlowski-daugherty.example | 870-477-4229    | http://schultz.example/lance.cormier  | 22223 Howell Corners, East Sanfordton, PA 74031-5337    |
      | TURCOTTE GROUP        | is not  | £14:£12 | £12:£10 | £10:£8  | £8:£6   | £6:£4   | £4:£2   | Hong Rau        | group_turcotte@effertz.example              | 700-074-9637    | http://buckridge.test/christa_pollich | 58729 Johns Turnpike, New Margaritoland, HI 90422-9071  |
