@javascript
Feature: Management Consultancy - Lot 9 - Environment and Sustainability - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 9 - Environment and Sustainability'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 9 - Environment and Sustainability'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Air quality                                                    |
      | Carbon net zero and/or carbon management (including reporting) |
      | Climate change adaptation and/or mitigation                    |
      | Coastal                                                        |
      | Contaminated land and water                                    |
      | Due diligence                                                  |
      | Environmental planning and protection                          |
      | Environmental, social and governance (ESG)                     |
      | Feasibility studies and/or impact assessment                   |
      | Life sciences                                                  |
      | Monitoring environmental indicators                            |
      | Natural capital                                                |
      | Natural resource management                                    |
      | Policy development and/or implementation                       |
      | Pollution control (including noise)                            |
      | Regulatory compliance                                          |
      | Sustainability                                                 |
      | Waste management                                               |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Air quality'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Air quality |
    When I check the following items:
      | Life sciences                                |
      | Monitoring environmental indicators          |
      | Policy development and/or implementation     |
      | Regulatory compliance                        |
      | Waste management                             |
      | Climate change adaptation and/or mitigation  |
      | Contaminated land and water                  |
      | Environmental planning and protection        |
      | Feasibility studies and/or impact assessment |
    Then the basket should say '10 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Air quality                                  |
      | Life sciences                                |
      | Monitoring environmental indicators          |
      | Policy development and/or implementation     |
      | Regulatory compliance                        |
      | Waste management                             |
      | Climate change adaptation and/or mitigation  |
      | Contaminated land and water                  |
      | Environmental planning and protection        |
      | Feasibility studies and/or impact assessment |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Air quality                                |
      | Monitoring environmental indicators        |
      | Natural capital                            |
      | Policy development and/or implementation   |
      | Regulatory compliance                      |
      | Waste management                           |
      | Coastal                                    |
      | Due diligence                              |
      | Environmental, social and governance (ESG) |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Air quality                                |
      | Monitoring environmental indicators        |
      | Natural capital                            |
      | Policy development and/or implementation   |
      | Regulatory compliance                      |
      | Waste management                           |
      | Coastal                                    |
      | Due diligence                              |
      | Environmental, social and governance (ESG) |
    When I deselect the following items:
      | Air quality |
    Then the basket should say '8 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Monitoring environmental indicators        |
      | Natural capital                            |
      | Policy development and/or implementation   |
      | Regulatory compliance                      |
      | Waste management                           |
      | Coastal                                    |
      | Due diligence                              |
      | Environmental, social and governance (ESG) |
    When I remove the following items from the basket:
      | Natural capital  |
      | Waste management |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Monitoring environmental indicators        |
      | Policy development and/or implementation   |
      | Regulatory compliance                      |
      | Coastal                                    |
      | Due diligence                              |
      | Environmental, social and governance (ESG) |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Natural capital                                                |
      | Policy development and/or implementation                       |
      | Regulatory compliance                                          |
      | Environmental planning and protection                          |
      | Waste management                                               |
      | Carbon net zero and/or carbon management (including reporting) |
      | Climate change adaptation and/or mitigation                    |
      | Natural resource management                                    |
      | Due diligence                                                  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Natural capital                                                |
      | Policy development and/or implementation                       |
      | Environmental planning and protection                          |
      | Natural resource management                                    |
      | Waste management                                               |
      | Carbon net zero and/or carbon management (including reporting) |
      | Climate change adaptation and/or mitigation                    |
      | Due diligence                                                  |
      | Regulatory compliance                                          |
