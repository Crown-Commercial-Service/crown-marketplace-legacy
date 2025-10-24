Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'NIENOW-KERTZMANN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'NIENOW-KERTZMANN'
    And I click on 'View services' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business - Services' page
    And the caption is 'NIENOW-KERTZMANN'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                                                     | Has service? |
      | Automation                                                                       | Yes          |
      | Business case development                                                        | Yes          |
      | Business consultancy                                                             | Yes          |
      | Business policy development and/or appraisal                                     | Yes          |
      | Business processes                                                               | Yes          |
      | Business strategy                                                                | Yes          |
      | Change management                                                                | Yes          |
      | Digital, technology and cyber                                                    | Yes          |
      | Innovation, growth and business models                                           | Yes          |
      | Operational planning and/or improvement, including Target Operating Models (TOM) | Yes          |
      | Organisational design and review, Enterprise Resource Planning (ERP)             | Yes          |
      | Programme and project management                                                 | No           |
      | Risk, opportunity and compliance                                                 | No           |
      | Value for money reviews                                                          | Yes          |
