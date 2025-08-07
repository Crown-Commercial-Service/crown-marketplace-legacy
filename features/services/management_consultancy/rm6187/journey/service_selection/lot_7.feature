@javascript
Feature: Management Consultancy - Lot 7 - Health, Social Care and Community - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 7 - Health, Social Care and Community'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 7 - Health, Social Care and Community'
  
  Scenario: The correct options are available
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

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Alternative delivery models'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models |
    When I check the following items:
      | Business case development                                   |
      | Capability development                                      |
      | Charity/third sector improvement review                     |
      | Clinical evaluations                                        |
      | Digital, technology and cyber                               |
      | Healthcare operational review, improvement and/or modelling |
      | Mental healthcare                                           |
      | Planning for health, social care and community              |
      | Public service improvement review                           |
      | Social care services                                        |
    Then the basket should say '11 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models |
      | Business case development                                   |
      | Capability development                                      |
      | Charity/third sector improvement review                     |
      | Clinical evaluations                                        |
      | Digital, technology and cyber                               |
      | Healthcare operational review, improvement and/or modelling |
      | Mental healthcare                                           |
      | Planning for health, social care and community              |
      | Public service improvement review                           |
      | Social care services                                        |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare services                                         |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Safeguarding                                                |
      | Social care services                                        |
    Then the basket should say '10 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare services                                         |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Safeguarding                                                |
      | Social care services                                        |
    When I deselect the following items:
      | Safeguarding |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare services                                         |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Social care services                                        |
    When I remove the following items from the basket:
      | Business case development |
      | Social care services      |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models                                 |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare services                                         |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Business case development                       |
      | Capability development                          |
      | Clinical evaluations                            |
      | Digital, technology and cyber                   |
      | Healthcare services                             |
      | Healthcare transformation, change and delivery  |
      | Housing                                         |
      | Policing and security                           |
      | Public service improvement review               |
      | Regeneration                                    |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Business case development                       |
      | Digital, technology and cyber                   |
      | Policing and security                           |
      | Public service improvement review               |
      | Regeneration                                    |
      | Housing                                         |
      | Healthcare transformation, change and delivery  |
      | Clinical evaluations                            |
      | Capability development                          |
      | Healthcare services                             |
