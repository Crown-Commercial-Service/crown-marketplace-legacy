@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 4c - Suppliers comparison selection

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
      | International arbitral awards    |
      | Treaty based investment disputes |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | BROWN-BEIER            | http://gislason-simonis.example/lane_kemmer |
      | JOHNSON-ROMAGUERA      | http://sanford.example/lilly_bosco          |
      | VEUM, TORPHY AND NOLAN | http://gislason.example/madeline.miller     |
      | ZIEME-LEANNON          | http://terry.example/clementine.kozey       |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | BROWN-BEIER            |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |

  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'BROWN-BEIER'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | BROWN-BEIER |
    When I check the following items:
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | BROWN-BEIER            |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | BROWN-BEIER            |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | BROWN-BEIER            |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |
    When I deselect the following items:
      | BROWN-BEIER |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |
    When I remove the following items from the basket:
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ZIEME-LEANNON |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | BROWN-BEIER            |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | BROWN-BEIER            |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
