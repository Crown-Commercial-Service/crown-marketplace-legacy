Feature: Legal Panel for Government - Non central governemnt - Lot 3 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Finance and High Risk/Innovation'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 3 - Finance and High Risk/Innovation'
    When I check the following items:
      | Debt Capital Markets  |
      | Fintech Crypto Assets |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://mosciski.test/augustine        |
      | O'CONNER AND SONS             | http://boyer-moen.test/dalene.grant   |
      | TILLMAN, LUBOWITZ AND GOYETTE | http://powlowski-cummings.test/cleora |
      | VEUM, TORPHY AND NOLAN        | http://barrows.test/rodney.ziemann    |

  Scenario: Check the supplier data - SME
    Given I click on 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'VEUM, TORPHY AND NOLAN' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£240.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£180.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£120.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£72.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And the contact details for the supplier are:
      | and_torphy_veum_nolan@brakus-treutel.test |
      | 567-179-1230                              |
      | http://corwin-toy.test/june.rodriguez     |
      | 460 O'Reilly Centers, Greenview, OH 10209 |
    And the prospectus link is 'http://barrows.test/rodney.ziemann'

  Scenario: Check the supplier data - Non SME
    Given I click on 'TILLMAN, LUBOWITZ AND GOYETTE'
    Then I am on the 'TILLMAN, LUBOWITZ AND GOYETTE' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£280.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£245.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£210.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£175.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£140.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£84.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£70.00'
    And the contact details for the supplier are:
      | lubowitz.and.tillman.goyette@stanton.test |
      | 659-663-3692                              |
      | http://hane.example/russel.lesch          |
      | 546 Mallie Branch, West Marcus, MS 35905  |
    And the prospectus link is 'http://powlowski-cummings.test/cleora'

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded