@accessibility @javascript
Feature: Management Consultancy - Important changes to how you access - Accessibility

  Scenario: The important changes page is accessibile
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Then the page should be axe clean
