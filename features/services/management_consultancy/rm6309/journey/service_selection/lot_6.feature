Feature: Management Consultancy - Lot 6 - Procurement and Supply Chain - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 6 - Procurement and Supply Chain'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 6 - Procurement and Supply Chain'
    Then I should see the following options for the lot:
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
