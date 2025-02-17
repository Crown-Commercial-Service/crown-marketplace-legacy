Feature: Management Consultancy - Suppliers

  Scenario Outline: Check the supplier data
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 10 - Restructuring and insolvency'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 10 - Restructuring and insolvency'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC           |
      | HAMILL, UPTON AND BEER  |
      | JERDE, MOHR AND POLLICH |
      | PURDY-KEMMER            |
      | STROSIN-MEDHURST        |
      | WELCH GROUP             |
    Given I click on '<supplier>'
    Then I am on the '<supplier>' page
    Then the supplier '<sme>' an SME
    And the rate types are 'Complex' and 'Non-Complex'
    And the rates for the 'Analyst / Junior Consultant' are '<rate_1>'
    And the rates for the 'Consultant' are '<rate_2>'
    And the rates for the 'Senior Consultant / Engagement Manager / Project Lead' are '<rate_3>'
    And the rates for the 'Principal Consultant / Associate Director' are '<rate_4>'
    And the rates for the 'Managing Consultant / Director' are '<rate_5>'
    And the rates for the 'Partner' are '<rate_6>'
    And the contact details for the supplier are:
      | <contact_name>    |
      | <contact_email>   |
      | <contact_number>  |
      | <website>         |
      | <address>         |

    Examples:
      | supplier                | sme     | rate_1  | rate_2  | rate_3  | rate_4  | rate_5  | rate_6  | contact_name    | contact_email                             | contact_number  | website                             | address                                                   |
      | HAMILL, UPTON AND BEER  | is not  | £8:£7   | £10:£9  | £12:£11 | £14:£13 | £16:£15 | £18:£17 | Brook Bode      | hamill.and.beer.upton@schowalter.example  | 407-623-3259    | http://zulauf.test/palma_kertzmann  | Suite 494 8395 Cherie Fall, Bulamouth, AL 64927     |
      | JERDE, MOHR AND POLLICH | is not  | £3:£8   | £5:£10  | £7:£12  | £9:£14  | £11:£16 | £13:£18 | Susie Yundt     | jerde_mohr_and_pollich@rosenbaum.example  | 386-051-2664    | http://lemke.example/alfredo        | 11617 Desirae Turnpike, D'Amoremouth, KS 77680-8465 |
      | WELCH GROUP             | is      | £2:£4   | £4:£6   | £6:£8   | £8:£10  | £10:£12 | £12:£14 | Cecille Collier | welch.group@becker.example                | (825) 812-8692  | http://stanton.example/toby         | 95927 Hilpert Locks, West Romeostad, ND 51249-2298  |
