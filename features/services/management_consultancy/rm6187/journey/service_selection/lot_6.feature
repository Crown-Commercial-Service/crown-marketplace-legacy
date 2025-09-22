@javascript
Feature: Management Consultancy - Lot 6 - Procurement and Supply Chain - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 6 - Procurement and Supply Chain'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 6 - Procurement and Supply Chain'

  Scenario: The correct options are available
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

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Category management'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management |
    When I check the following items:
      | Commercial review               |
      | Financial advice                |
      | Outsourcing and insourcing      |
      | Supplier management             |
      | Supply chain and logistics      |
      | Tender development and analysis |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management             |
      | Commercial review               |
      | Financial advice                |
      | Outsourcing and insourcing      |
      | Supplier management             |
      | Supply chain and logistics      |
      | Tender development and analysis |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Category management        |
      | Cost reduction             |
      | Outsourcing and insourcing |
      | P2P                        |
      | Sourcing                   |
      | Supplier management        |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management        |
      | Cost reduction             |
      | Outsourcing and insourcing |
      | P2P                        |
      | Sourcing                   |
      | Supplier management        |
    When I deselect the following items:
      | P2P |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Category management        |
      | Cost reduction             |
      | Outsourcing and insourcing |
      | Sourcing                   |
      | Supplier management        |
    When I remove the following items from the basket:
      | Cost reduction      |
      | Supplier management |
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
      | Commercial review   |
      | Cost reduction      |
      | Digitalisation      |
      | P2P                 |
      | Procurement process |
      | Sourcing            |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Cost reduction      |
      | Commercial review   |
      | Procurement process |
      | Digitalisation      |
      | Sourcing            |
      | P2P                 |
