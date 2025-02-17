@javascript
Feature: Management Consultancy - Lot 2 - Strategy and Policy - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 2 - Strategy and Policy'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 2 - Strategy and Policy'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Business case development       |
      | Social value                    |
      | Strategy                        |
      | Strategic advice                |
      | Business process re-engineering |
      | Business structure              |
      | Change management               |
      | Digital, technology and cyber   |
      | Future planning                 |
      | Game plan                       |
      | Policy                          |
      | Regulatory advice               |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Business case development'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development     |
    When I check the following items:
      | Change management             |
      | Policy                        |
      | Social value                  |
      | Strategic advice              |
      | Digital, technology and cyber |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development     |
      | Change management             |
      | Policy                        |
      | Social value                  |
      | Strategic advice              |
      | Digital, technology and cyber |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Business case development     |
      | Social value                  |
      | Digital, technology and cyber |
      | Regulatory advice             |
      | Strategic advice              |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development     |
      | Social value                  |
      | Digital, technology and cyber |
      | Regulatory advice             |
      | Strategic advice              |
    When I deselect the following items:
      | Digital, technology and cyber |
    Then the basket should say '4 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development     |
      | Social value                  |
      | Regulatory advice             |
      | Strategic advice              |
    When I remove the following items from the basket:
      | Social value                  |
      | Regulatory advice             |
    Then the basket should say '2 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development     |
      | Strategic advice              |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Business case development |
      | Social value              |
      | Change management         |
      | Regulatory advice         |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Change management         |
      | Business case development |
      | Social value              |
      | Regulatory advice         |
