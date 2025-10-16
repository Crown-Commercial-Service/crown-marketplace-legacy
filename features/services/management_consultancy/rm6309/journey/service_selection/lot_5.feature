Feature: Management Consultancy - Lot 5 - HR - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 5 - HR'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 5 - HR'
    Then I should see the following options for the lot:
      | Capability development                                |
      | Cultural transformation                               |
      | Equality, diversity and inclusion                     |
      | HR functions, process and design                      |
      | HR policy and strategy                                |
      | Organisational design and/or workforce planning       |
      | People and performance                                |
      | Recruitment, retention and employee value proposition |
      | Training and development                              |
