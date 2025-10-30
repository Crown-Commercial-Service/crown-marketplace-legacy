Feature: Management Consultancy - Admin - Supplier lot data - Lot 2 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MOSCISKI-CROOKS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MOSCISKI-CROOKS'
    And I click on 'View services' for the lot 'Lot 2 - Strategy and Policy'
    Then I am on the 'Lot 2 - Strategy and Policy View services' page
    And the caption is 'MOSCISKI-CROOKS'
    And the supplier should be assigned to the 'services' as follows:
      | Business case development       |
      | Business process re-engineering |
      | Business structure              |
      | Change management               |
      | Digital, technology and cyber   |
      | Future planning                 |
      | Game plan                       |
      | Policy                          |
      | Regulatory advice               |
      | Social value                    |
      | Strategic advice                |
      | Strategy                        |
