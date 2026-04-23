Feature: Supply Teachers - Admin - Supplier details - Additional information - Validations

  Background: Navigate to to the supplier contact information page
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'LANG INC'
    Then I am on the 'Supplier details' page
    And the caption is 'LANG INC'
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'LANG INC'

  Scenario Outline: Validations on the managed service provider contact name
    And I enter the following details into the form:
      | Managed service provider contact name | <contact_name> |
    And I click on 'Save and return'
    Then I am on the 'Manage additional information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | contact_name | error_message                                   |
      |              | Enter the managed service provider contact name |

  Scenario Outline: Validations on the managed service provider contact email
    And I enter the following details into the form:
      | Managed service provider contact email | <contact_email> |
    And I click on 'Save and return'
    Then I am on the 'Manage additional information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | contact_email | error_message                                                                                 |
      |               | Enter the managed service provider contact email in the correct format, like name@example.com |
      | not an email  | Enter the managed service provider contact email in the correct format, like name@example.com |

  Scenario Outline: Validations on the managed service provider contact telephone number
    And I enter the following details into the form:
      | Managed service provider contact telephone number | <contact_telephone_number> |
    And I click on 'Save and return'
    Then I am on the 'Manage additional information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | contact_telephone_number | error_message                                                                                        |
      |                          | Enter the managed service provider contact telephone number in the correct format, like 07700 900000 |
      | not number               | Enter the managed service provider contact telephone number in the correct format, like 07700 900000 |
      | 0712345678               | Enter the managed service provider contact telephone number in the correct format, like 07700 900000 |
      | 01 23 45 678             | Enter the managed service provider contact telephone number in the correct format, like 07700 900000 |
