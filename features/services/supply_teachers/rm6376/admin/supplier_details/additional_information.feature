Feature: Supply Teachers - Admin - Supplier details - Additional information

  Scenario: Additional information can be updated
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'LANG INC'
    Then I am on the 'Supplier details' page
    And the caption is 'LANG INC'
    And I should see the following details in the 'Additional information' summary:
      | Managed service provider contact name             | Prof. Cecily Price      |
      | Managed service provider contact email            | inc.lang@armstrong.test |
      | Managed service provider contact telephone number | 50960663100             |
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'LANG INC'
    And I enter the following details into the form:
      | Managed service provider contact name             | Idris                 |
      | Managed service provider contact email            | idris@vulture.gov.com |
      | Managed service provider contact telephone number | 07123654897           |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'LANG INC'
    And I should see the following details in the 'Additional information' summary:
      | Managed service provider contact name             | Idris                 |
      | Managed service provider contact email            | idris@vulture.gov.com |
      | Managed service provider contact telephone number | 07123654897           |
