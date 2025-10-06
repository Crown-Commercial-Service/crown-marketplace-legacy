Feature: Legal Panel for Government - Non central governemnt - Lot 5 - Suppliers comparison selection

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 5 - Rail Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 5 - Rail Legal Services'
    When I check the following items:
      | Insurance law |
      | Planning law  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | DICKI, QUITZON AND KUB | http://gibson-rogahn.example/delaine.hodkiewicz |
      | HAUCK LLC              | http://parker.test/shaunte.adams                |
      | JOHNSON-ROMAGUERA      | http://glover.test/otto                         |
      | STANTON-GOYETTE        | http://bernier.example/armando.kemmer           |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | DICKI, QUITZON AND KUB |
      | HAUCK LLC              |
      | JOHNSON-ROMAGUERA      |
      | STANTON-GOYETTE        |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'DICKI, QUITZON AND KUB'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | DICKI, QUITZON AND KUB |
    When I check the following items:
      | HAUCK LLC         |
      | JOHNSON-ROMAGUERA |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | DICKI, QUITZON AND KUB |
      | HAUCK LLC              |
      | JOHNSON-ROMAGUERA      |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | DICKI, QUITZON AND KUB |
      | HAUCK LLC              |
      | JOHNSON-ROMAGUERA      |
      | STANTON-GOYETTE        |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | DICKI, QUITZON AND KUB |
      | HAUCK LLC              |
      | JOHNSON-ROMAGUERA      |
      | STANTON-GOYETTE        |
    When I deselect the following items:
      | DICKI, QUITZON AND KUB |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | HAUCK LLC         |
      | JOHNSON-ROMAGUERA |
      | STANTON-GOYETTE   |
    When I remove the following items from the basket:
      | HAUCK LLC         |
      | JOHNSON-ROMAGUERA |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | STANTON-GOYETTE |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | DICKI, QUITZON AND KUB |
      | HAUCK LLC              |
      | JOHNSON-ROMAGUERA      |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | DICKI, QUITZON AND KUB |
      | HAUCK LLC              |
      | JOHNSON-ROMAGUERA      |
