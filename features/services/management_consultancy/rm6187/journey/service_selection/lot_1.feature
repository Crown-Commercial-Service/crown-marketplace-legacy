@javascript
Feature: Management Consultancy - Lot 1 - Business - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 1 - Business'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 1 - Business'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Business case development                             |
      | Operational planning and/or improvement               |
      | Organisational review                                 |
      | Programme & project management                        |
      | Risk, compliance and/or opportunity management        |
      | Value for money reviews.                              |
      | Business consultancy                                  |
      | Business continuity and/or disaster recovery planning |
      | Business policy strategy and/or appraisal             |
      | Business processes                                    |
      | Change management                                     |
      | Development and/or review of policy                   |
      | Digital, technology and cyber                         |
      | Forecasting and/or planning                           |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Business case development'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development                       |
    When I check the following items:
      | Operational planning and/or improvement         |
      | Organisational review                           |
      | Programme & project management                  |
      | Risk, compliance and/or opportunity management  |
      | Value for money reviews.                        |
      | Business consultancy                            |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development                       |
      | Operational planning and/or improvement         |
      | Organisational review                           |
      | Programme & project management                  |
      | Risk, compliance and/or opportunity management  |
      | Value for money reviews.                        |
      | Business consultancy                            |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Business case development                             |
      | Programme & project management                        |
      | Value for money reviews.                              |
      | Business continuity and/or disaster recovery planning |
      | Business processes                                    |
      | Digital, technology and cyber                         |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development                             |
      | Programme & project management                        |
      | Value for money reviews.                              |
      | Business continuity and/or disaster recovery planning |
      | Business processes                                    |
      | Digital, technology and cyber                         |
    When I deselect the following items:
      | Business continuity and/or disaster recovery planning |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development                             |
      | Programme & project management                        |
      | Value for money reviews.                              |
      | Business processes                                    |
      | Digital, technology and cyber                         |
    When I remove the following items from the basket:
      | Programme & project management                        |
      | Business processes                                    |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Business case development                             |
      | Value for money reviews.                              |
      | Digital, technology and cyber                         |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Business case development                             |
      | Programme & project management                        |
      | Forecasting and/or planning                           |
      | Business continuity and/or disaster recovery planning |
      | Business processes                                    |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Forecasting and/or planning                           |
      | Business case development                             |
      | Programme & project management                        |
      | Business processes                                    |
      | Business continuity and/or disaster recovery planning |
