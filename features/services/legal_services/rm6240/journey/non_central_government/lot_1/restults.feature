Feature: Legal services - Non central governemnt - Lot 1 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Full service provision'
    When I check the following items:
      | Children and Vulnerable Adults  |
      | Corporate Law                   |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 1 - Full service provision'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | LEDNER, BAILEY AND WEISSNAT |
      | WILLIAMSON-BERGSTROM        |
      | ZIEME GROUP                 |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the jurisdiction you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Media Law'
    When I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | WILLIAMSON-BERGSTROM        |
      | ZIEME GROUP                 |

  Scenario: Jursidiction selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the jurisdiction you need' page
    And I select 'Northern Ireland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HALEY-FAY                   |
      | WILLIAMSON-BERGSTROM        |
      | ZIEME GROUP                 |

  Scenario: Going back from a supplier
    And I click on 'LEDNER, BAILEY AND WEISSNAT'
    Then I am on the 'LEDNER, BAILEY AND WEISSNAT' page
    And the sub title is 'Lot 1 - Full service provision'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | LEDNER, BAILEY AND WEISSNAT |
      | WILLIAMSON-BERGSTROM        |
      | ZIEME GROUP                 |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | LEDNER, BAILEY AND WEISSNAT |
      | WILLIAMSON-BERGSTROM        |
      | ZIEME GROUP                 |
