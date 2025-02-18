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
      | GREENHOLT INC     |
      | PURDY-KEMMER      |
      | STROSIN-MEDHURST  |

  Scenario Outline: Check the supplier data
    Given I click on '<supplier>'
    Then I am on the '<supplier>' page
    Then the supplier '<sme>' an SME
    And the rate types are 'Advice' and 'Delivery'
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
      | supplier          | sme     | rate_1  | rate_2  | rate_3  | rate_4  | rate_5  | rate_6  | contact_name        | contact_email                           | contact_number  | website                                 | address                                                   |
      | GREENHOLT INC     | is      | £8:£9   | £10:£11 | £12:£13 | £14:£15 | £16:£17 | £18:£19 | Cleveland Ullrich   | greenholt_inc@purdy-zulauf.example      | 9929911947      | http://jaskolski.example/gabriella.orn  | Apt. 387 374 Lindgren Club, New Mark, SC 07301            |
      | PURDY-KEMMER      | is      | £9:£2   | £11:£4  | £13:£6  | £15:£8  | £17:£10 | £19:£12 | Alfred Rempel       | kemmer_purdy@mayert.example             | (419) 570-3046  | http://ziemann-fay.example/humberto     | 798 Lyla Shores, Frankieburgh, ME 23140-5916              |
      | STROSIN-MEDHURST  | is not  | £7:£2   | £9:£4   | £11:£6  | £13:£8  | £15:£10 | £17:£12 | Ms. Agustin Senger  | medhurst.strosin@kulas-schuppe.example  | 403-620-2250    | http://upton.test/maxie                 | Suite 271 2241 Dibbert Inlet, New Willetta, NC 00719-8282 |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'shortlist_of_management_consultancy_suppliers' is downloaded
