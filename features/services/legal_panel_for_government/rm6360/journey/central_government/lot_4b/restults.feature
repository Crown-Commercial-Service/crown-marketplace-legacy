Feature: Legal Panel for Government - Non central governemnt - Lot 4b - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4b - International Trade Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    When I check the following items:
      | Compliance with international law       |
      | Domestic law of jurisdictions for trade |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Trade remedies'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN         | http://gleichner-lowe.example/freddie  |
      | ERDMAN INC                       | http://mosciski.example/madelaine      |
      | SANFORD INC                      | http://murazik-bechtelar.test/neda     |
      | STEUBER, BERNIER AND SATTERFIELD | http://brekke-roberts.test/tory        |
      | VEUM, TORPHY AND NOLAN           | http://gislason-murazik.example/dorthy |

  Scenario: Going back from a supplier
    And I click on 'SANFORD INC'
    Then I am on the 'SANFORD INC' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |
