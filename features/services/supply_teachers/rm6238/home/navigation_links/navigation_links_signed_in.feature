Feature: Supply Teachers - Navigation links when signed in

  Background: I navigate to the start page
     Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'

  Scenario: Start page
    When I go to the 'supply teachers' start page for 'RM6238'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |

  Scenario: Not permitted page - Back to start
    And I go to the not permitted page for 'supply teachers'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find supply teachers and agency workers' page

  Scenario: Not permitted page - sign out
    And I go to the not permitted page for 'supply teachers'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Cookies policy - Back to start
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find supply teachers and agency workers' page

  Scenario: Cookies policy - Sign out
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Cookies settings - Back to start
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find supply teachers and agency workers' page

  Scenario: Cookies settings - Sign out
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Accessibility statement - Back to start
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find supply teachers and agency workers' page

  Scenario: Accessibility statement - Sign out
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Home page - Sign out
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find supply teachers and agency workers' page
