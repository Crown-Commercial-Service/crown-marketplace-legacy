@pipeline
Feature: Legal services -  Central governemnt - Lot 1 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Full service provision'
    Given I check 'Information Technology'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 1 - Full service provision'
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | HALEY-FAY                   |
      | LEDNER, BAILEY AND WEISSNAT |
      | MERTZ-HOMENICK              |

  Scenario: Check the supplier data - SME
    Given I click on 'HALEY-FAY'
    Then I am on the 'HALEY-FAY' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£180.00'
    And the 'Solicitor, Associate' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£120.00'
    And the 'Trainee' hourly rate is '£90.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And there is no LMP (Legal project manager) hourly rate
    And the contact details for the supplier are:
      | fay.haley@walsh.name                              |
      | 1-558-665-2572                                    |
      | http://mcdermott.io/allyn                         |
      | 544 Deckow Throughway, Port Dellashire, VA 82640  |

  Scenario: Check the supplier data - Non SME
    Given I click on 'MERTZ-HOMENICK'
    Then I am on the 'MERTZ-HOMENICK' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£150.00'
    And the 'Solicitor, Associate' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£100.00'
    And the 'Trainee' hourly rate is '£75.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the 'LMP (Legal project manager)' hourly rate is '£137.50'
    And the contact details for the supplier are:
      | homenick.mertz@feest-hamill.com             |
      | 245.023.1441 x39360                         |
      | http://osinski.co/francisca.bartoletti      |
      | 972 Malcolm Estates, Gottliebside, AZ 82310 |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded