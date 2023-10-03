Feature: Management Consultancy - Lot 2 - Strategy and Policy - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 2 - Strategy and Policy'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 2 - Strategy and Policy'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And I deselect all the items
    Given I check 'Business case development'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' companies can provide consultants
    And the selected suppliers are:
      | BERNHARD INC                  |
      | O'REILLY, ZULAUF AND BEATTY   |
      | TREMBLAY-MOORE                |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Going back from a supplier
    And I click on 'WILLIAMSON, DOYLE AND GLOVER'
    Then I am on the 'WILLIAMSON, DOYLE AND GLOVER' page
    And the sub title is 'MCF3 lot 2 - Strategy and Policy'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' companies can provide consultants
    And the selected suppliers are:
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |
