Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4b - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'KOELPIN, HILLL AND COLLINS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And I click on 'View services' for the lot 'Lot 4b - International Trade Disputes'
    Then I am on the 'Lot 4b - International Trade Disputes - Services' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                            | Has service? |
      | Compliance with international law       | No           |
      | Domestic law of jurisdictions for trade | Yes          |
      | International trade disputes            | No           |
      | Prevention of disputes                  | Yes          |
      | Trade remedies                          | No           |
      | Trade remedies investigations           | No           |
      | WTO litigation and dispute resolution   | No           |
      | WTO practice                            | No           |
      | Wider trading arrangements              | Yes          |
