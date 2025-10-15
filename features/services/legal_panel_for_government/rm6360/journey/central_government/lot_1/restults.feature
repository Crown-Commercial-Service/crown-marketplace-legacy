Feature: Legal Panel for Government - Non central governemnt - Lot 1 - Results

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
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 1 - Core Legal Services'
    When I check the following items:
      | Assimilated Law       |
      | Aviation and Airports |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal specialisms you need' page
    And I deselect all the items
    Given I check 'Charities'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded
