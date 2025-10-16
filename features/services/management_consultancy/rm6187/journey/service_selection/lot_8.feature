Feature: Management Consultancy - Lot 8 - Infrastructure including Transport - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 8 - Infrastructure including Transport'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 8 - Infrastructure including Transport'
    Then I should see the following options for the lot:
      | Aviation                                       |
      | Communications and technology infrastructure   |
      | Highways                                       |
      | Ports and shipping                             |
      | Public transport (including buses and parking) |
      | Rail                                           |
      | Smart infrastructure                           |
      | Towns and cities                               |
