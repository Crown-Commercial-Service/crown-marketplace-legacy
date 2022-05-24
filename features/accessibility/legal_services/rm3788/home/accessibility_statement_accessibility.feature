@RM3788 @accessibility @javascript
Feature: Legal Services - Accessibility statement accessibility

  Scenario: Accessibility statement
    Given I go to the 'legal services' start page for 'RM3788'
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Services (LS) Accessibility statement' page
    Then the page should be axe clean
