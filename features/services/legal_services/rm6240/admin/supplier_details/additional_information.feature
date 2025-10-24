Feature: Legal services - Admin - Supplier details - Additional information

  Scenario: Additional information can be updated
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'ZEMLAK INC'
    Then I am on the 'Supplier details' page
    And the caption is 'ZEMLAK INC'
    And I should see the following details in the 'Additional information' summary:
      | Address               | Apt. 416 316 Otto Village, West Herlinda, AK 59333 |
      | Lot 1 prospectus link | http://christiansen-mann.name/ali/lot-1            |
      | Lot 2 prospectus link | http://christiansen-mann.name/ali/lot-2            |
      | Lot 3 prospectus link | http://christiansen-mann.name/ali/lot-3            |
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'ZEMLAK INC'
    And I enter the following details into the form:
      | Address               | The North, Liverpool     |
      | Lot 1 prospectus link | http://bardo.co.uk/lot-1 |
      | Lot 2 prospectus link | http://bardo.co.uk/lot-2 |
      | Lot 3 prospectus link | http://bardo.co.uk/lot-3 |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'ZEMLAK INC'
    And I should see the following details in the 'Additional information' summary:
      | Address               | The North, Liverpool     |
      | Lot 1 prospectus link | http://bardo.co.uk/lot-1 |
      | Lot 2 prospectus link | http://bardo.co.uk/lot-2 |
      | Lot 3 prospectus link | http://bardo.co.uk/lot-3 |
