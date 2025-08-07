@accessibility @javascript
Feature: Management Consultancy - Service selection - Accessibility

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 1 - Business'

  Scenario: No services have been selected
    Then the page should be axe clean excluding ".ccs-contact-us"
  
  Scenario: Some services selected
    When I check the following items:
      | Operational planning and/or improvement         |
      | Organisational review                           |
      | Programme & project management                  |
      | Risk, compliance and/or opportunity management  |
    Then the following items should appear in the basket:
      | Operational planning and/or improvement         |
      | Organisational review                           |
      | Programme & project management                  |
      | Risk, compliance and/or opportunity management  |
    And the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Everything is selected
    Given I select all the services
    Then the following items should appear in the basket:
      | Business case development                             |
      | Operational planning and/or improvement               |
      | Organisational review                                 |
      | Programme & project management                        |
      | Risk, compliance and/or opportunity management        |
      | Value for money reviews                               |
      | Business consultancy                                  |
      | Business continuity and/or disaster recovery planning |
      | Business policy strategy and/or appraisal             |
      | Business processes                                    |
      | Change management                                     |
      | Development and/or review of policy                   |
      | Digital, technology and cyber                         |
      | Forecasting and/or planning                           |
    And the page should be axe clean excluding ".ccs-contact-us"
