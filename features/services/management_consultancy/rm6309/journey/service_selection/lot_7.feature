Feature: Management Consultancy - Lot 7 - Health, Social Care and Community - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 7 - Health, Social Care and Community'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 7 - Health, Social Care and Community'
    Then I should see the following options for the lot:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Capability development                                      |
      | Community services                                          |
      | Digital, technology and cyber                               |
      | Emergency services                                          |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Mental healthcare                                           |
      | Not for profit                                              |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Regeneration                                                |
      | Security and welfare                                        |
      | Social care and safeguarding                                |
      | Social mobility and levelling up                            |
      | Sport, leisure and culture                                  |
      | Strategy and/or policy                                      |
