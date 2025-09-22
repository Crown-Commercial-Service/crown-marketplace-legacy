Feature: Management Consultancy - Admin - Supplier lot data - Lot 7 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BATZ, BROWN AND BREITENBERG'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BATZ, BROWN AND BREITENBERG'
    And I click on 'View services' for the lot 'Lot 7 - Health, Social Care and Community'
    Then I am on the 'Lot 7 - Health, Social Care and Community - Services' page
    And the caption is 'BATZ, BROWN AND BREITENBERG'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                                | Has service? |
      | Alternative delivery models                                 | Yes          |
      | Business case development                                   | Yes          |
      | Capability development                                      | Yes          |
      | Charity/third sector improvement review                     | Yes          |
      | Clinical evaluations                                        | Yes          |
      | Commissioning models                                        | Yes          |
      | Community services                                          | No           |
      | Digital, technology and cyber                               | Yes          |
      | Healthcare operational review, improvement and/or modelling | Yes          |
      | Healthcare services                                         | Yes          |
      | Healthcare transformation, change and delivery              | Yes          |
      | Housing                                                     | Yes          |
      | Mental healthcare                                           | Yes          |
      | Planning for health, social care and community              | No           |
      | Policing and security                                       | No           |
      | Programme and project management                            | Yes          |
      | Public service improvement review                           | Yes          |
      | Regeneration                                                | Yes          |
      | Safeguarding                                                | Yes          |
      | Social care services                                        | Yes          |
      | Strategy and policy                                         | Yes          |
