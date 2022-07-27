Feature: Supply Teachers - Footer links

  Background: Navigate to start page
    Given I go to the 'supply teachers' start page for 'RM6238'

  Scenario: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page

  Scenario: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    And I click on 'Back to start'
    And I am on the 'Find supply teachers and agency workers' page
