Feature: Legal services - Non central governemnt - Lot 2 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'
    When I check the following items:
      | Court of Protection |
      | Licensing           |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - General service provision'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | COLLINS, COLE AND PACOCHA   |
      | GUSIKOWSKI, BOSCO AND CRIST |
      | WILLIAMSON-BERGSTROM        |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the jurisdiction you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Planning and Environment'
    When I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '2' suppliers can provide legal services
    And the selected legal service suppliers are:
      | COLLINS, COLE AND PACOCHA   |
      | WILLIAMSON-BERGSTROM        |

  Scenario: Jursidiction selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the jurisdiction you need' page
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | GUSIKOWSKI, BOSCO AND CRIST |
      | TREUTEL, GERLACH AND SPORER |
      | WILLIAMSON-BERGSTROM        |

  Scenario: Going back from a supplier
    And I click on 'GUSIKOWSKI, BOSCO AND CRIST'
    Then I am on the 'GUSIKOWSKI, BOSCO AND CRIST' page
    And the sub title is 'Lot 2 - General service provision'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | COLLINS, COLE AND PACOCHA   |
      | GUSIKOWSKI, BOSCO AND CRIST |
      | WILLIAMSON-BERGSTROM        |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | COLLINS, COLE AND PACOCHA   |
      | GUSIKOWSKI, BOSCO AND CRIST |
      | WILLIAMSON-BERGSTROM        |
