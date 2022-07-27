Feature: Supply Teachers - Navigation links when signed out

  Background: I navigate to the start page
    When I go to the 'supply teachers' start page for 'RM6238'

  Scenario: Start page
    Then I should see the following navigation links:
      | Back to start |

  Scenario: Not permitted page
    And I go to the not permitted page for 'supply teachers'
    Then I should see the following navigation links:
      | Back to start |

  Scenario: Gate way page
    And I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    And I should see the following navigation links:
      | Back to start |
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Sign in page 
    And I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    And I click on 'Sign in with CCS'
    And I should see the following navigation links:
      | Back to start |
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page


  Scenario: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page
