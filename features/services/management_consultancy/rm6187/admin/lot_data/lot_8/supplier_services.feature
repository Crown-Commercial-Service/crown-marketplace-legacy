Feature: Management Consultancy - Admin - Supplier lot data - Lot 8 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WILLIAMSON, DOYLE AND GLOVER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And I click on 'View services' for the lot 'Lot 8 - Infrastructure including Transport'
    Then I am on the 'Lot 8 - Infrastructure including Transport - Services' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                   | Has service? |
      | Aviation                                       | Yes          |
      | Communications and technology infrastructure   | Yes          |
      | Highways                                       | Yes          |
      | Ports and shipping                             | Yes          |
      | Public transport (including buses and parking) | Yes          |
      | Rail                                           | Yes          |
      | Smart infrastructure                           | Yes          |
      | Towns and cities                               | Yes          |
