Feature: Legal Panel for Government - Non central governemnt - Lot 1 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Core Legal Services'
    When I check the following items:
      | Assimilated Law       |
      | Aviation and Airports |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Charities'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Going back from a supplier
    And I click on 'CORMIER INC'
    Then I am on the 'CORMIER INC' page
    And the sub title is 'Lot 1 - Core Legal Services'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |
