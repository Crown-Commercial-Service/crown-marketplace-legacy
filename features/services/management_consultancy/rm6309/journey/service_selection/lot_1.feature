@javascript
Feature: Management Consultancy - Lot 1 - Business - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 1 - Business'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Automation                                                                       |
      | Business case development                                                        |
      | Business consultancy                                                             |
      | Business policy development and/or appraisal                                     |
      | Business processes                                                               |
      | Business strategy                                                                |
      | Change management                                                                |
      | Digital, technology and cyber                                                    |
      | Innovation, growth and business models                                           |
      | Operational planning and/or improvement, including Target Operating Models (TOM) |
      | Organisational design and review, Enterprise Resource Planning (ERP)             |
      | Programme and project management                                                 |
      | Risk, opportunity and compliance                                                 |
      | Value for money reviews                                                          |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Automation'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Automation |
    When I check the following items:
      | Operational planning and/or improvement, including Target Operating Models (TOM) |
      | Programme and project management                                                 |
      | Value for money reviews                                                          |
      | Business consultancy                                                             |
      | Change management                                                                |
      | Innovation, growth and business models                                           |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Automation                                                                       |
      | Operational planning and/or improvement, including Target Operating Models (TOM) |
      | Programme and project management                                                 |
      | Value for money reviews                                                          |
      | Business consultancy                                                             |
      | Change management                                                                |
      | Innovation, growth and business models                                           |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Programme and project management |
      | Risk, opportunity and compliance |
      | Business case development        |
      | Business processes               |
      | Change management                |
      | Digital, technology and cyber    |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Programme and project management |
      | Risk, opportunity and compliance |
      | Business case development        |
      | Business processes               |
      | Change management                |
      | Digital, technology and cyber    |
    When I deselect the following items:
      | Business case development |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Programme and project management |
      | Risk, opportunity and compliance |
      | Business processes               |
      | Change management                |
      | Digital, technology and cyber    |
    When I remove the following items from the basket:
      | Programme and project management |
      | Risk, opportunity and compliance |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business processes            |
      | Change management             |
      | Digital, technology and cyber |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Risk, opportunity and compliance                                     |
      | Organisational design and review, Enterprise Resource Planning (ERP) |
      | Programme and project management                                     |
      | Automation                                                           |
      | Innovation, growth and business models                               |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Automation                                                           |
      | Organisational design and review, Enterprise Resource Planning (ERP) |
      | Programme and project management                                     |
      | Risk, opportunity and compliance                                     |
      | Innovation, growth and business models                               |
