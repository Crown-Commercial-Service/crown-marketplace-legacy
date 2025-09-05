Feature: Management Consultancy - Admin - Supplier lot data - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GOTTLIEB, HEATHCOTE AND JACOBI'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GOTTLIEB, HEATHCOTE AND JACOBI'
    And I should see the following details in the summary for the lot 'Lot 1 - Business':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2 - Strategy and Policy':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 3 - Complex and Transformation':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 4 - Finance':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 5 - HR':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 6 - Procurement and Supply Chain':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 7 - Health, Social Care and Community':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 8 - Infrastructure':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 9 - Environment and Sustainability':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 10 - Restructuring and insolvency':
      | Lot status | Inactive |
