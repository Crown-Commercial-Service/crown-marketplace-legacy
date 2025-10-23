Feature: Management Consultancy - Admin - Supplier details - Supplier information - Validations

  Background: Navigate to to the supplier information page
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'BERNHARD INC'
    Then I am on the 'Supplier details' page
    And the caption is 'BERNHARD INC'
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'BERNHARD INC'

  Scenario Outline: Validations on the supplier name
    And I enter the following details into the form:
      | Supplier name | <supplier_name> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier information' page
    And the caption is 'BERNHARD INC'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | supplier_name               | error_message                                                       |
      |                             | The supplier name cannot be blank                                   |
      | BATZ, BROWN AND BREITENBERG | The supplier name you entered is already in use by another supplier |

  Scenario Outline: Validations on the duns number
    And I enter the following details into the form:
      | DUNS Number | <duns_number> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier information' page
    And the caption is 'BERNHARD INC'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | duns_number | error_message                                                     |
      |             | The DUNS number cannot be blank                                   |
      | I am not    | The DUNS number must be 9 digits                                  |
      | 65021007    | The DUNS number must be 9 digits                                  |
      | 763187532   | The DUNS number you entered is already in use by another supplier |
