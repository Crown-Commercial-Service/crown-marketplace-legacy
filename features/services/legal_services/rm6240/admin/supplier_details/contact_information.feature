Feature: Legal services - Admin - Supplier details - Contact information

  Scenario: Contact information can be updated
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'MERTZ-HOMENICK'
    Then I am on the 'Supplier details' page
    And the caption is 'MERTZ-HOMENICK'
    And I should see the following details in the 'Contact information' summary:
      | Contact email            | homenick.mertz@feest-hamill.com        |
      | Contact telephone number | 01702 321456                           |
      | Website                  | http://osinski.co/francisca.bartoletti |
    And I click on 'Change (Contact information)'
    Then I am on the 'Manage supplier contact information' page
    And the caption is 'MERTZ-HOMENICK'
    And I enter the following details into the form:
      | Contact email            | f.maj.pixie@gogopenguine.co.uk |
      | Contact telephone number | 01610 234561                   |
      | Website                  | http://f.maj.pixie.co.uk       |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'MERTZ-HOMENICK'
    And I should see the following details in the 'Contact information' summary:
      | Contact email            | f.maj.pixie@gogopenguine.co.uk |
      | Contact telephone number | 01610 234561                   |
      | Website                  | http://f.maj.pixie.co.uk       |
