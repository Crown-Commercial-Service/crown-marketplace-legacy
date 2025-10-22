Feature: Legal Panel for Government - Admin - Supplier details - Additional information

  Scenario: Additional information can be updated
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'SANFORD INC'
    Then I am on the 'Supplier details' page
    And the caption is 'SANFORD INC'
    And I should see the following details in the 'Additional information' summary:
      | Address                | Suite 830 5709 Simonis Valley, Lake Vernie, UT 13705 |
      | Lot 1 prospectus link  | http://wintheiser.test/thad                          |
      | Lot 2 prospectus link  | http://wolf.test/delmer.graham                       |
      | Lot 3 prospectus link  | http://bauch.example/maurine_heidenreich             |
      | Lot 4a prospectus link | http://schmitt.test/dudley                           |
      | Lot 4b prospectus link | http://murazik-bechtelar.test/neda                   |
      | Lot 4c prospectus link | http://sanford.test/asa                              |
      | Lot 5 prospectus link  | http://block-stokes.test/ellen_ruecker               |
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'SANFORD INC'
    And I enter the following details into the form:
      | Address                | The North, Manchester                 |
      | Lot 1 prospectus link  | http://flowerfield.loops.co.uk/lot-1  |
      | Lot 2 prospectus link  | http://flowerfield.loops.co.uk/lot-2  |
      | Lot 3 prospectus link  | http://flowerfield.loops.co.uk/lot-3  |
      | Lot 4a prospectus link | http://flowerfield.loops.co.uk/lot-4a |
      | Lot 4b prospectus link | http://flowerfield.loops.co.uk/lot-4b |
      | Lot 4c prospectus link | http://flowerfield.loops.co.uk/lot-4c |
      | Lot 5 prospectus link  | http://flowerfield.loops.co.uk/lot-5  |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'SANFORD INC'
    And I should see the following details in the 'Additional information' summary:
      | Address                | The North, Manchester                 |
      | Lot 1 prospectus link  | http://flowerfield.loops.co.uk/lot-1  |
      | Lot 2 prospectus link  | http://flowerfield.loops.co.uk/lot-2  |
      | Lot 3 prospectus link  | http://flowerfield.loops.co.uk/lot-3  |
      | Lot 4a prospectus link | http://flowerfield.loops.co.uk/lot-4a |
      | Lot 4b prospectus link | http://flowerfield.loops.co.uk/lot-4b |
      | Lot 4c prospectus link | http://flowerfield.loops.co.uk/lot-4c |
      | Lot 5 prospectus link  | http://flowerfield.loops.co.uk/lot-5  |
