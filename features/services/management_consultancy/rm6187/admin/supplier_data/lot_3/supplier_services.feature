Feature: Management Consultancy - Admin - Supplier lot data - Lot 3 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'ROMAGUERA INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'ROMAGUERA INC'
    And I click on 'View services' for the lot 'Lot 3 - Complex and Transformation'
    Then I am on the 'Lot 3 - Complex and Transformation - Services' page
    And the caption is 'ROMAGUERA INC'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                        | Has service? |
      | Business                            | Yes          |
      | Change management                   | Yes          |
      | Complex programmes                  | Yes          |
      | Digital, technology and cyber       | Yes          |
      | Finance                             | No           |
      | HR                                  | Yes          |
      | Organisation and operating model    | Yes          |
      | Performance transformation          | Yes          |
      | Procurement and/or supply chain     | Yes          |
      | Project and programme management    | Yes          |
      | Strategy and/or policy              | Yes          |
      | Supplier side services and delivery | Yes          |
      | Transformation management           | No           |
