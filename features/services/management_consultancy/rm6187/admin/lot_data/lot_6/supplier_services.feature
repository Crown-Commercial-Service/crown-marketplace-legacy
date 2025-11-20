Feature: Management Consultancy - Admin - Supplier lot data - Lot 6 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VANDERVORT, KOVACEK AND MORAR'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And I click on 'View services' for the lot 'Lot 6 - Procurement and Supply Chain'
    Then I am on the 'Lot 6 - Procurement and Supply Chain View services' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And the supplier should be assigned to the 'services' as follows:
      | Category management             |
      | Commercial review               |
      | Contract management             |
      | Cost reduction                  |
      | Digitalisation                  |
      | Financial advice                |
      | Outsourcing and insourcing      |
      | P2P                             |
      | Procurement process             |
      | Sourcing                        |
      | Supplier management             |
      | Supply chain and logistics      |
      | Tender development and analysis |
