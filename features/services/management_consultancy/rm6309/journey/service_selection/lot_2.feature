Feature: Management Consultancy - Lot 2 - Strategy and Policy - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 2 - Strategy and Policy'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 2 - Strategy and Policy'

    Then I should see the following options for the lot:
      | Business case development       |
      | Business process re-engineering |
      | Business structure              |
      | Change management               |
      | Digital, technology and cyber   |
      | Future planning                 |
      | Game plan                       |
      | Policy                          |
      | Regulatory advice               |
      | Social value                    |
      | Strategic advice                |
      | Strategy                        |
