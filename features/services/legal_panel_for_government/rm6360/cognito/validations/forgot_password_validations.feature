Feature: Forgot my password - Legal Panel for Government - RM6360 - Validations

  Background: Navigate to forgot password
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    And I am on the 'Sign in to your legal panel for government account' page
    When I click on 'I’ve forgotten my password'
    Then I am on the 'Reset password' page

  Scenario Outline: I forgot my password - email invalid
    And I enter the following details into the form:
      | Email address | <value> |
    And I click on 'Send reset email'
    Then I should see the following error messages:
      | Enter your email address in the correct format, like name@example.com |

    Examples:
      | value           |
      |                 |
      | fake@email      |
      | fake email      |

  Scenario: I forgot my password - user not found
    And I cannot reset my password becaue of the 'user not found' error
    Then I am on the 'Reset your password' page

  Scenario Outline: I forgot my password - cognito error
    And I cannot reset my password becaue of the '<error>' error
    Then I should see the following error messages:
      | <error_message> |
    
    Examples:
      | error             | error_message                                                         |
      | invalid parameter | Enter your email address in the correct format, like name@example.com |
      | service           | An error occured: service                                             |
