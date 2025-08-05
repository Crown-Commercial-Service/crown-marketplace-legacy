@accessibility @javascript
Feature: Management Consultancy - Service selection - Accessibility

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 1 - Business'

  Scenario: No services have been selected
    Then the page should be axe clean excluding ".ccs-contact-us"
  
  Scenario: Some services selected
    When I check the following items:
      | Operational planning and/or improvement, including Target Operating Models (TOM)  |
      | Organisational design and review, Enterprise Resource Planning (ERP)              |
      | Programme and project management                                                  |
      | Risk, opportunity and compliance                                                  |
    Then the following items should appear in the basket:
      | Operational planning and/or improvement, including Target Operating Models (TOM)  |
      | Organisational design and review, Enterprise Resource Planning (ERP)              |
      | Programme and project management                                                  |
      | Risk, opportunity and compliance                                                  |
    And the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Everything is selected
    Given I select all the services
    Then the following items should appear in the basket:
      | Automation                                                                        |
      | Operational planning and/or improvement, including Target Operating Models (TOM)  |
      | Organisational design and review, Enterprise Resource Planning (ERP)              |
      | Programme and project management                                                  |
      | Risk, opportunity and compliance                                                  |
      | Value for money reviews                                                           |
      | Business case development                                                         |
      | Business consultancy                                                              |
      | Business policy development and/or appraisal                                      |
      | Business processes                                                                |
      | Business strategy                                                                 |
      | Change management                                                                 |
      | Digital, technology and cyber                                                     |
      | Innovation, growth and business models                                            |
    And the page should be axe clean excluding ".ccs-contact-us"
