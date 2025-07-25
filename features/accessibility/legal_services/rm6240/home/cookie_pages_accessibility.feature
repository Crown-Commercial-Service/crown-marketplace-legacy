@accessibility @javascript
Feature: Legal Services - Cookie pages accessibility

  Scenario: Start page with the banner
    Given I go to the 'legal services' start page for 'RM6240'
    And the cookie banner 'is' visible
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Cookie policy
    Given I go to the 'legal services' start page for 'RM6240'
    And the cookie banner 'is' visible
    When I click on 'Accept analytics cookies'
    And I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Cookie settings
    Given I go to the 'legal services' start page for 'RM6240'
    And the cookie banner 'is' visible
    When I click on 'Accept analytics cookies'
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    Then the page should be axe clean excluding ".ccs-contact-us"