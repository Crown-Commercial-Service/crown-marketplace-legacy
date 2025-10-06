Feature: Legal Panel for Government - Non central governemnt - Lot 4a - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Assimilated Law                         |
      | Domestic law of jurisdictions for trade |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad |
      | CROOKS AND SONS          | http://von.example/mireille          |
      | O'CONNER AND SONS        | http://hudson.example/curtis         |

  Scenario: Check the supplier data - SME
    Given I click on "O'CONNER AND SONS"
    Then I am on the "O'CONNER AND SONS" page
    Then the supplier 'is' an SME
    And the 'Senior Counsel, Senior Partner (20 years +PQE)' hourly rate is '£315.00'
    And the 'Partner' hourly rate is '£280.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£245.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£210.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£175.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£140.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£84.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£70.00'
    And the 'Senior Analyst' hourly rate is '£175.00'
    And the 'Analyst, Associate Analyst, Research Associate, Research Officer' hourly rate is '£140.00'
    And the 'Senior Modeller, Senior Econometrician, Senior Analyst' hourly rate is '£210.00'
    And the 'Modeller, Econometrician, Analyst, Associate Analyst' hourly rate is '£175.00'
    And the contact details for the supplier are:
      | oconner.and.sons@purdy-lesch.test                 |
      | 861-520-9632                                      |
      | http://wilderman.example/gaston.spinka            |
      | 71861 Rogahn Mount, West Jacquesborough, OK 27166 |
    And the prospectus link is 'http://hudson.example/curtis'

  Scenario: Check the supplier data - Non SME
    Given I click on 'CROOKS AND SONS'
    Then I am on the 'CROOKS AND SONS' page
    Then the supplier 'is not' an SME
    And the 'Senior Counsel, Senior Partner (20 years +PQE)' hourly rate is '£270.00'
    And the 'Partner' hourly rate is '£240.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£180.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£120.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£72.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And the 'Senior Analyst' hourly rate is '£150.00'
    And the 'Analyst, Associate Analyst, Research Associate, Research Officer' hourly rate is '£120.00'
    And the 'Senior Modeller, Senior Econometrician, Senior Analyst' hourly rate is '£180.00'
    And the 'Modeller, Econometrician, Analyst, Associate Analyst' hourly rate is '£150.00'
    And the contact details for the supplier are:
      | and.crooks.sons@gulgowski.test                |
      | 567 975 0867                                  |
      | http://haag.example/adaline                   |
      | 51073 Osinski Pines, North Lyletown, TX 24340 |
    And the prospectus link is 'http://von.example/mireille'

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded
