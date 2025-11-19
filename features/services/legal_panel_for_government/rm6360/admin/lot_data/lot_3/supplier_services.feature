Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 3 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SANFORD INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SANFORD INC'
    And I click on 'View services' for the lot 'Lot 3 - Finance and High Risk/Innovation'
    Then I am on the 'Lot 3 - Finance and High Risk/Innovation View services' page
    And the caption is 'SANFORD INC'
    And the supplier should be assigned to the 'services' as follows:
      | Credit Insurance and Related Products |
      | Debt Capital Markets                  |
      | Investment and Commercial Banking     |
      | Merger and Acquisition Activity       |
      | Projects and transactions             |
      | Restructuring/Insolvency              |
      | Sustainable Finance/ Green Finance    |
