Feature: Management Consultancy - Admin - Supplier lot data - Lot 3 - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GREENFELDER-LEUSCHKE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I should see the following details in the summary for the lot 'Lot 3 - Complex and Transformation':
      | Lot status | Enabled       |
      | Services   | View services |
      | Rates      | View rates    |
    And I click on 'Change Lot status (Lot 3 - Complex and Transformation)'
    Then I am on the 'Edit lot status' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I should see the following details in the summary for the lot 'Lot 3 - Complex and Transformation':
      | Lot status | Disabled      |
      | Services   | View services |
      | Rates      | View rates    |
