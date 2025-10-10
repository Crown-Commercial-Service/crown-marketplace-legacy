Feature: Legal Panel for Government - Non central governemnt - Lot 4a - Service selection

  Background: Navigate to start page and select the lot
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
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Assimilated Law                         |
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
      | International law of trade              |
      | International treaty law                |
      | Investment treaties                     |
      | Legal barriers to markets               |
      | Trade and investment negotiations       |
      | Wider trading arrangements              |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No specialisms selected'
    And the remove all link should not be visible
    When I check 'Assimilated Law'
    Then the basket should say '1 specialism selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Assimilated Law |
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | Implementation of trade agreements      |
      | International law of trade              |
      | International treaty law                |
      | Investment treaties                     |
      | Legal barriers to markets               |
    Then the basket should say '7 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Assimilated Law                         |
      | Domestic law of jurisdictions for trade |
      | Implementation of trade agreements      |
      | International law of trade              |
      | International treaty law                |
      | Investment treaties                     |
      | Legal barriers to markets               |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
      | Investment treaties                     |
      | Trade and investment negotiations       |
      | Wider trading arrangements              |
    Then the basket should say '6 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
      | Investment treaties                     |
      | Trade and investment negotiations       |
      | Wider trading arrangements              |
    When I deselect the following items:
      | Wider trading arrangements |
    Then the basket should say '5 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
      | Investment treaties                     |
      | Trade and investment negotiations       |
    When I remove the following items from the basket:
      | Investment treaties               |
      | Trade and investment negotiations |
    Then the basket should say '3 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
    When I click on 'Remove all'
    Then the basket should say 'No specialisms selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal specialisms you need' page
    And the following items should appear in the basket:
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Implementation of trade agreements      |
