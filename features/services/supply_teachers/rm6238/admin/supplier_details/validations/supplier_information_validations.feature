Feature: Supply Teachers - Admin - Supplier details - Supplier information - Validations

  Background: Navigate to to the supplier information page
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'CHRISTIANSEN INC'
    Then I am on the 'Supplier details' page
    And the caption is 'CHRISTIANSEN INC'
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'CHRISTIANSEN INC'

  Scenario Outline: Validations on the supplier name
    And I enter the following details into the form:
      | Supplier name | <supplier_name> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier information' page
    And the caption is 'CHRISTIANSEN INC'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | supplier_name                | error_message                                                       |
      |                              | The supplier name cannot be blank                                   |
      | BARTOLETTI, KOEPP AND NIENOW | The supplier name you entered is already in use by another supplier |
