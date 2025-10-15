Feature: Legal Panel for Government - Non central governemnt - Lot 5 - Results

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
    And I should see that '3' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal specialisms you need' page
    And I deselect all the items
    Given I check 'Insurance law'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | HAUCK LLC              | http://parker.test/shaunte.adams                |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |
      | WALKER-LEUSCHKE        | http://gerlach.example/chong                    |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then the spreadsheet 'Shortlist of Legal Panel for Government Suppliers.xlsx' is downloaded
