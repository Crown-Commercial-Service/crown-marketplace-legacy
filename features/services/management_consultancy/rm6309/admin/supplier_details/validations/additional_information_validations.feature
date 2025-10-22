Feature: Management Consultancy - Admin - Supplier details - Additional information - Validations

  Background: Navigate to to the supplier contact information page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'TURCOTTE GROUP'
    Then I am on the 'Supplier details' page
    And the caption is 'TURCOTTE GROUP'
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'TURCOTTE GROUP'

  Scenario Outline: Validations on the address
    And I enter the following details into the form:
      | Address | <address> |
    And I click on 'Save and return'
    Then I am on the 'Manage additional information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | address | error_message     |
      |         | Enter the address |
