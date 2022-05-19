@accessibility @javascript
Feature: Management Consultancy - Improvements to CCS digital solutions - Accessibility

  Scenario: The imporvements page is accessibile
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Then the page should be axe clean
