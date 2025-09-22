Feature: Legal Panel for Government - Non central governemnt - Lot 5 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 5 - Rail Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
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

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Insurance law'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | HAUCK LLC              | http://parker.test/shaunte.adams                |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |
      | WALKER-LEUSCHKE        | http://gerlach.example/chong                    |

  Scenario: Going back from a supplier
    And I click on 'JOHNSON-ROMAGUERA'
    Then I am on the 'JOHNSON-ROMAGUERA' page
    And the sub title is 'Lot 5 - Rail Legal Services'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |
