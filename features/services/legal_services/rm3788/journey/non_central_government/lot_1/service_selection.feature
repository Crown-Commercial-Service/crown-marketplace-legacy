@javascript
Feature: Legal services - Non central governemnt - Lot 1 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'

  @pipeline
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Child law                       |
      | Court of protection             |
      | Debt recovery                   |
      | Education                       |
      | Employment                      |
      | Healthcare                      |
      | Intellectual property           |
      | Licensing                       |
      | Litigation / dispute resolution |
      | Pensions                        |
      | Planning and environment        |
      | Primary care                    |
      | Property and construction       |
      | Social housing                  |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Child law'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law             |
    When I check the following items:
      | Court of protection   |
      | Debt recovery         |
      | Education             |
      | Employment            |
      | Healthcare            |
      | Intellectual property |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law             |
      | Court of protection   |
      | Debt recovery         |
      | Education             |
      | Employment            |
      | Healthcare            |
      | Intellectual property |

  @pipeline
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Child law                       |
      | Education                       |
      | Healthcare                      |
      | Licensing                       |
      | Litigation / dispute resolution |
      | Pensions                        |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                       |
      | Education                       |
      | Healthcare                      |
      | Licensing                       |
      | Litigation / dispute resolution |
      | Pensions                        |
    When I deselect the following items:
      | Licensing |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                       |
      | Education                       |
      | Healthcare                      |
      | Litigation / dispute resolution |
      | Pensions                        |
    When I remove the following items from the basket:
      | Education                       |
      | Litigation / dispute resolution |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                       |
      | Healthcare                      |
      | Pensions                        |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Child law                         |
      | Education                         |
      | Planning and environment          |
      | Licensing                         |
      | Litigation / dispute resolution   |
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Planning and environment        |
      | Child law                       |
      | Education                       |
      | Litigation / dispute resolution |
      | Licensing                       |
