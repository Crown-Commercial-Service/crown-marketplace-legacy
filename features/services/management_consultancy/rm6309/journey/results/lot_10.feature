Feature: Management Consultancy - Lot 10 - Restructuring and insolvency - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 10 - Restructuring and insolvency'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 10 - Restructuring and insolvency'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | KOHLER-STOKES        |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And I deselect all the items
    Given I check 'Aviation'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | GUTMANN-PFEFFER      |
      | KOHLER-STOKES        |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |

  Scenario: Going back from a supplier
    And I click on 'KOHLER-STOKES'
    Then I am on the 'KOHLER-STOKES' page
    And the sub title is 'MCF4 lot 10 - Restructuring and insolvency'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | KOHLER-STOKES        |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | KOHLER-STOKES        |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |
