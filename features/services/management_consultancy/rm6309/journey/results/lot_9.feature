Feature: Management Consultancy - Lot 9 - Environment and Sustainability - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 9 - Environment and Sustainability'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 9 - Environment and Sustainability'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' companies can provide consultants
    And the selected suppliers are:
      | GOTTLIEB, HEATHCOTE AND JACOBI  |
      | GREENFELDER-LEUSCHKE            |
      | MOSCISKI-CROOKS                 |
      | STROMAN-ROMAGUERA               |
      | TURCOTTE GROUP                  |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And I deselect all the items
    Given I check 'Contaminated land and water'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '9' companies can provide consultants
    And the selected suppliers are:
      | GOTTLIEB, HEATHCOTE AND JACOBI  |
      | GREENFELDER-LEUSCHKE            |
      | GUTMANN-PFEFFER                 |
      | KOHLER-STOKES                   |
      | MOSCISKI-CROOKS                 |
      | SCHINNER-LAKIN                  |
      | SCHUMM, GRANT AND SPORER        |
      | STROMAN-ROMAGUERA               |
      | TURCOTTE GROUP                  |

  Scenario: Going back from a supplier
    And I click on 'GOTTLIEB, HEATHCOTE AND JACOBI'
    Then I am on the 'GOTTLIEB, HEATHCOTE AND JACOBI' page
    And the sub title is 'MCF4 lot 9 - Environment and Sustainability'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '5' companies can provide consultants
    And the selected suppliers are:
      | GOTTLIEB, HEATHCOTE AND JACOBI  |
      | GREENFELDER-LEUSCHKE            |
      | MOSCISKI-CROOKS                 |
      | STROMAN-ROMAGUERA               |
      | TURCOTTE GROUP                  |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '5' companies can provide consultants
    And the selected suppliers are:
      | GOTTLIEB, HEATHCOTE AND JACOBI  |
      | GREENFELDER-LEUSCHKE            |
      | MOSCISKI-CROOKS                 |
      | STROMAN-ROMAGUERA               |
      | TURCOTTE GROUP                  |
