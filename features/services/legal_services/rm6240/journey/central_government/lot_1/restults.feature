Feature: Legal services -  Central governemnt - Lot 1 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Full service provision'
    Given I check 'Information Technology'
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
    Given I check 'Non-Complex Finance and Investment'
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
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | DUBUQUE-PADBERG             |
      | HALEY-FAY                   |
      | LEDNER, BAILEY AND WEISSNAT |
      | MERTZ-HOMENICK              |

  Scenario: Going back from a supplier
    And I click on 'ZIEME GROUP'
    Then I am on the 'ZIEME GROUP' page
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
