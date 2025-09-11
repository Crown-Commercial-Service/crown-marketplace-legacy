Feature: Management Consultancy - Admin - Supplier lot data - Lot 2 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MOSCISKI-CROOKS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MOSCISKI-CROOKS'
    And I click on 'View services' for the lot 'Lot 2 - Strategy and Policy'
    Then I am on the 'Lot 2 - Strategy and Policy - Services' page
    And the caption is 'MOSCISKI-CROOKS'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                    | Has service? |
      | Business case development       | Yes          |
      | Business process re-engineering | Yes          |
      | Business structure              | Yes          |
      | Change management               | Yes          |
      | Digital, technology and cyber   | Yes          |
      | Future planning                 | Yes          |
      | Game plan                       | Yes          |
      | Policy                          | Yes          |
      | Regulatory advice               | Yes          |
      | Social value                    | Yes          |
      | Strategic advice                | Yes          |
      | Strategy                        | Yes          |
