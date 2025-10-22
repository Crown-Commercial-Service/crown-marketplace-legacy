Feature: Legal Panel for Government - Admin - Supplier details - Additional information - Validations

  Background: Navigate to to the supplier contact information page
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'SANFORD INC'
    Then I am on the 'Supplier details' page
    And the caption is 'SANFORD INC'
    And I click on 'Change (Additional information)'
    Then I am on the 'Manage additional information' page
    And the caption is 'SANFORD INC'

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

  Scenario Outline: Validations on the website
    And I enter the following details into the form:
      | Lot 1 prospectus link  | <url> |
      | Lot 2 prospectus link  | <url> |
      | Lot 3 prospectus link  | <url> |
      | Lot 4a prospectus link | <url> |
      | Lot 4b prospectus link | <url> |
      | Lot 4c prospectus link | <url> |
      | Lot 5 prospectus link  | <url> |
    And I click on 'Save and return'
    Then I am on the 'Manage additional information' page
    And I should see the following error messages:
      | Enter the lot 1 prospectus link in the correct format, like https://example.com  |
      | Enter the lot 2 prospectus link in the correct format, like https://example.com  |
      | Enter the lot 3 prospectus link in the correct format, like https://example.com  |
      | Enter the lot 4a prospectus link in the correct format, like https://example.com |
      | Enter the lot 4b prospectus link in the correct format, like https://example.com |
      | Enter the lot 4c prospectus link in the correct format, like https://example.com |
      | Enter the lot 5 prospectus link in the correct format, like https://example.com  |

    Examples:
      | url                        |
      | not a url                  |
      | htop://i-look-like-one.com |
