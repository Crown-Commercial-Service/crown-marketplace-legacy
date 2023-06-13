Feature: Legal services - Non central governemnt - Lot 1 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Full service provision'
    When I check the following items:
      | Children and Vulnerable Adults  |
      | Corporate Law                   |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 1 - Full service provision'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | LEDNER, BAILEY AND WEISSNAT |
      | WILLIAMSON-BERGSTROM        |
      | ZIEME GROUP                 |

  Scenario: Check the supplier data - SME
    Given I click on 'ZIEME GROUP'
    Then I am on the 'ZIEME GROUP' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£245.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£210.00'
    And the 'Solicitor, Associate' hourly rate is '£175.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£140.00'
    And the 'Trainee' hourly rate is '£105.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£70.00'
    And the 'LMP (Legal project manager)' hourly rate is '£192.50'
    And the contact details for the supplier are:
      | group.zieme@gerlach.io                        |
      | 1-202-833-7874                                |
      | http://mills.co/korey                         |
      | 93083 Beahan Locks, DuBuqueton, NJ 66613-2026 |

  Scenario: Check the supplier data - Non SME
    Given I click on 'DUBUQUE-PADBERG'
    Then I am on the 'DUBUQUE-PADBERG' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£150.00'
    And the 'Solicitor, Associate' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£100.00'
    And the 'Trainee' hourly rate is '£75.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the 'LMP (Legal project manager)' hourly rate is '£165.00'
    And the contact details for the supplier are:
      | dubuque_padberg@kerluke-cole.name           |
      | 144.165.4586                                |
      | http://miller-gulgowski.net/luise           |
      | 502 Edward Row, Dorethahaven, NC 19736-7968 |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded