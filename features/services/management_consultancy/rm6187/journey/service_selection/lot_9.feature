@javascript
Feature: Management Consultancy - Lot 9 - Environmental Sustainability and Socio-economic Development - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 9 - Environmental Sustainability and Socio-economic Development'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 9 - Environmental Sustainability and Socio-economic Development'
  
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Air quality                                   |
      | Carbon management (including reporting)       |
      | Climate change adaptation and/or mitigation   |
      | Coastal                                       |
      | Contaminated land                             |
      | Due diligence                                 |
      | Ecology and biodiversity                      |
      | Environmental planning and protection         |
      | Equality analysis                             |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural capital                               |
      | Natural resource management                   |
      | Policy development and/or implementation      |
      | Pollution control (including noise)           |
      | Regulatory compliance                         |
      | Risk management                               |
      | Social value                                  |
      | Sustainability                                |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Air quality'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Air quality |
    When I check the following items:
      | Carbon management (including reporting)       |
      | Contaminated land                             |
      | Ecology and biodiversity                      |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural capital                               |
      | Pollution control (including noise)           |
      | Social value                                  |
      | Sustainability                                |
    Then the basket should say '10 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Air quality |
      | Carbon management (including reporting)       |
      | Contaminated land                             |
      | Ecology and biodiversity                      |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural capital                               |
      | Pollution control (including noise)           |
      | Social value                                  |
      | Sustainability                                |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Air quality                                   |
      | Ecology and biodiversity                      |
      | Equality analysis                             |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural capital                               |
      | Natural resource management                   |
      | Risk management                               |
      | Social value                                  |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Air quality                                   |
      | Ecology and biodiversity                      |
      | Equality analysis                             |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural capital                               |
      | Natural resource management                   |
      | Risk management                               |
      | Social value                                  |
    When I deselect the following items:
      | Air quality |
    Then the basket should say '8 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Ecology and biodiversity                      |
      | Equality analysis                             |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural capital                               |
      | Natural resource management                   |
      | Risk management                               |
      | Social value                                  |
    When I remove the following items from the basket:
      | Natural capital           |
      | Ecology and biodiversity  |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Equality analysis                             |
      | Feasibility studies and/or impact assessment  |
      | Monitoring environmental indicators           |
      | Natural resource management                   |
      | Risk management                               |
      | Social value                                  |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Air quality                                 |
      | Climate change adaptation and/or mitigation |
      | Due diligence                               |
      | Environmental planning and protection       |
      | Monitoring environmental indicators         |
      | Natural resource management                 |
      | Policy development and/or implementation    |
      | Pollution control (including noise)         |
      | Sustainability                              |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Environmental planning and protection       |
      | Natural resource management                 |
      | Sustainability                              |
      | Air quality                                 |
      | Pollution control (including noise)         |
      | Policy development and/or implementation    |
      | Monitoring environmental indicators         |
      | Climate change adaptation and/or mitigation |
      | Due diligence                               |
