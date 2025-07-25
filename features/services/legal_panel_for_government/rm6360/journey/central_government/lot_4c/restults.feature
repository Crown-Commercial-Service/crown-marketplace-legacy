Feature: Legal Panel for Government - Non central governemnt - Lot 4c - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4c - International Investment Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | International arbitral awards           |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | JOHNSON-ROMAGUERA       | http://sanford.example/lilly_bosco      |
      | VEUM, TORPHY AND NOLAN  | http://gislason.example/madeline.miller |
      | ZIEME-LEANNON           | http://terry.example/clementine.kozey   |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Litigation and dispute resolution for trade investment disputes'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | JAKUBOWSKI-SATTERFIELD  | http://botsford.example/zack.willms     |
      | JOHNSON-ROMAGUERA       | http://sanford.example/lilly_bosco      |
      | SANFORD AND SONS        | http://kreiger.example/ezra_romaguera   |
      | VEUM, TORPHY AND NOLAN  | http://gislason.example/madeline.miller |
      | ZIEME-LEANNON           | http://terry.example/clementine.kozey   |

  Scenario: Going back from a supplier
    And I click on 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'VEUM, TORPHY AND NOLAN' page
    And the sub title is 'Lot 4c - International Investment Disputes'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | JOHNSON-ROMAGUERA       | http://sanford.example/lilly_bosco      |
      | VEUM, TORPHY AND NOLAN  | http://gislason.example/madeline.miller |
      | ZIEME-LEANNON           | http://terry.example/clementine.kozey   |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | JOHNSON-ROMAGUERA       | http://sanford.example/lilly_bosco      |
      | VEUM, TORPHY AND NOLAN  | http://gislason.example/madeline.miller |
      | ZIEME-LEANNON           | http://terry.example/clementine.kozey   |
