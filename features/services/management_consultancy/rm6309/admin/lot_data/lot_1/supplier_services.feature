Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - Services

  Background: Go to services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'NIENOW-KERTZMANN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'NIENOW-KERTZMANN'
    And I click on 'View services' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business View services' page
    And the caption is 'NIENOW-KERTZMANN'
    And the supplier should be assigned to the 'services' as follows:
      | Automation                                                                       |
      | Business case development                                                        |
      | Business consultancy                                                             |
      | Business policy development and/or appraisal                                     |
      | Business processes                                                               |
      | Business strategy                                                                |
      | Change management                                                                |
      | Digital, technology and cyber                                                    |
      | Innovation, growth and business models                                           |
      | Operational planning and/or improvement, including Target Operating Models (TOM) |
      | Organisational design and review, Enterprise Resource Planning (ERP)             |
      | Value for money reviews                                                          |
    Given I click on 'Change (Services the supplier can offer)'
    Then I am on the 'Edit service selection' page
    And the caption is 'NIENOW-KERTZMANN'

  Scenario: Update services
    When I check the following items:
      | Programme and project management |
      | Risk, opportunity and compliance |
    When I deselect the following items:
      | Business policy development and/or appraisal |
      | Business processes                           |
      | Business strategy                            |
    Then I click on 'Save and return'
    Then I am on the 'Lot 1 - Business View services' page
    And the caption is 'NIENOW-KERTZMANN'
    And the supplier should be assigned to the 'services' as follows:
      | Automation                                                                       |
      | Business case development                                                        |
      | Business consultancy                                                             |
      | Change management                                                                |
      | Digital, technology and cyber                                                    |
      | Innovation, growth and business models                                           |
      | Operational planning and/or improvement, including Target Operating Models (TOM) |
      | Organisational design and review, Enterprise Resource Planning (ERP)             |
      | Programme and project management                                                 |
      | Risk, opportunity and compliance                                                 |
      | Value for money reviews                                                          |

  Scenario: Remove all services
    When I deselect the following items:
      | Automation                                                                       |
      | Business case development                                                        |
      | Business consultancy                                                             |
      | Business policy development and/or appraisal                                     |
      | Business processes                                                               |
      | Business strategy                                                                |
      | Change management                                                                |
      | Digital, technology and cyber                                                    |
      | Innovation, growth and business models                                           |
      | Operational planning and/or improvement, including Target Operating Models (TOM) |
      | Organisational design and review, Enterprise Resource Planning (ERP)             |
      | Value for money reviews                                                          |
    Then I click on 'Save and return'
    Then I am on the 'Lot 1 - Business View services' page
    And the caption is 'NIENOW-KERTZMANN'
    And the supplier should not be assigned any 'services' with the following message:
      | The supplier does not offer any services in this lot |
