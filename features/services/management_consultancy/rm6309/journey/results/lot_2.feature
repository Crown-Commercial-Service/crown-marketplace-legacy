Feature: Management Consultancy - Lot 2 - Strategy and Policy - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 2 - Strategy and Policy'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 2 - Strategy and Policy'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC     |
      | PURDY-KEMMER      |
      | STROSIN-MEDHURST  |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And I deselect all the items
    Given I check 'Strategic advice'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC           |
      | JERDE, MOHR AND POLLICH |
      | PURDY-KEMMER            |
      | SCHROEDER-STIEDEMANN    |
      | STROSIN-MEDHURST        |
      | WELCH GROUP             |

  Scenario: Going back from a supplier
    And I click on 'PURDY-KEMMER'
    Then I am on the 'PURDY-KEMMER' page
    And the sub title is 'MCF4 lot 2 - Strategy and Policy'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC     |
      | PURDY-KEMMER      |
      | STROSIN-MEDHURST  |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC     |
      | PURDY-KEMMER      |
      | STROSIN-MEDHURST  |
