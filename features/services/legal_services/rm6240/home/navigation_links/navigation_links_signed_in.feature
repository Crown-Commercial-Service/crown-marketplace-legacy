Feature: Legal Services - Navigation links when signed in

  Background: I navigate to the start page
     Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'

  Scenario: Start page
    When I go to the 'legal services' start page for 'RM6240'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |

  Scenario: Not permitted page - Back to start
    And I go to the not permitted page for 'legal services'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find legal services for the wider public sector' page

  Scenario: Not permitted page - sign out
    And I go to the not permitted page for 'legal services'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find legal services for the wider public sector' page

  Scenario: Cookies policy - Back to start
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find legal services for the wider public sector' page

  Scenario: Cookies policy - Sign out
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find legal services for the wider public sector' page

  Scenario: Cookies settings - Back to start
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find legal services for the wider public sector' page

  Scenario: Cookies settings - Sign out
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find legal services for the wider public sector' page

  Scenario: Accessibility statement - Back to start
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Services (LS) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Back to start'
    Then I am on the 'Find legal services for the wider public sector' page

  Scenario: Accessibility statement - Sign out
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Services (LS) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find legal services for the wider public sector' page

  Scenario: Home page - Sign out
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on 'Sign out'
    And I am on the 'Find legal services for the wider public sector' page
