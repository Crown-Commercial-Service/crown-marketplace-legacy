Feature: Legal services - Non central governemnt - Lot 3 - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Transport rail legal services'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is 'Lot 3 - Transport rail legal services'
    And I should see that '8' suppliers can provide legal services
    And the selected legal service suppliers are:
      | GUSIKOWSKI, BOSCO AND CRIST      |
      | JACOBSON-NIENOW                  |
      | LUETTGEN LLC                     |
      | MCLAUGHLIN, RATKE AND KONOPELSKI |
      | WEHNER, STEHR AND KULAS          |
      | WITTING-OLSON                    |
      | ZEMLAK INC                       |
      | ZIEME GROUP                      |

  Scenario: Check the supplier data - SME
    Given I click on 'WITTING-OLSON'
    Then I am on the 'WITTING-OLSON' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£245.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£210.00'
    And the 'Solicitor, Associate' hourly rate is '£175.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£140.00'
    And the 'Trainee' hourly rate is '£105.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£70.00'
    And the 'LMP (Legal project manager)' hourly rate is '£192.50'
    And the contact details for the supplier are:
      | witting.olson@buckridge.name                    |
      | 1-249-089-2797 x3771                            |
      | http://cremin.org/drema                         |
      | 815 Terrell Rest, New Hattiefurt, WV 89027-7230 |

  Scenario: Check the supplier data - Non SME
    Given I click on 'JACOBSON-NIENOW'
    Then I am on the 'JACOBSON-NIENOW' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£150.00'
    And the 'Solicitor, Associate' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£100.00'
    And the 'Trainee' hourly rate is '£75.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the 'LMP (Legal project manager)' hourly rate is '£165.00'
    And the contact details for the supplier are:
      | nienow.jacobson@mosciski.com            |
      | 1-748-527-1159 x93482                   |
      | http://schmeler-denesik.org/ty.nikolaus |
      | 835 Alberto View, Schultzport, TN 02232 |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
