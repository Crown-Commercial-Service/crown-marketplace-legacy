Feature: Supply Teachers - Admin - Supplier details

  Scenario Outline: Supplier details page
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for "<supplier_name>"
    Then I am on the 'Supplier details' page
    And the caption is "<supplier_name>"
    And I should see the following details in the 'Supplier information' summary:
      | Name        | <supplier_name> |
      | DUNS Number | <duns_number>   |
      | Is an SME?  | <sme>           |

    Examples:
      | supplier_name    | duns_number | sme |
      | CHRISTIANSEN INC | N/A         | No  |
      | EMARD AND SONS   | N/A         | No  |
      | O'HARA LLC       | N/A         | No  |
