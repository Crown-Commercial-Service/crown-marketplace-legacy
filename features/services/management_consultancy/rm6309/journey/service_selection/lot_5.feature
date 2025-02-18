@javascript
Feature: Management Consultancy - Lot 5 - HR - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 5 - HR'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 5 - HR'
  
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Capability development                                |
      | Cultural transformation                               |
      | Equality, diversity and inclusion                     |
      | HR functions, process and design                      |
      | HR policy and strategy                                |
      | Organisational design and/or workforce planning       |
      | People and performance                                |
      | Recruitment, retention and employee value proposition |
      | Training and development                              |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Capability development'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Capability development                          |
    When I check the following items:
      | Cultural transformation                         |
      | Equality, diversity and inclusion               |
      | Organisational design and/or workforce planning |
      | People and performance                          |
      | Training and development                        |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Capability development |
      | Cultural transformation                         |
      | Equality, diversity and inclusion               |
      | Organisational design and/or workforce planning |
      | People and performance                          |
      | Training and development                        |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Capability development            |
      | Equality, diversity and inclusion |
      | People and performance            |
      | HR policy and strategy            |
      | Training and development          |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Capability development            |
      | Equality, diversity and inclusion |
      | People and performance            |
      | HR policy and strategy            |
      | Training and development          |
    When I deselect the following items:
      | HR policy and strategy            |
    Then the basket should say '4 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Capability development            |
      | Equality, diversity and inclusion |
      | People and performance            |
      | Training and development          |
    When I remove the following items from the basket:
      | Equality, diversity and inclusion |
      | Capability development            |
    Then the basket should say '2 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | People and performance    |
      | Training and development  |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Cultural transformation           |
      | Equality, diversity and inclusion |
      | HR policy and strategy            |
      | People and performance            |
      | HR functions, process and design  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | HR policy and strategy            |
      | People and performance            |
      | Equality, diversity and inclusion |
      | Cultural transformation           |
      | HR functions, process and design  |
