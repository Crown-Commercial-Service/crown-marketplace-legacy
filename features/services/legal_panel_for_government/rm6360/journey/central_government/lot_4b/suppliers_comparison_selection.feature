Feature: Legal Panel for Government - Non central governemnt - Lot 4b - Suppliers comparison selection

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4b - International Trade Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | International trade disputes            |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | ERDMAN INC               | http://mosciski.example/madelaine      |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
      | VEUM, TORPHY AND NOLAN   |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'ADAMS, WOLFF AND STROMAN'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
    When I check the following items:
      | ERDMAN INC  |
      | SANFORD INC |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
      | VEUM, TORPHY AND NOLAN   |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
      | VEUM, TORPHY AND NOLAN   |
    When I deselect the following items:
      | ADAMS, WOLFF AND STROMAN |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ERDMAN INC             |
      | SANFORD INC            |
      | VEUM, TORPHY AND NOLAN |
    When I remove the following items from the basket:
      | ERDMAN INC  |
      | SANFORD INC |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | VEUM, TORPHY AND NOLAN |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
