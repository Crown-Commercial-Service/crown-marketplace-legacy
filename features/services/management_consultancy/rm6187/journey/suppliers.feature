Feature: Management Consultancy - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 1 - Business'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | BATZ, BROWN AND BREITENBERG   |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario Outline: Check the supplier data
    Given I click on '<supplier>'
    Then I am on the '<supplier>' page
    Then the supplier '<sme>' an SME
    And the rate for the 'Analyst / Junior Consultant' is '<rate_1>'
    And the rate for the 'Consultant' is '<rate_2>'
    And the rate for the 'Senior Consultant / Engagement Manager / Project Lead' is '<rate_3>'
    And the rate for the 'Principal Consultant / Associate Director' is '<rate_4>'
    And the rate for the 'Managing Consultant / Director' is '<rate_5>'
    And the rate for the 'Partner' is '<rate_6>'
    And the contact details for the supplier are:
      | <contact_name>    |
      | <contact_email>   |
      | <contact_number>  |
      | <website>         |
      | <address>         |

    Examples:
      | supplier                      | sme     | rate_1  | rate_2  | rate_3  | rate_4  | rate_5  | rate_6  | contact_name        | contact_email                                   | contact_number      | website                               | address                                                       |
      | BATZ, BROWN AND BREITENBERG   | is      | £9      | £11     | £13     | £15     | £17     | £19     | Lorelei Parker DDS  | batz.brown.and.breitenberg@williamson-emard.io  | 402.108.0190 x08147 | http://considine.biz/evonne           | Suite 973 3708 Leonard Place, Mingview, SC 99734              |
      | VANDERVORT, KOVACEK AND MORAR | is not  | £3      | £5      | £7      | £9      | £11     | £13     | Judson Sauer        | morar_kovacek_vandervort_and@farrell-grady.org  | 337.949.3012 x62512 | http://jerde.org/vallie_bergstrom     | 6632 Rodolfo Highway, Port Caryton, IA 90303-6001             |
      | VEUM-RODRIGUEZ                | is not  | £6      | £8      | £10     | £12     | £14     | £16     | Rev. Holly Tillman  | rodriguez.veum@bartell.co                       | 645.157.0910        | http://grimes.name/dixie_fay          | Suite 747 62477 Tillman Plaza, Lake Carsonside, UT 21441-2938 |
      | WILLIAMSON, DOYLE AND GLOVER  | is      | £5      | £7      | £9      | £11     | £13     | £15     | Nathanial Carter    | glover.williamson.and.doyle@lind.biz            | 563-160-3456 x526   | http://shanahan-labadie.info/jeremiah | Apt. 802 53662 Friesen Creek, Louishaven, MS 08488-5259       |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'shortlist_of_management_consultancy_suppliers' is downloaded
