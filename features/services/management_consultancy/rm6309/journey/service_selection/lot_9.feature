Feature: Management Consultancy - Lot 9 - Environment and Sustainability - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 9 - Environment and Sustainability'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 9 - Environment and Sustainability'
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
