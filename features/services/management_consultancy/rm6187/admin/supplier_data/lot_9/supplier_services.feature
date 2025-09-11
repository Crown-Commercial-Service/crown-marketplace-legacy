Feature: Management Consultancy - Admin - Supplier lot data - Lot 9 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SCHUSTER, LEHNER AND KSHLERIN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SCHUSTER, LEHNER AND KSHLERIN'
    And I click on 'View services' for the lot 'Lot 9 - Environmental Sustainability and Socio-economic Development'
    Then I am on the 'Lot 9 - Environmental Sustainability and Socio-economic Development - Services' page
    And the caption is 'SCHUSTER, LEHNER AND KSHLERIN'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                 | Has service? |
      | Air quality                                  | Yes          |
      | Carbon management (including reporting)      | Yes          |
      | Climate change adaptation and/or mitigation  | Yes          |
      | Coastal                                      | Yes          |
      | Contaminated land                            | Yes          |
      | Due diligence                                | Yes          |
      | Ecology and biodiversity                     | Yes          |
      | Environmental planning and protection        | Yes          |
      | Equality analysis                            | Yes          |
      | Feasibility studies and/or impact assessment | Yes          |
      | Monitoring environmental indicators          | Yes          |
      | Natural capital                              | Yes          |
      | Natural resource management                  | Yes          |
      | Policy development and/or implementation     | Yes          |
      | Pollution control (including noise)          | Yes          |
      | Regulatory compliance                        | Yes          |
      | Risk management                              | Yes          |
      | Social value                                 | Yes          |
      | Sustainability                               | Yes          |
