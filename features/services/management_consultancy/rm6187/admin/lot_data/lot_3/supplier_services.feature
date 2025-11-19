Feature: Management Consultancy - Admin - Supplier lot data - Lot 3 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'ROMAGUERA INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'ROMAGUERA INC'
    And I click on 'View services' for the lot 'Lot 3 - Complex and Transformation'
    Then I am on the 'Lot 3 - Complex and Transformation View services' page
    And the caption is 'ROMAGUERA INC'
    And the supplier should be assigned to the 'services' as follows:
      | Business                            |
      | Change management                   |
      | Complex programmes                  |
      | Digital, technology and cyber       |
      | HR                                  |
      | Organisation and operating model    |
      | Performance transformation          |
      | Procurement and/or supply chain     |
      | Project and programme management    |
      | Strategy and/or policy              |
      | Supplier side services and delivery |
