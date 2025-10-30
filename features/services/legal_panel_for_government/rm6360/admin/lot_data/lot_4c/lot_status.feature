Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4c - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I should see the following details in the summary for the lot 'Lot 4c - International Investment Disputes':
      | Lot status    | Enabled            |
      | Services      | View services      |
      | Jurisdictions | View jurisdictions |
      | Rates         | View rates         |
    And I click on 'Change Lot status (Lot 4c - International Investment Disputes)'
    Then I am on the 'Edit lot status' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I select 'Disabled'
    And I click on 'Save and return'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I should see the following details in the summary for the lot 'Lot 4c - International Investment Disputes':
      | Lot status    | Disabled           |
      | Services      | View services      |
      | Jurisdictions | View jurisdictions |
      | Rates         | View rates         |
