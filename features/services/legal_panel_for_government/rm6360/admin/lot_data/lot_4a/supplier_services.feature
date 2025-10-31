Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4a - Services

  Background: Go to services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'DICKI, QUITZON AND KUB'
    Then I am on the 'Supplier lot data' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'View services' for the lot 'Lot 4a - Trade and Investment Negotiations'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View services' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'services' as follows:
      | Assimilated Law                    |
      | FTA chapters                       |
      | Implementation of trade agreements |
      | International law of trade         |
      | International treaty law           |
      | Investment treaties                |
      | Wider trading arrangements         |
    Given I click on 'Change (Services the supplier can offer)'
    Then I am on the 'Edit service selection' page
    And the caption is 'DICKI, QUITZON AND KUB'

  Scenario: Update services
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | Legal barriers to markets               |
      | Trade and investment negotiations       |
    When I deselect the following items:
      | Implementation of trade agreements |
      | International law of trade         |
      | International treaty law           |
    Then I click on 'Save and return'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View services' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'services' as follows:
      | Assimilated Law                         |
      | Domestic law of jurisdictions for trade |
      | FTA chapters                            |
      | Investment treaties                     |
      | Legal barriers to markets               |
      | Trade and investment negotiations       |
      | Wider trading arrangements              |

  Scenario: Remove all services
    When I deselect the following items:
      | Assimilated Law                    |
      | FTA chapters                       |
      | Implementation of trade agreements |
      | International law of trade         |
      | International treaty law           |
      | Investment treaties                |
      | Wider trading arrangements         |
    Then I click on 'Save and return'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View services' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should not be assigned any 'services' with the following message:
      | The supplier does not offer any services in this lot |
