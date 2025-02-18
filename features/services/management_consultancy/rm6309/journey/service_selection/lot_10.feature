@javascript
Feature: Management Consultancy - Lot 10 - Restructuring and insolvency - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 10 - Restructuring and insolvency'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 10 - Restructuring and insolvency'
  
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Primary capabilities    |
      | Additional capabilities |
      | Sector specialisms      |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Primary capabilities'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Primary capabilities    |
    When I check the following items:
      | Additional capabilities |
      | Sector specialisms      |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Primary capabilities    |
      | Additional capabilities |
      | Sector specialisms      |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Primary capabilities    |
      | Additional capabilities |
      | Sector specialisms      |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Primary capabilities    |
      | Additional capabilities |
      | Sector specialisms      |
    When I deselect the following items:
      | Primary capabilities    |
    Then the basket should say '2 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Additional capabilities |
      | Sector specialisms      |
    When I remove the following items from the basket:
      | Additional capabilities |
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Sector specialisms      |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Primary capabilities    |
      | Additional capabilities |
      | Sector specialisms      |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Sector specialisms      |
      | Additional capabilities |
      | Primary capabilities    |
