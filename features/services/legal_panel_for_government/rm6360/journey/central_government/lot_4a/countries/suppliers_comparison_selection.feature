Feature: Legal Panel for Government - Non central governemnt - Lot 4a - Suppliers comparison selection - Countries

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
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Assimilated Law |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |
      | STANTON-GOYETTE          | http://lakin.example/lavinia           |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Have you reviewed the suppliers’ prospectus to inform your down-selection?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
      | O'CONNER AND SONS        |
      | STANTON-GOYETTE          |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No suppliers selected'
    And the remove all link should not be visible
    When I check 'ADAMS, WOLFF AND STROMAN'
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
    When I check the following items:
      | CROOKS AND SONS        |
      | DICKI, QUITZON AND KUB |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
      | O'CONNER AND SONS        |
    Then the basket should say '4 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
      | O'CONNER AND SONS        |
    When I deselect the following items:
      | ADAMS, WOLFF AND STROMAN |
    Then the basket should say '3 suppliers selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | CROOKS AND SONS        |
      | DICKI, QUITZON AND KUB |
      | O'CONNER AND SONS      |
    When I remove the following items from the basket:
      | CROOKS AND SONS        |
      | DICKI, QUITZON AND KUB |
    Then the basket should say '1 supplier selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | O'CONNER AND SONS |
    When I click on 'Remove all'
    Then the basket should say 'No suppliers selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And the following items should appear in the basket:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
