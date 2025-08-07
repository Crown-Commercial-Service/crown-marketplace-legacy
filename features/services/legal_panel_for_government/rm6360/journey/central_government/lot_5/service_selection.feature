@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 5 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 5 - Rail Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 5 - Rail Legal Services'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Competition law                                             |
      | Dispute Resolution and litigation law                       |
      | EU law                                                      |
      | Employment law                                              |
      | Environmental law                                           |
      | Health and Safety law                                       |
      | Information law including data protection law               |
      | Information technology law                                  |
      | Insurance law                                               |
      | Intellectual property law                                   |
      | International law                                           |
      | Pensions law                                                |
      | Planning law                                                |
      | Public procurement law                                      |
      | Rail Commercial Law                                         |
      | Real estate law                                             |
      | Regulatory law                                              |
      | Restructuring/ Insolvency law                               |
      | Subsidy Control Law                                         |
      | Tax law                                                     |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'EU law'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | EU law                      |
    When I check the following items:
      | Employment law              |
      | Information technology law  |
      | Insurance law               |
      | International law           |
      | Rail Commercial Law         |
      | Real estate law             |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | EU law                      |
      | Employment law              |
      | Information technology law  |
      | Insurance law               |
      | International law           |
      | Rail Commercial Law         |
      | Real estate law             |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Information law including data protection law |
      | Information technology law                    |
      | International law                             |
      | Planning law                                  |
      | Public procurement law                        |
      | Tax law                                       |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Information law including data protection law |
      | Information technology law                    |
      | International law                             |
      | Planning law                                  |
      | Public procurement law                        |
      | Tax law                                       |
    When I deselect the following items:
      | Tax law                                       |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Information law including data protection law |
      | Information technology law                    |
      | International law                             |
      | Planning law                                  |
      | Public procurement law                        |
    When I remove the following items from the basket:
      | Planning law                                  |
      | Public procurement law                        |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Information law including data protection law |
      | Information technology law                    |
      | International law                             |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | Health and Safety law                         |
      | Information law including data protection law |
      | Information technology law                    |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Health and Safety law                         |
      | Information law including data protection law |
      | Information technology law                    |
