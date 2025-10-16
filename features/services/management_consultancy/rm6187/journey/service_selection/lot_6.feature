Feature: Management Consultancy - Lot 6 - Procurement and Supply Chain - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 6 - Procurement and Supply Chain'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 6 - Procurement and Supply Chain'
    Then I should see the following options for the lot:
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
