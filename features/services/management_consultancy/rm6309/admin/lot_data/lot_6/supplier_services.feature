Feature: Management Consultancy - Admin - Supplier lot data - Lot 6 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SCHUMM, GRANT AND SPORER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SCHUMM, GRANT AND SPORER'
    And I click on 'View services' for the lot 'Lot 6 - Procurement and Supply Chain'
    Then I am on the 'Lot 6 - Procurement and Supply Chain View services' page
    And the caption is 'SCHUMM, GRANT AND SPORER'
    And the supplier should be assigned to the 'services' as follows:
      | Category management                    |
      | Commercial review and benchmarking     |
      | Contract and/or supplier management    |
      | Cost reduction                         |
      | Financial advice                       |
      | Game theory                            |
      | Operations, supply chain and logistics |
      | Outsourcing and insourcing             |
      | Procurement process including P2P      |
      | Procurement regulation                 |
      | Sourcing                               |
      | Tender development and analysis        |
