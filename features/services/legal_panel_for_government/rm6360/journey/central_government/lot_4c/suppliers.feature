Feature: Legal Panel for Government - Non central governemnt - Lot 4c - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4c - International Investment Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | International arbitral awards           |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | JOHNSON-ROMAGUERA       | http://sanford.example/lilly_bosco      |
      | VEUM, TORPHY AND NOLAN  | http://gislason.example/madeline.miller |
      | ZIEME-LEANNON           | http://terry.example/clementine.kozey   |

  Scenario: Check the supplier data - SME
    Given I click on 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'VEUM, TORPHY AND NOLAN' page
    Then the supplier 'is' an SME
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
      | and_torphy_veum_nolan@brakus-treutel.test |
      | 567-179-1230                              |
      | http://corwin-toy.test/june.rodriguez     |
      | 460 O'Reilly Centers, Greenview, OH 10209 |
    And the prospectus link is 'http://gislason.example/madeline.miller'

  Scenario: Check the supplier data - Non SME
    Given I click on 'JOHNSON-ROMAGUERA'
    Then I am on the 'JOHNSON-ROMAGUERA' page
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
      | romaguera.johnson@koch.example                        |
      | (782) 133 3631                                        |
      | http://dach-pfannerstill.test/carmelita               |
      | Suite 904 791 Cole Field, Port Sherril, CO 24348-8363 |
    And the prospectus link is 'http://sanford.example/lilly_bosco'

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded