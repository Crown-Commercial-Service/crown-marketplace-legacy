Feature: Management Consultancy - Admin - Supplier lot data - Lot 7 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'STROMAN-ROMAGUERA'
    Then I am on the 'Supplier lot data' page
    And the caption is 'STROMAN-ROMAGUERA'
    And I click on 'View services' for the lot 'Lot 7 - Health, Social Care and Community'
    Then I am on the 'Lot 7 - Health, Social Care and Community - Services' page
    And the caption is 'STROMAN-ROMAGUERA'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                                | Has service? |
      | Alternative delivery models                                 | Yes          |
      | Business case development                                   | Yes          |
      | Capability development                                      | Yes          |
      | Community services                                          | Yes          |
      | Digital, technology and cyber                               | No           |
      | Emergency services                                          | No           |
      | Healthcare operational review, improvement and/or modelling | No           |
      | Healthcare transformation, change and delivery              | Yes          |
      | Housing                                                     | Yes          |
      | Mental healthcare                                           | No           |
      | Not for profit                                              | Yes          |
      | Planning for health, social care and community              | Yes          |
      | Programme and project management                            | Yes          |
      | Public service improvement review                           | No           |
      | Regeneration                                                | No           |
      | Security and welfare                                        | No           |
      | Social care and safeguarding                                | Yes          |
      | Social mobility and levelling up                            | Yes          |
      | Sport, leisure and culture                                  | Yes          |
      | Strategy and/or policy                                      | No           |
