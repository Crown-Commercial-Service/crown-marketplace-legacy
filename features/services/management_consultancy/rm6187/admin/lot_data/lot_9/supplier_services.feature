Feature: Management Consultancy - Admin - Supplier lot data - Lot 9 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SCHUSTER, LEHNER AND KSHLERIN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SCHUSTER, LEHNER AND KSHLERIN'
    And I click on 'View services' for the lot 'Lot 9 - Environmental Sustainability and Socio-economic Development'
    Then I am on the 'Lot 9 - Environmental Sustainability and Socio-economic Development View services' page
    And the caption is 'SCHUSTER, LEHNER AND KSHLERIN'
    And the supplier should be assigned to the 'services' as follows:
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
