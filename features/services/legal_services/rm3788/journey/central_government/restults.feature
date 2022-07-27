@pipeline
Feature: Legal services - Central governemnt - fees under £20,000 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    And I check the following items:
      | Property and construction       |
    When I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And the sub title is 'Lot 1 - Regional service provision'
    When I check the following items:
      | North East  |
      | North West  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HALEY, BARTON AND REICHEL       |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the regions where you need legal services' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Litigation / dispute resolution'
    When I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | North East  |
      | North West  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' suppliers can provide legal services
    And the selected legal service suppliers are:
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
    Given I check 'London'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '9' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BAHRINGER-HUDSON                |
      | GREEN, WALKER AND LEMKE         |
      | HALEY, BARTON AND REICHEL       |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Going back from a supplier
    And I click on 'MERTZ, LEGROS AND SCHROEDER'
    Then I am on the 'MERTZ, LEGROS AND SCHROEDER' page
    And the sub title is 'Lot 1 - Regional service provision'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HALEY, BARTON AND REICHEL       |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HALEY, BARTON AND REICHEL       |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |
