Feature: Management Consultancy - Admin - Supplier lot data - Lot 3 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GREENFELDER-LEUSCHKE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And I click on 'View services' for the lot 'Lot 3 - Complex and Transformation'
    Then I am on the 'Lot 3 - Complex and Transformation View services' page
    And the caption is 'GREENFELDER-LEUSCHKE'
    And the supplier should be assigned to the 'services' as follows:
      | Business                                                    |
      | Change management                                           |
      | Complex programmes                                          |
      | Delivery partner                                            |
      | Digital, technology and cyber                               |
      | Finance                                                     |
      | HR                                                          |
      | Organisation design including Target Operating Models (TOM) |
      | Performance transformation                                  |
      | Procurement and/or supply chain                             |
      | Programme and project management                            |
      | Strategy and/or policy                                      |
      | Supplier side services and delivery                         |
      | Transformation management                                   |
