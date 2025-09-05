@javascript
Feature: Management Consultancy - Lot 8 - Infrastructure including Transport - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 8 - Infrastructure including Transport'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 8 - Infrastructure including Transport'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Aviation                                       |
      | Communications and technology infrastructure   |
      | Highways                                       |
      | Ports and shipping                             |
      | Public transport (including buses and parking) |
      | Rail                                           |
      | Smart infrastructure                           |
      | Towns and cities                               |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Aviation'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Aviation |
    When I check the following items:
      | Communications and technology infrastructure |
      | Highways                                     |
      | Rail                                         |
      | Towns and cities                             |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Aviation                                     |
      | Communications and technology infrastructure |
      | Highways                                     |
      | Rail                                         |
      | Towns and cities                             |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Highways                                       |
      | Public transport (including buses and parking) |
      | Rail                                           |
      | Towns and cities                               |
    Then the basket should say '4 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Highways                                       |
      | Public transport (including buses and parking) |
      | Rail                                           |
      | Towns and cities                               |
    When I deselect the following items:
      | Public transport (including buses and parking) |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Highways         |
      | Rail             |
      | Towns and cities |
    When I remove the following items from the basket:
      | Rail             |
      | Towns and cities |
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Highways |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Aviation           |
      | Ports and shipping |
      | Rail               |
      | Towns and cities   |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Ports and shipping |
      | Towns and cities   |
      | Aviation           |
      | Rail               |
