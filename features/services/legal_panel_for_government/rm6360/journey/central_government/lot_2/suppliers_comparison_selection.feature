@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 2 - Suppliers comparison selection

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
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
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | ADAMS, WOLFF AND STROMAN |
      | BALISTRERI-MURAZIK       |
      | CORMIER INC              |
      | MONAHAN-JOHNS            |

  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'ADAMS, WOLFF AND STROMAN'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
    When I check the following items:
      | BALISTRERI-MURAZIK |
      | CORMIER INC        |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | BALISTRERI-MURAZIK       |
      | CORMIER INC              |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | BALISTRERI-MURAZIK       |
      | CORMIER INC              |
      | MONAHAN-JOHNS            |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | BALISTRERI-MURAZIK       |
      | CORMIER INC              |
      | MONAHAN-JOHNS            |
    When I deselect the following items:
      | ADAMS, WOLFF AND STROMAN |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | BALISTRERI-MURAZIK |
      | CORMIER INC        |
      | MONAHAN-JOHNS      |
    When I remove the following items from the basket:
      | BALISTRERI-MURAZIK |
      | CORMIER INC        |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | MONAHAN-JOHNS |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | BALISTRERI-MURAZIK       |
      | CORMIER INC              |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | BALISTRERI-MURAZIK       |
      | CORMIER INC              |
