Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4c - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I click on 'View services' for the lot 'Lot 4c - International Investment Disputes'
    Then I am on the 'Lot 4c - International Investment Disputes - Services' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                                    | Has service? |
      | Domestic law of jurisdictions for trade                         | Yes          |
      | International arbitral awards                                   | Yes          |
      | Investment dispute risk advice                                  | Yes          |
      | Litigation and dispute resolution for trade investment disputes | Yes          |
      | Treaty based investment disputes                                | Yes          |
