Feature: Management Consultancy - Lot 1 - Business - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 1 - Business'
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
    Given I check 'Change management'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' companies can provide consultants
    And the selected suppliers are:
      | GREENHOLT INC             |
      | KOVACEK, WIZA AND STROMAN |
      | PACOCHA-CORWIN            |
      | PURDY-KEMMER              |
      | STROSIN-MEDHURST          |

  Scenario: Going back from a supplier
    And I click on 'GREENHOLT INC'
    Then I am on the 'GREENHOLT INC' page
    And the sub title is 'MCF4 lot 1 - Business'
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
