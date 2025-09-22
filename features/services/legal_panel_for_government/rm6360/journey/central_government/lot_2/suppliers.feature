Feature: Legal Panel for Government - Non central governemnt - Lot 2 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Major Projects and Complex Advice'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Major Projects and Complex Advice'
    When I check the following items:
      | Competition Law |
      | Contracts       |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://schoen.test/horacio              |
      | BALISTRERI-MURAZIK       | http://dubuque.test/soo_lockman         |
      | CORMIER INC              | http://mayer-willms.test/daphine        |
      | MONAHAN-JOHNS            | http://runolfsson.example/darrel.heaney |

  Scenario: Check the supplier data - SME
    Given I click on 'ADAMS, WOLFF AND STROMAN'
    Then I am on the 'ADAMS, WOLFF AND STROMAN' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£280.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£245.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£210.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£175.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£140.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£84.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£70.00'
    And the contact details for the supplier are:
      | wolff.stroman.adams.and@quigley.example           |
      | 3200482267                                        |
      | http://fritsch.test/jeana.sipes                   |
      | Apt. 349 9138 Kuhn Inlet, Luettgenville, AL 16718 |
    And the prospectus link is 'http://schoen.test/horacio'

  Scenario: Check the supplier data - Non SME
    Given I click on 'BALISTRERI-MURAZIK'
    Then I am on the 'BALISTRERI-MURAZIK' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£240.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£180.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£120.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£72.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And the contact details for the supplier are:
      | balistreri.murazik@labadie.example       |
      | 857-873-6226                             |
      | http://moen.example/darryl.bogan         |
      | 92992 Wolff Mount, North Drema, AR 96486 |
    And the prospectus link is 'http://dubuque.test/soo_lockman'

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded
