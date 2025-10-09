Feature: Legal Panel for Government - Non central governemnt - Lot 3 - Suppliers comparison selection

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
    And I select 'Lot 3 - Finance and High Risk/Innovation'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
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
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | CORMIER INC                   |
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
      | VEUM, TORPHY AND NOLAN        |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'CORMIER INC'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | CORMIER INC |
    When I check the following items:
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | CORMIER INC                   |
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | CORMIER INC                   |
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
      | VEUM, TORPHY AND NOLAN        |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | CORMIER INC                   |
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
      | VEUM, TORPHY AND NOLAN        |
    When I deselect the following items:
      | CORMIER INC |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
      | VEUM, TORPHY AND NOLAN        |
    When I remove the following items from the basket:
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | VEUM, TORPHY AND NOLAN |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | CORMIER INC                   |
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | CORMIER INC                   |
      | O'CONNER AND SONS             |
      | TILLMAN, LUBOWITZ AND GOYETTE |
