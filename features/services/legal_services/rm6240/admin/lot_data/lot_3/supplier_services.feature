Feature: Legal services - Admin - Supplier lot data - Lot 3 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'ZIEME GROUP'
    Then I am on the 'Supplier lot data' page
    And the caption is 'ZIEME GROUP'
    And I click on 'View services' for the lot 'Lot 3 - Transport rail legal services'
    Then I am on the 'Lot 3 - Transport rail legal services - Services' page
    And the caption is 'ZIEME GROUP'
    And the supplier should be assigned to the 'services' as follows:
      | Service name     | Has service? |
      | Transport (Rail) | Yes          |
