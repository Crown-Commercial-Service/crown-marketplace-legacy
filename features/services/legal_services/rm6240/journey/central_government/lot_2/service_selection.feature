@javascript
Feature: Legal services - Central governemnt - Lot 2 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'

  @pipeline
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
    When I check 'Education Law'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Education Law             |
    When I check the following items:
      | Employment                |
      | Planning and Environment  |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Education Law             |
      | Employment                |
      | Planning and Environment  |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Education Law             |
      | Employment                |
      | Planning and Environment  |
      | Social Housing            |
    Then the basket should say '4 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Education Law             |
      | Employment                |
      | Planning and Environment  |
      | Social Housing            |
    When I deselect the following items:
      | Employment                |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Education Law             |
      | Planning and Environment  |
      | Social Housing            |
    When I remove the following items from the basket:
      | Education Law             |
      | Social Housing            |
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Planning and Environment  |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from jurisdiction and change selection
    When I check the following items:
      | Employment                |
      | Planning and Environment  |
      | Social Housing            |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Employment                |
      | Planning and Environment  |
      | Social Housing            |
