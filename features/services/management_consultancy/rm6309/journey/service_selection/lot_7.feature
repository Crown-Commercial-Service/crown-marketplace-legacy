@javascript
Feature: Management Consultancy - Lot 7 - Health, Social Care and Community - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 7 - Health, Social Care and Community'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 7 - Health, Social Care and Community'
  
  Scenario: The correct options are available
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
      | Not for profit                                              |
      | Sport, leisure and culture                                  |
      | Digital, technology and cyber                               |
      | Healthcare operational review, improvement and/or modelling |
      | Mental healthcare                                           |
      | Planning for health, social care and community              |
      | Public service improvement review                           |
      | Social mobility and levelling up                            |
    Then the basket should say '11 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models |
      | Business case development                                   |
      | Capability development                                      |
      | Not for profit                                              |
      | Sport, leisure and culture                                  |
      | Digital, technology and cyber                               |
      | Healthcare operational review, improvement and/or modelling |
      | Mental healthcare                                           |
      | Planning for health, social care and community              |
      | Public service improvement review                           |
      | Social mobility and levelling up                            |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Social care and safeguarding                                |
      | Social mobility and levelling up                            |
    Then the basket should say '10 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Social care and safeguarding                                |
      | Social mobility and levelling up                            |
    When I deselect the following items:
      | Social care and safeguarding                                |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models                                 |
      | Business case development                                   |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
      | Social mobility and levelling up                            |
    When I remove the following items from the basket:
      | Business case development         |
      | Social mobility and levelling up  |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Alternative delivery models                                 |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Planning for health, social care and community              |
      | Programme and project management                            |
      | Public service improvement review                           |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Business case development                                   |
      | Capability development                                      |
      | Sport, leisure and culture                                  |
      | Digital, technology and cyber                               |
      | Healthcare operational review, improvement and/or modelling |
      | Healthcare transformation, change and delivery              |
      | Housing                                                     |
      | Security and welfare                                        |
      | Public service improvement review                           |
      | Regeneration                                                |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Business case development                                   |
      | Digital, technology and cyber                               |
      | Security and welfare                                        |
      | Public service improvement review                           |
      | Regeneration                                                |
      | Housing                                                     |
      | Healthcare transformation, change and delivery              |
      | Sport, leisure and culture                                  |
      | Capability development                                      |
      | Healthcare operational review, improvement and/or modelling |
