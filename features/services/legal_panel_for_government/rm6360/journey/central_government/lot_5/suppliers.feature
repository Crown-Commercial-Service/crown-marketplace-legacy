Feature: Legal Panel for Government - Non central governemnt - Lot 5 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 5 - Rail Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 5 - Rail Legal Services'
    When I check the following items:
      | Pensions law |
      | Planning law |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |

  Scenario: Check the supplier data - SME
    Given I click on 'STANTON-GOYETTE'
    Then I am on the 'STANTON-GOYETTE' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£240.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£180.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£120.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£72.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And the contact details for the supplier are:
      | goyette.stanton@cronin-crist.example                   |
      | 980 392 0928                                           |
      | http://lakin.example/scottie.heathcote                 |
      | Suite 274 46313 Rosamond Center, Michaeltown, CT 85109 |
    And the prospectus link is 'http://bernier.example/armando.kemmer'

  Scenario: Check the supplier data - Non SME
    Given I click on 'DICKI, QUITZON AND KUB'
    Then I am on the 'DICKI, QUITZON AND KUB' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£200.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£150.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£100.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£60.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the contact details for the supplier are:
      | kub_and_dicki_quitzon@crist.example                           |
      | 5310816769                                                    |
      | http://stanton-goodwin.test/horace_stark                      |
      | Apt. 161 87668 Runolfsdottir Vista, Konopelskiville, HI 05873 |
    And the prospectus link is 'http://gibson-rogahn.example/delaine.hodkiewicz'

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded
