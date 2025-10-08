Feature: Legal Panel for Government - Non central governemnt - Lot 1 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Core Legal Services'
    When I check the following items:
      | Assimilated Law       |
      | Aviation and Airports |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Check the supplier data - SME
    Given I click on 'MONAHAN-JOHNS'
    Then I am on the 'MONAHAN-JOHNS' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£200.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£150.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£100.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£60.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the contact details for the supplier are:
      | johns.monahan@macejkovic-will.example                   |
      | 349.577.3481                                            |
      | http://pfannerstill.example/charlotte                   |
      | Suite 532 70911 Ethan Overpass, Trevorchester, MA 81694 |
    And the prospectus link is 'http://kirlin.test/dione.rau'

  Scenario: Check the supplier data - Non SME
    Given I click on 'CORMIER INC'
    Then I am on the 'CORMIER INC' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£240.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£180.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£120.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£72.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And the contact details for the supplier are:
      | cormier.inc@jerde.example                     |
      | 767-310-7249                                  |
      | http://hahn.example/marybelle_cronin          |
      | 1830 Marisha Crest, Bayermouth, OK 02096-6821 |
    And the prospectus link is 'http://block.test/blossom.gulgowski'

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded
