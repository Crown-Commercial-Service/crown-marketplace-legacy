Feature: Legal Panel for Government - Non central governemnt - Lot 2 - Results

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Major Projects and Complex Advice'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Major Projects and Complex Advice'
    When I check the following items:
      | Competition Law |
      | Contracts       |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://schoen.test/horacio              |
      | BALISTRERI-MURAZIK       | http://dubuque.test/soo_lockman         |
      | CORMIER INC              | http://mayer-willms.test/daphine        |
      | MONAHAN-JOHNS            | http://runolfsson.example/darrel.heaney |

  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And I deselect all the items
    Given I check 'Equity Capital Markets'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://schoen.test/horacio              |
      | BALISTRERI-MURAZIK       | http://dubuque.test/soo_lockman         |
      | CORMIER INC              | http://mayer-willms.test/daphine        |
      | CROOKS AND SONS          | http://padberg.example/romona.mcclure   |
      | MONAHAN-JOHNS            | http://runolfsson.example/darrel.heaney |
      | O'CONNER AND SONS        | http://upton-kris.example/jen           |

  Scenario: Going back from a supplier
    And I click on 'BALISTRERI-MURAZIK'
    Then I am on the 'BALISTRERI-MURAZIK' page
    And the sub title is 'Lot 2 - Major Projects and Complex Advice'
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://schoen.test/horacio              |
      | BALISTRERI-MURAZIK       | http://dubuque.test/soo_lockman         |
      | CORMIER INC              | http://mayer-willms.test/daphine        |
      | MONAHAN-JOHNS            | http://runolfsson.example/darrel.heaney |

  Scenario: Going back from downloading documents
    And I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on the 'Back' back link
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://schoen.test/horacio              |
      | BALISTRERI-MURAZIK       | http://dubuque.test/soo_lockman         |
      | CORMIER INC              | http://mayer-willms.test/daphine        |
      | MONAHAN-JOHNS            | http://runolfsson.example/darrel.heaney |
