@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 4b - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4b - International Trade Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    And the sub title is 'Lot 4b - International Trade Disputes'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4b - International Trade Disputes'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Compliance with international law       |
      | Domestic law of jurisdictions for trade |
      | International trade disputes            |
      | Prevention of disputes                  |
      | Trade remedies                          |
      | Trade remedies investigations           |
      | WTO litigation and dispute resolution   |
      | WTO practice                            |
      | Wider trading arrangements              |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Compliance with international law'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Compliance with international law     |
    When I check the following items:
      | International trade disputes          |
      | Trade remedies                        |
      | Trade remedies investigations         |
      | WTO litigation and dispute resolution |
      | WTO practice                          |
      | Wider trading arrangements            |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Compliance with international law     |
      | International trade disputes          |
      | Trade remedies                        |
      | Trade remedies investigations         |
      | WTO litigation and dispute resolution |
      | WTO practice                          |
      | Wider trading arrangements            |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Compliance with international law     |
      | International trade disputes          |
      | Prevention of disputes                |
      | WTO litigation and dispute resolution |
      | WTO practice                          |
      | Wider trading arrangements            |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Compliance with international law     |
      | International trade disputes          |
      | Prevention of disputes                |
      | WTO litigation and dispute resolution |
      | WTO practice                          |
      | Wider trading arrangements            |
    When I deselect the following items:
      | Wider trading arrangements            |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Compliance with international law     |
      | International trade disputes          |
      | Prevention of disputes                |
      | WTO litigation and dispute resolution |
      | WTO practice                          |
    When I remove the following items from the basket:
      | WTO litigation and dispute resolution |
      | WTO practice                          |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Compliance with international law     |
      | International trade disputes          |
      | Prevention of disputes                |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  # TODO: Add this scenario
  # Scenario: Go back from jurisdiction and change selection
  #   When I check the following items:
  #     | Infrastructure                                  |
  #     | Intellectual Property Law                       |
  #     | International Trade, Investment and Regulation  |
  #   And I click on 'Continue'
  #   Then I am on the 'Select the jurisdiction you need' page
  #   And I click on the 'Back' back link
  #   Then I am on the 'Select the legal services you need' page
  #   And the following items should appear in the basket:
  #     | Infrastructure                                  |
  #     | Intellectual Property Law                       |
  #     | International Trade, Investment and Regulation  |
