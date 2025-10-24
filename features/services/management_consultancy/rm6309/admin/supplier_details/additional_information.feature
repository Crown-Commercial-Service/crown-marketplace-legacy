Feature: Management Consultancy - Admin - Supplier details - Additional information

  Scenario: Additional information can be updated
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'TURCOTTE GROUP'
    Then I am on the 'Supplier details' page
    And the caption is 'TURCOTTE GROUP'
    And I should see the following details in the 'Additional information' summary:
      | Address | 58729 Johns Turnpike, New Margaritoland, HI 90422-9071 |
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'TURCOTTE GROUP'
    And I enter the following details into the form:
      | Address | The North, Wigan |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'TURCOTTE GROUP'
    And I should see the following details in the 'Additional information' summary:
      | Address | The North, Wigan |
