@javascript
Feature: Management Consultancy - Lot 6 - Procurement and Supply Chain - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 6 - Procurement and Supply Chain'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 6 - Procurement and Supply Chain'

  Scenario: The correct options are available
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

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Category management'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management |
    When I check the following items:
      | Commercial review and benchmarking     |
      | Financial advice                       |
      | Outsourcing and insourcing             |
      | Contract and/or supplier management    |
      | Operations, supply chain and logistics |
      | Tender development and analysis        |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management                    |
      | Commercial review and benchmarking     |
      | Financial advice                       |
      | Outsourcing and insourcing             |
      | Contract and/or supplier management    |
      | Operations, supply chain and logistics |
      | Tender development and analysis        |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Category management                 |
      | Cost reduction                      |
      | Outsourcing and insourcing          |
      | Procurement process including P2P   |
      | Sourcing                            |
      | Contract and/or supplier management |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management                 |
      | Cost reduction                      |
      | Outsourcing and insourcing          |
      | Procurement process including P2P   |
      | Sourcing                            |
      | Contract and/or supplier management |
    When I deselect the following items:
      | Procurement process including P2P |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management                 |
      | Cost reduction                      |
      | Outsourcing and insourcing          |
      | Sourcing                            |
      | Contract and/or supplier management |
    When I remove the following items from the basket:
      | Cost reduction                      |
      | Contract and/or supplier management |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management        |
      | Outsourcing and insourcing |
      | Sourcing                   |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Commercial review and benchmarking |
      | Cost reduction                     |
      | Game theory                        |
      | Procurement process including P2P  |
      | Procurement regulation             |
      | Sourcing                           |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Cost reduction                     |
      | Commercial review and benchmarking |
      | Procurement regulation             |
      | Game theory                        |
      | Sourcing                           |
      | Procurement process including P2P  |
