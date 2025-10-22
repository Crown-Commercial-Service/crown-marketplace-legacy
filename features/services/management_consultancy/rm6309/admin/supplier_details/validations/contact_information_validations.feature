Feature: Management Consultancy - Admin - Supplier details - Contact information - Validations

  Background: Navigate to to the supplier contact information page
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'MOSCISKI-CROOKS'
    Then I am on the 'Supplier details' page
    And the caption is 'MOSCISKI-CROOKS'
    And I click on 'Change (Contact information)'
    Then I am on the 'Manage supplier contact information' page
    And the caption is 'MOSCISKI-CROOKS'

  Scenario Outline: Validations on the contact name
    And I enter the following details into the form:
      | Contact name | <contact_name> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier contact information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | contact_name | error_message          |
      |              | Enter the contact name |

  Scenario Outline: Validations on the contact email
    And I enter the following details into the form:
      | Contact email | <contact_email> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier contact information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | contact_email | error_message                                                        |
      |               | Enter the contact email in the correct format, like name@example.com |
      | not an email  | Enter the contact email in the correct format, like name@example.com |

  Scenario Outline: Validations on the telephone number
    And I enter the following details into the form:
      | Contact telephone number | <contact_telephone_number> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier contact information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | contact_telephone_number | error_message                                                               |
      |                          | Enter the contact telephone number in the correct format, like 07700 900000 |
      | not number               | Enter the contact telephone number in the correct format, like 07700 900000 |
      | 0712345678               | Enter the contact telephone number in the correct format, like 07700 900000 |
      | 01 23 45 678             | Enter the contact telephone number in the correct format, like 07700 900000 |

  Scenario Outline: Validations on the website
    And I enter the following details into the form:
      | Website | <website> |
    And I click on 'Save and return'
    Then I am on the 'Manage supplier contact information' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | website                    | error_message                                                     |
      |                            | Enter the website in the correct format, like https://example.com |
      | not a website              | Enter the website in the correct format, like https://example.com |
      | htop://i-look-like-one.com | Enter the website in the correct format, like https://example.com |
