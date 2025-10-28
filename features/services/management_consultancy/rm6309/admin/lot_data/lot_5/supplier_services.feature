Feature: Management Consultancy - Admin - Supplier lot data - Lot 5 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SCHINNER-LAKIN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SCHINNER-LAKIN'
    And I click on 'View services' for the lot 'Lot 5 - HR'
    Then I am on the 'Lot 5 - HR View services' page
    And the caption is 'SCHINNER-LAKIN'
    And the supplier should be assigned to the 'services' as follows:
      | Capability development                                |
      | Cultural transformation                               |
      | HR functions, process and design                      |
      | Organisational design and/or workforce planning       |
      | People and performance                                |
      | Recruitment, retention and employee value proposition |
