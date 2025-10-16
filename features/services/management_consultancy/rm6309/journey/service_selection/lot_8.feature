Feature: Management Consultancy - Lot 8 - Infrastructure - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 8 - Infrastructure'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 8 - Infrastructure'
    Then I should see the following options for the lot:
      | Aerospace                                    |
      | Automotive                                   |
      | Aviation                                     |
      | Communications and technology infrastructure |
      | Defence                                      |
      | Highways                                     |
      | Nuclear                                      |
      | Ports and shipping                           |
      | Public transport                             |
      | Rail                                         |
      | Smart infrastructure                         |
      | Towns, cities and rural areas                |
      | Travel, transportation and logistics         |
