Feature: Sign in to my account - Legal Panel for Government - RM6360 - Buyer details

  Scenario: Save details for the buyer
    Given I sign in without details and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Answer questions (Personal details)'
    Then I am on the 'Manage your personal details' page
    And I enter the following details into the form:
      | Name      | Testy McTestface |
      | Job title | Tester           |
    And I click on 'Save and return'
    Then I am on the 'Your details' page
    And I click on 'Answer questions (Organisation details)'
    And I enter the following details into the form:
      | Organisation name | Feel Good inc. |
    And I check 'Local Community and Housing' for the sector
    And I click on 'Save and return'
    And I am on the 'Your details' page
    And the following buyer details have been entered for 'Personal details':
      | Name      | Testy McTestface |
      | Job title | Tester           |
    And the following buyer details have been entered for 'Organisation details':
      | Organisation name                  | Feel Good inc.              |
      | Type of public sector organisation | Local Community and Housing |
