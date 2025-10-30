Feature: Management Consultancy - Admin - Supplier lot data - Lot 8 - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WILLIAMSON, DOYLE AND GLOVER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And I should see the following details in the summary for the lot 'Lot 8 - Infrastructure including Transport':
      | Lot status | Enabled       |
      | Services   | View services |
      | Rates      | View rates    |
    And I click on 'Change Lot status (Lot 8 - Infrastructure including Transport)'
    Then I am on the 'Edit lot status' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And I should see the following details in the summary for the lot 'Lot 8 - Infrastructure including Transport':
      | Lot status | Disabled      |
      | Services   | View services |
      | Rates      | View rates    |
