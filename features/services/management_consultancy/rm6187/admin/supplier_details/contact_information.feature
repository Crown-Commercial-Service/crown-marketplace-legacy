Feature: Management Consultancy - Admin - Supplier details - Contact information

  Scenario: Contact information can be updated
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'ROMAGUERA INC'
    Then I am on the 'Supplier details' page
    And the caption is 'ROMAGUERA INC'
    And I should see the following details in the 'Contact information' summary:
      | Contact name             | Astrid Hickle DC                      |
      | Contact email            | romaguera.inc@feeney.biz              |
      | Contact telephone number | 13210717291                           |
      | Website                  | http://schimmel-yundt.name/jan.heller |
    And I click on 'Change (Contact information)'
    Then I am on the 'Manage supplier contact information' page
    And the caption is 'ROMAGUERA INC'
    And I enter the following details into the form:
      | Contact name             | Friday Film Special                    |
      | Contact email            | friday.film.special@gogopenguine.co.uk |
      | Contact telephone number | 01610 345612                           |
      | Website                  | http://friday.film.special.co.uk       |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'ROMAGUERA INC'
    And I should see the following details in the 'Contact information' summary:
      | Contact name             | Friday Film Special                    |
      | Contact email            | friday.film.special@gogopenguine.co.uk |
      | Contact telephone number | 01610 345612                           |
      | Website                  | http://friday.film.special.co.uk       |
