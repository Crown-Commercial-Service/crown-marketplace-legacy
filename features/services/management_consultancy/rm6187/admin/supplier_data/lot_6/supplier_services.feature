Feature: Management Consultancy - Admin - Supplier lot data - Lot 6 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VANDERVORT, KOVACEK AND MORAR'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And I click on 'View services' for the lot 'Lot 6 - Procurement and Supply Chain'
    Then I am on the 'Lot 6 - Procurement and Supply Chain - Services' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                    | Has service? |
      | Category management             | Yes          |
      | Commercial review               | Yes          |
      | Contract management             | Yes          |
      | Cost reduction                  | Yes          |
      | Digitalisation                  | Yes          |
      | Financial advice                | Yes          |
      | Outsourcing and insourcing      | Yes          |
      | P2P                             | Yes          |
      | Procurement process             | Yes          |
      | Sourcing                        | Yes          |
      | Supplier management             | Yes          |
      | Supply chain and logistics      | Yes          |
      | Tender development and analysis | Yes          |
