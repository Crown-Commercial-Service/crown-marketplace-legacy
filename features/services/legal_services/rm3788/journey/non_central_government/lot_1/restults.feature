@pipeline
Feature: Legal services - Non central governemnt - Lot 1 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    And I check the following items:
      | Employment  |
      | Healthcare  |
    When I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And the sub title is 'Lot 1 - Regional service provision'
    When I check the following items:
      | London      |
      | South East  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the regions where you need legal services' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Property and construction'
    When I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | London      |
      | South East  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BAHRINGER-HUDSON                |
      | HALEY, BARTON AND REICHEL       |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |

  Scenario: Region selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the regions where you need legal services' page
    And I deselect all the items
    Given I check 'Scotland'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BAHRINGER-HUDSON                |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |

  Scenario: Going back from a supplier
    And I click on 'MURAZIK-COLLINS'
    Then I am on the 'MURAZIK-COLLINS' page
    And the sub title is 'Lot 1 - Regional service provision'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
