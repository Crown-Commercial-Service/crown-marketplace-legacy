Feature: Management Consultancy - Lot 3 - Complex and Transformation - Results

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    Given I select 'Lot 3 - Complex and Transformation'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 3 - Complex and Transformation'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | BOSCO-EBERT                   |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And I deselect all the items
    Given I check 'Business'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' companies can provide consultants
    And the selected suppliers are:
      | BERNHARD INC                  |
      | BOSCO-EBERT                   |
      | ROMAGUERA INC                 |
      | SCHUSTER, LEHNER AND KSHLERIN |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Going back from a supplier
    And I click on 'BOSCO-EBERT'
    Then I am on the 'BOSCO-EBERT' page
    And the sub title is 'MCF3 lot 3 - Complex and Transformation'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | BOSCO-EBERT                   |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' companies can provide consultants
    And the selected suppliers are:
      | BOSCO-EBERT                   |
      | VANDERVORT, KOVACEK AND MORAR |
      | VEUM-RODRIGUEZ                |
      | WILLIAMSON, DOYLE AND GLOVER  |
