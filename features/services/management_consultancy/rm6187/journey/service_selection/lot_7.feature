Feature: Management Consultancy - Lot 7 - Health, Social Care and Community - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 7 - Health, Social Care and Community'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 7 - Health, Social Care and Community'
    Then I should see the following options for the lot:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Capability development                                      |
      | Charity/third sector improvement review                     |
      | Clinical evaluations                                        |
      | Commissioning models                                        |
      | Community services                                          |
      | Digital, technology and cyber                               |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare services                                         |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Mental healthcare                                           |
      | Planning for health, social care and community              |
      | Policing and security                                       |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Regeneration                                                |
      | Safeguarding                                                |
      | Social care services                                        |
      | Strategy and policy                                         |
