@javascript @pipeline
Feature: Legal services - Central governemnt - fees under £20,000 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Litigation / dispute resolution |
      | Property and construction       |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Litigation / dispute resolution'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Litigation / dispute resolution |
    When I check the following items:
      | Property and construction       |
    Then the basket should say '2 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Litigation / dispute resolution |
      | Property and construction       |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Litigation / dispute resolution |
      | Property and construction       |
    Then the basket should say '2 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Litigation / dispute resolution |
      | Property and construction       |
    When I deselect the following items:
      | Litigation / dispute resolution |
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Property and construction       |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from regions page and change selection
    When I check the following items:
      | Property and construction |
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Property and construction |
