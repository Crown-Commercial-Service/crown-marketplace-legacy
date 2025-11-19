Feature: Management Consultancy - Admin - Supplier lot data - Lot 2 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BERNHARD INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BERNHARD INC'
    And I click on 'View services' for the lot 'Lot 2 - Strategy and Policy'
    Then I am on the 'Lot 2 - Strategy and Policy View services' page
    And the caption is 'BERNHARD INC'
    And the supplier should be assigned to the 'services' as follows:
      | Business case development       |
      | Business process re-engineering |
      | Business structure              |
      | Digital, technology and cyber   |
      | Regulatory advice               |
