@javascript
Feature: Legal services - Non central governemnt - Lot 2 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Child Law                       |
      | Court of Protection             |
      | Debt Recovery                   |
      | Education Law                   |
      | Employment                      |
      | Healthcare                      |
      | Intellectual Property           |
      | Licensing                       |
      | Litigation / Dispute Resolution |
      | Mental Health Law               |
      | Pensions                        |
      | Planning and Environment        |
      | Primary Care                    |
      | Property and Construction       |
      | Social Housing                  |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Child Law'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child Law                           |
    When I check the following items:
      | Court of Protection             |
      | Employment                      |
      | Litigation / Dispute Resolution |
      | Mental Health Law               |
      | Planning and Environment        |
      | Social Housing                  |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child Law                           |
      | Court of Protection             |
      | Employment                      |
      | Litigation / Dispute Resolution |
      | Mental Health Law               |
      | Planning and Environment        |
      | Social Housing                  |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Debt Recovery                   |
      | Education Law                   |
      | Healthcare                      |
      | Intellectual Property           |
      | Licensing                       |
      | Pensions                        |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Debt Recovery                   |
      | Education Law                   |
      | Healthcare                      |
      | Intellectual Property           |
      | Licensing                       |
      | Pensions                        |
    When I deselect the following items:
      | Education Law                   |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Debt Recovery                   |
      | Healthcare                      |
      | Intellectual Property           |
      | Licensing                       |
      | Pensions                        |
    When I remove the following items from the basket:
      | Intellectual Property           |
      | Licensing                       |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Debt Recovery                   |
      | Healthcare                      |
      | Pensions                        |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from jurisdiction and change selection
    When I check the following items:
      | Child Law                       |
      | Licensing                       |
      | Social Housing                  |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Child Law                       |
      | Licensing                       |
      | Social Housing                  |
