Feature: Management Consultancy - Admin - Supplier details - Additional information

  Scenario: Additional information can be updated
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'VANDERVORT, KOVACEK AND MORAR'
    Then I am on the 'Supplier details' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And I should see the following details in the 'Additional information' summary:
      | Address | 6632 Rodolfo Highway, Port Caryton, IA 90303-6001 |
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And I enter the following details into the form:
      | Address | The North, St Helens |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And I should see the following details in the 'Additional information' summary:
      | Address | The North, St Helens |
