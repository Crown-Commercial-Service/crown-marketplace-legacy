Feature: Management Consultancy - Admin - Supplier lot data - Lot 8 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WILLIAMSON, DOYLE AND GLOVER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And I click on 'View services' for the lot 'Lot 8 - Infrastructure including Transport'
    Then I am on the 'Lot 8 - Infrastructure including Transport View services' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And the supplier should be assigned to the 'services' as follows:
      | Aviation                                       |
      | Communications and technology infrastructure   |
      | Highways                                       |
      | Ports and shipping                             |
      | Public transport (including buses and parking) |
      | Rail                                           |
      | Smart infrastructure                           |
      | Towns and cities                               |
