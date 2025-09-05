Feature: Legal Panel for Government - Admin - Supplier lot data - Lot status

  Scenario: Lot status
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'ADAMS, WOLFF AND STROMAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'ADAMS, WOLFF AND STROMAN'
    And I should see the following details in the summary for the lot 'Lot 1 - Core Legal Services':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 2 - Major Projects and Complex Advice':
      | Lot status | Active        |
      | Services   | View services |
      | Rates      | View rates    |
    And I should see the following details in the summary for the lot 'Lot 3 - Finance and High Risk/Innovation':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 4a - Trade and Investment Negotiations':
      | Lot status    | Active             |
      | Services      | View services      |
      | Rates         | View rates         |
      | Jurisdictions | View jurisdictions |
    And I should see the following details in the summary for the lot 'Lot 4b - International Trade Disputes':
      | Lot status    | Active             |
      | Services      | View services      |
      | Rates         | View rates         |
      | Jurisdictions | View jurisdictions |
    And I should see the following details in the summary for the lot 'Lot 4c - International Investment Disputes':
      | Lot status | Inactive |
    And I should see the following details in the summary for the lot 'Lot 5 - Rail Legal Services':
      | Lot status | Inactive |
