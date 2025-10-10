Feature: Legal Panel for Government - Non central governemnt - Lot 3 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Finance and High Risk/Innovation'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 3 - Finance and High Risk/Innovation'
    When I check the following items:
      | Debt Capital Markets  |
      | Fintech Crypto Assets |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://mosciski.test/augustine        |
      | O'CONNER AND SONS             | http://boyer-moen.test/dalene.grant   |
      | TILLMAN, LUBOWITZ AND GOYETTE | http://powlowski-cummings.test/cleora |
      | VEUM, TORPHY AND NOLAN        | http://barrows.test/rodney.ziemann    |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal specialisms you need' page
    And I deselect all the items
    Given I check 'United State Securities & Regulatory'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://mosciski.test/augustine        |
      | O'CONNER AND SONS             | http://boyer-moen.test/dalene.grant   |
      | TILLMAN, LUBOWITZ AND GOYETTE | http://powlowski-cummings.test/cleora |
      | VEUM, TORPHY AND NOLAN        | http://barrows.test/rodney.ziemann    |
      | ZIEME-LEANNON                 | http://tromp.test/marcellus           |

  Scenario: Going back from a supplier
    And I click on 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'VEUM, TORPHY AND NOLAN' page
    And the sub title is 'Lot 3 - Finance and High Risk/Innovation'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://mosciski.test/augustine        |
      | O'CONNER AND SONS             | http://boyer-moen.test/dalene.grant   |
      | TILLMAN, LUBOWITZ AND GOYETTE | http://powlowski-cummings.test/cleora |
      | VEUM, TORPHY AND NOLAN        | http://barrows.test/rodney.ziemann    |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://mosciski.test/augustine        |
      | O'CONNER AND SONS             | http://boyer-moen.test/dalene.grant   |
      | TILLMAN, LUBOWITZ AND GOYETTE | http://powlowski-cummings.test/cleora |
      | VEUM, TORPHY AND NOLAN        | http://barrows.test/rodney.ziemann    |
