Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'TREMBLAY-MOORE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'TREMBLAY-MOORE'
    And I click on 'View services' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business View services' page
    And the caption is 'TREMBLAY-MOORE'
    And the supplier should be assigned to the 'services' as follows:
      | Business case development                             |
      | Business continuity and/or disaster recovery planning |
      | Business policy strategy and/or appraisal             |
      | Business processes                                    |
      | Change management                                     |
      | Digital, technology and cyber                         |
      | Forecasting and/or planning                           |
      | Operational planning and/or improvement               |
      | Organisational review                                 |
      | Programme & project management                        |
      | Risk, compliance and/or opportunity management        |
      | Value for money reviews                               |
