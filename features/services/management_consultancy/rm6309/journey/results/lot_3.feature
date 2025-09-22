Feature: Management Consultancy - Lot 3 - Complex and Transformation - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 3 - Complex and Transformation'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 3 - Complex and Transformation'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And I deselect all the items
    Given I check 'Business'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' companies can provide consultants
    And the selected suppliers are:
      | GOTTLIEB, HEATHCOTE AND JACOBI |
      | GREENFELDER-LEUSCHKE           |
      | KOHLER-STOKES                  |
      | MOSCISKI-CROOKS                |
      | SCHINNER-LAKIN                 |
      | TURCOTTE GROUP                 |

  Scenario: Going back from a supplier
    And I click on 'TURCOTTE GROUP'
    Then I am on the 'TURCOTTE GROUP' page
    And the sub title is 'MCF4 lot 3 - Complex and Transformation'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | GREENFELDER-LEUSCHKE |
      | MOSCISKI-CROOKS      |
      | TURCOTTE GROUP       |
