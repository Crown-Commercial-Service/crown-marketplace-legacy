Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - Services

  Background: Go to services
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
    Given I click on 'Change (Services the supplier can offer)'
    Then I am on the 'Edit service selection' page
    And the caption is 'TREMBLAY-MOORE'

  Scenario: Update services
    When I deselect the following items:
      | Business policy strategy and/or appraisal |
      | Digital, technology and cyber             |
      | Programme & project management            |
    Then I click on 'Save and return'
    Then I am on the 'Lot 1 - Business View services' page
    And the caption is 'TREMBLAY-MOORE'
    And the supplier should be assigned to the 'services' as follows:
      | Business case development                             |
      | Business continuity and/or disaster recovery planning |
      | Business processes                                    |
      | Change management                                     |
      | Forecasting and/or planning                           |
      | Operational planning and/or improvement               |
      | Organisational review                                 |
      | Risk, compliance and/or opportunity management        |
      | Value for money reviews                               |

  Scenario: Remove all services
    When I deselect the following items:
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
    Then I click on 'Save and return'
    Then I am on the 'Lot 1 - Business View services' page
    And the caption is 'TREMBLAY-MOORE'
    And the supplier should not be assigned any 'services' with the following message:
      | The supplier does not offer any services in this lot |
