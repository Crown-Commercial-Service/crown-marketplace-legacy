Feature: Supply Teachers - Admin - Supplier details - Supplier information - Validations

  Background: Navigate to to the supplier information page
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'ROLFSON-COLLIER'
    Then I am on the 'Supplier details' page
    And the caption is 'ROLFSON-COLLIER'
    And I click on 'Change (Supplier information)'
    Then I am on the 'Manage supplier information' page
    And the caption is 'ROLFSON-COLLIER'

  Scenario Outline: Validations on the supplier name
    And I enter the following details into the form:
      | Supplier name | <supplier_name> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier information' page
    And the caption is 'ROLFSON-COLLIER'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | supplier_name        | error_message                                                       |
      |                      | The supplier name cannot be blank                                   |
      | SATTERFIELD AND SONS | The supplier name you entered is already in use by another supplier |

  Scenario Outline: Validations on the trading name
    And I enter the following details into the form:
      | Trading name | <trading_name> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier information' page
    And the caption is 'ROLFSON-COLLIER'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | trading_name    | error_message                                                               |
      |                 | The supplier trading name cannot be blank                                   |
      | GLOVER-ONDRICKA | The supplier trading name you entered is already in use by another supplier |

  Scenario Outline: Validations on the additional identifier
    And I enter the following details into the form:
      | Additional identifier | <additional_identifier> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier information' page
    And the caption is 'ROLFSON-COLLIER'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | additional_identifier                | error_message                                                               |
      |                                      | The additional identifier cannot be blank                                   |
      | 54a03944-f6dd-47d1-92f5-7a0b4cf6ff1f | The additional identifier you entered is already in use by another supplier |
