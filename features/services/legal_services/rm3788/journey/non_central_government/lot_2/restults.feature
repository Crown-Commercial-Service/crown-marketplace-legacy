@pipeline
Feature: Legal services -  Non central governemnt - Lot 2 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I select 'England and Wales'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    When I check the following items:
      | Administrative and public law         |
      | Food, rural and environmental affairs |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | GREEN, WALKER AND LEMKE         |
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | RICE-PROHASKA                   |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Partnerships'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' suppliers can provide legal services
    And the selected legal service suppliers are:
      | GREEN, WALKER AND LEMKE         |
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | RICE-PROHASKA                   |
      | SCHMITT INC                     |

  Scenario: Region selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    Given I click on the 'Back' back link
    Then I am on the 'Select the jurisdiction you need' page
    And I select 'Scotland'
    When I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    When I check the following items:
      | Administrative and public law         |
      | Food, rural and environmental affairs |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BORER-PREDOVIC                  |
      | GLOVER, BERGSTROM AND PACOCHA   |
      | GREEN, WALKER AND LEMKE         |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Going back from a supplier
    And I click on 'RICE-PROHASKA'
    Then I am on the 'RICE-PROHASKA' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | GREEN, WALKER AND LEMKE         |
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | RICE-PROHASKA                   |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | GREEN, WALKER AND LEMKE         |
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | RICE-PROHASKA                   |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |
