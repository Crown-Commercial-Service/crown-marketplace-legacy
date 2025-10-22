Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'TREMBLAY-MOORE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'TREMBLAY-MOORE'
    And I click on 'View services' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business - Services' page
    And the caption is 'TREMBLAY-MOORE'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                          | Has service? |
      | Business case development                             | Yes          |
      | Business consultancy                                  | No           |
      | Business continuity and/or disaster recovery planning | Yes          |
      | Business policy strategy and/or appraisal             | Yes          |
      | Business processes                                    | Yes          |
      | Change management                                     | Yes          |
      | Development and/or review of policy                   | No           |
      | Digital, technology and cyber                         | Yes          |
      | Forecasting and/or planning                           | Yes          |
      | Operational planning and/or improvement               | Yes          |
      | Organisational review                                 | Yes          |
      | Programme & project management                        | Yes          |
      | Risk, compliance and/or opportunity management        | Yes          |
      | Value for money reviews                               | Yes          |
