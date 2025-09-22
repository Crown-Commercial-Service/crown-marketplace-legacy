Feature: Legal Panel for Government - Non central governemnt - Lot 4a - Results with country selection

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countries for your requirement' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Finland     |
      | South Sudan |
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Assimilated Law |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |
      | STANTON-GOYETTE          | http://lakin.example/lavinia           |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'International law of trade'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |

  Scenario: Country selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    Given I click on the 'Back' back link
    Then I am on the 'Select the countries for your requirement' page
    And I deselect all the items
    When I check the following items:
      | Benin |
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Assimilated Law |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |

  Scenario: Going back from a supplier
    And I click on 'STANTON-GOYETTE'
    Then I am on the 'STANTON-GOYETTE' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |
      | STANTON-GOYETTE          | http://lakin.example/lavinia           |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |
      | STANTON-GOYETTE          | http://lakin.example/lavinia           |
