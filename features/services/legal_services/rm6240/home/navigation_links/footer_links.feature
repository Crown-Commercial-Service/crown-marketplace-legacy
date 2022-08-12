Feature: Legal Services - Footer links

  Background: Navigate to start page
    Given I go to the 'legal services' start page for 'RM6240'

  Scenario: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I click on 'Back to start'
    And I am on the 'Find legal services for the wider public sector' page

  Scenario: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I click on 'Back to start'
    And I am on the 'Find legal services for the wider public sector' page

  Scenario: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Services (LS) Accessibility statement' page
    And I click on 'Back to start'
    And I am on the 'Find legal services for the wider public sector' page
