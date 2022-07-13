@javascript @pipeline
Feature: Legal services - Central governemnt - fees under £20,000 - region selection

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
    And I check the following items:
      | Litigation / dispute resolution |
      | Property and construction       |
    When I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And the sub title is 'Lot 1 - Regional service provision'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | North East                |
      | North West                |
      | Yorkshire and The Humber  |
      | East Midlands             |
      | West Midlands             |
      | East of England           |
      | London                    |
      | South East                |
      | South West                |
      | Wales                     |
      | Scotland                  |
      | Northern Ireland          |
      | Full national coverage    |

  Scenario: Region selection appears in basked
    Then the basket should say 'No regions selected'
    And the remove all link should not be visible
    When I check 'North East'
    Then the basket should say '1 region selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | North East                |
    When I check the following items:
      | North West                |
      | Yorkshire and The Humber  |
      | East Midlands             |
      | West Midlands             |
      | East of England           |
      | London                    |
    Then the basket should say '7 regions selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | North East                |
      | North West                |
      | Yorkshire and The Humber  |
      | East Midlands             |
      | West Midlands             |
      | East of England           |
      | London                    |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Yorkshire and The Humber  |
      | West Midlands             |
      | East of England           |
      | South West                |
      | Wales                     |
      | Scotland                  |
    Then the basket should say '6 regions selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Yorkshire and The Humber  |
      | West Midlands             |
      | East of England           |
      | South West                |
      | Wales                     |
      | Scotland                  |
    When I deselect the following items:
      | South West                |
    Then the basket should say '5 regions selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Yorkshire and The Humber  |
      | West Midlands             |
      | East of England           |
      | Wales                     |
      | Scotland                  |
    When I remove the following items from the basket:
      | West Midlands             |
      | Wales                     |
    Then the basket should say '3 regions selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Yorkshire and The Humber  |
      | East of England           |
      | Scotland                  |
    When I click on 'Remove all'
    Then the basket should say 'No regions selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Yorkshire and The Humber  |
      | West Midlands             |
      | South West                |
      | Wales                     |
      | Northern Ireland          |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the regions where you need legal services' page
    And the following items should appear in the basket:
      | Yorkshire and The Humber  |
      | West Midlands             |
      | South West                |
      | Wales                     |
      | Northern Ireland          |
