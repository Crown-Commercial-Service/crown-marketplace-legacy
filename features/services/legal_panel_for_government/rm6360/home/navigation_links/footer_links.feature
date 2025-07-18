Feature: Legal Panel for Government - Footer links

  Background: Navigate to start page
    Given I go to the 'legal panel for government' start page for 'RM6360'

  Scenario: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I click on the header link 'Back to start'
    And I am on the 'Find legal services for government' page

  Scenario: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I click on the header link 'Back to start'
    And I am on the 'Find legal services for government' page

  Scenario: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Panel for Government (LPG) Accessibility statement' page
    And I click on the header link 'Back to start'
    And I am on the 'Find legal services for government' page
