Feature: Legal Panel for Government - Non central governemnt - Lot 1 - Suppliers comparison selection

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
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
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |

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
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | CORMIER INC                   |
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |
    When I deselect the following items:
      | CORMIER INC |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |
    When I remove the following items from the basket:
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | MONAHAN-JOHNS |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
