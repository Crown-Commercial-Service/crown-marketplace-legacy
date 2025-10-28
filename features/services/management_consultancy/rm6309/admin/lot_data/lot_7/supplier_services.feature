Feature: Management Consultancy - Admin - Supplier lot data - Lot 7 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'STROMAN-ROMAGUERA'
    Then I am on the 'Supplier lot data' page
    And the caption is 'STROMAN-ROMAGUERA'
    And I click on 'View services' for the lot 'Lot 7 - Health, Social Care and Community'
    Then I am on the 'Lot 7 - Health, Social Care and Community View services' page
    And the caption is 'STROMAN-ROMAGUERA'
    And the supplier should be assigned to the 'services' as follows:
      | Alternative delivery models                    |
      | Business case development                      |
      | Capability development                         |
      | Community services                             |
      | Healthcare transformation, change and delivery |
      | Housing                                        |
      | Not for profit                                 |
      | Planning for health, social care and community |
      | Programme and project management               |
      | Social care and safeguarding                   |
      | Social mobility and levelling up               |
      | Sport, leisure and culture                     |
