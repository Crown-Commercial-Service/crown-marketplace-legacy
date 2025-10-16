Feature: Management Consultancy - Lot 9 - Environmental Sustainability and Socio-economic Development - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 9 - Environmental Sustainability and Socio-economic Development'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 9 - Environmental Sustainability and Socio-economic Development'
    Then I should see the following options for the lot:
      | Air quality                                  |
      | Carbon management (including reporting)      |
      | Climate change adaptation and/or mitigation  |
      | Coastal                                      |
      | Contaminated land                            |
      | Due diligence                                |
      | Ecology and biodiversity                     |
      | Environmental planning and protection        |
      | Equality analysis                            |
      | Feasibility studies and/or impact assessment |
      | Monitoring environmental indicators          |
      | Natural capital                              |
      | Natural resource management                  |
      | Policy development and/or implementation     |
      | Pollution control (including noise)          |
      | Regulatory compliance                        |
      | Risk management                              |
      | Social value                                 |
      | Sustainability                               |
