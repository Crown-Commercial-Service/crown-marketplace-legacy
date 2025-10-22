Feature: Legal Panel for Government - Admin - Supplier details - Contact information

  Scenario: Contact information can be updated
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'GOYETTE AND SONS'
    Then I am on the 'Supplier details' page
    And the caption is 'GOYETTE AND SONS'
    And I should see the following details in the 'Contact information' summary:
      | Contact email            | goyette.and.sons@weimann-berge.test |
      | Contact telephone number | 07765 851010                        |
      | Website                  | http://bednar-metz.test/mei         |
    And I click on 'Change (Contact information)'
    Then I am on the 'Manage supplier contact information' page
    And the caption is 'GOYETTE AND SONS'
    And I enter the following details into the form:
      | Contact email            | garden.dog.bbq@gogopenguine.co.uk |
      | Contact telephone number | 01610 123456                      |
      | Website                  | http://garden.dog.bbq.co.uk       |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'GOYETTE AND SONS'
    And I should see the following details in the 'Contact information' summary:
      | Contact email            | garden.dog.bbq@gogopenguine.co.uk |
      | Contact telephone number | 01610 123456                      |
      | Website                  | http://garden.dog.bbq.co.uk       |
