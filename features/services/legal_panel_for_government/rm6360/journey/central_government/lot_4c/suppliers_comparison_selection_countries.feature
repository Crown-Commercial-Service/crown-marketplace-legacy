Feature: Legal Panel for Government - Non central governemnt - Lot 4c - Suppliers comparison selection - Countries

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
    And I select 'Lot 4c - International Investment Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countries for your requirement' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    When I check the following items:
      | Malta  |
      | Malawi |
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    When I check the following items:
      | Litigation and dispute resolution for trade investment disputes |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | JAKUBOWSKI-SATTERFIELD | http://botsford.example/zack.willms     |
      | JOHNSON-ROMAGUERA      | http://sanford.example/lilly_bosco      |
      | SANFORD AND SONS       | http://kreiger.example/ezra_romaguera   |
      | VEUM, TORPHY AND NOLAN | http://gislason.example/madeline.miller |
      | ZIEME-LEANNON          | http://terry.example/clementine.kozey   |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | JAKUBOWSKI-SATTERFIELD |
      | JOHNSON-ROMAGUERA      |
      | SANFORD AND SONS       |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'JAKUBOWSKI-SATTERFIELD'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | JAKUBOWSKI-SATTERFIELD |
    When I check the following items:
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | JAKUBOWSKI-SATTERFIELD |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | JAKUBOWSKI-SATTERFIELD |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | JAKUBOWSKI-SATTERFIELD |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
      | ZIEME-LEANNON          |
    When I deselect the following items:
      | JAKUBOWSKI-SATTERFIELD |
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

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | JAKUBOWSKI-SATTERFIELD |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | JAKUBOWSKI-SATTERFIELD |
      | JOHNSON-ROMAGUERA      |
      | VEUM, TORPHY AND NOLAN |
