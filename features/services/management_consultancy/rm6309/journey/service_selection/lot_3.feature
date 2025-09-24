@javascript
Feature: Management Consultancy - Lot 3 - Complex and Transformation - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 3 - Complex and Transformation'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 3 - Complex and Transformation'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Business                                                    |
      | Change management                                           |
      | Complex programmes                                          |
      | Delivery partner                                            |
      | Digital, technology and cyber                               |
      | Finance                                                     |
      | HR                                                          |
      | Organisation design including Target Operating Models (TOM) |
      | Performance transformation                                  |
      | Procurement and/or supply chain                             |
      | Programme and project management                            |
      | Strategy and/or policy                                      |
      | Supplier side services and delivery                         |
      | Transformation management                                   |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Business'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business |
    When I check the following items:
      | Digital, technology and cyber       |
      | Finance                             |
      | Performance transformation          |
      | Change management                   |
      | Supplier side services and delivery |
      | Transformation management           |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business                            |
      | Digital, technology and cyber       |
      | Finance                             |
      | Performance transformation          |
      | Change management                   |
      | Supplier side services and delivery |
      | Transformation management           |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Change management                                           |
      | Digital, technology and cyber                               |
      | Finance                                                     |
      | Organisation design including Target Operating Models (TOM) |
      | Procurement and/or supply chain                             |
      | Supplier side services and delivery                         |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Change management                                           |
      | Digital, technology and cyber                               |
      | Finance                                                     |
      | Organisation design including Target Operating Models (TOM) |
      | Procurement and/or supply chain                             |
      | Supplier side services and delivery                         |
    When I deselect the following items:
      | Change management |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Digital, technology and cyber                               |
      | Finance                                                     |
      | Organisation design including Target Operating Models (TOM) |
      | Procurement and/or supply chain                             |
      | Supplier side services and delivery                         |
    When I remove the following items from the basket:
      | Finance                       |
      | Digital, technology and cyber |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Organisation design including Target Operating Models (TOM) |
      | Procurement and/or supply chain                             |
      | Supplier side services and delivery                         |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Complex programmes                  |
      | Digital, technology and cyber       |
      | HR                                  |
      | Procurement and/or supply chain     |
      | Change management                   |
      | Supplier side services and delivery |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Change management                   |
      | Digital, technology and cyber       |
      | HR                                  |
      | Procurement and/or supply chain     |
      | Complex programmes                  |
      | Supplier side services and delivery |
