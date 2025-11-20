Feature: Legal services - Admin - Supplier lot data - Lot 2b - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WEHNER, STEHR AND KULAS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And I click on 'View services' for the lot 'Lot 2b - General service provision (Scotland)'
    Then I am on the 'Lot 2b - General service provision View services' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And the supplier should be assigned to the 'services' as follows:
      | Employment               |
      | Healthcare               |
      | Mental Health Law        |
      | Planning and Environment |
      | Primary Care             |
      | Social Housing           |
