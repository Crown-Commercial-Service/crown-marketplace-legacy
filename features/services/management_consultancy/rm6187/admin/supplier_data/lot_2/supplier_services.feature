Feature: Management Consultancy - Admin - Supplier lot data - Lot 2 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BERNHARD INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BERNHARD INC'
    And I click on 'View services' for the lot 'Lot 2 - Strategy and Policy'
    Then I am on the 'Lot 2 - Strategy and Policy - Services' page
    And the caption is 'BERNHARD INC'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                    | Has service? |
      | Business case development       | Yes          |
      | Business process re-engineering | Yes          |
      | Business structure              | Yes          |
      | Change management               | No           |
      | Digital, technology and cyber   | Yes          |
      | Policy                          | No           |
      | Regulatory advice               | Yes          |
      | Social value                    | No           |
      | Strategic advice                | No           |
