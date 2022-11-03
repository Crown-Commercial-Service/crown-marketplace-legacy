@pipeline
Feature: Legal services -  Central governemnt - Lot 2 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'
    Given I check 'Employment'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - General service provision'
    And I select 'Northern Ireland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | COLLINS, COLE AND PACOCHA   |
      | TREUTEL, GERLACH AND SPORER |
      | WEHNER, STEHR AND KULAS     |

  Scenario: Check the supplier data - SME
    Given I click on 'WEHNER, STEHR AND KULAS'
    Then I am on the 'WEHNER, STEHR AND KULAS ' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£150.00'
    And the 'Solicitor, Associate' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£100.00'
    And the 'Trainee' hourly rate is '£75.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the 'LMP (Legal project manager)' hourly rate is '£165.00'
    And the contact details for the supplier are:
      | stehr.wehner.kulas.and@crona.net          |
      | 1-118-604-7899 x39161                     |
      | http://cruickshank-blick.info/artie       |
      | 59473 Carolina Shores, New Omar, NH 89661 |

  Scenario: Check the supplier data - Non SME
    Given I click on 'TREUTEL, GERLACH AND SPORER'
    Then I am on the 'TREUTEL, GERLACH AND SPORER' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£180.00'
    And the 'Solicitor, Associate' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£120.00'
    And the 'Trainee' hourly rate is '£90.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And there is no LMP (Legal project manager) hourly rate
    And the contact details for the supplier are:
      | and_gerlach_sporer_treutel@osinski.org            |
      | (428) 979-0794 x788                               |
      | http://trantow.co/noble                           |
      | Suite 888 41223 Scot Harbors, North Jay, IA 43449 |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
