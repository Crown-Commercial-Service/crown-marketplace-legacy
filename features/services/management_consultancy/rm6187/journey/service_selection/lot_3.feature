Feature: Management Consultancy - Lot 3 - Complex and Transformation - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    Given I select 'Lot 3 - Complex and Transformation'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 3 - Complex and Transformation'
    Then I should see the following options for the lot:
      | Business                            |
      | Change management                   |
      | Complex programmes                  |
      | Digital, technology and cyber       |
      | Finance                             |
      | HR                                  |
      | Organisation and operating model    |
      | Performance transformation          |
      | Procurement and/or supply chain     |
      | Project and programme management    |
      | Strategy and/or policy              |
      | Supplier side services and delivery |
      | Transformation management           |
