@pipeline
Feature: Management Consultancy - Start pages

  Scenario: Buyer sees start page
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page

  Scenario: Buyer navigates to sign in page
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your management consultancy buyer account' page

  Scenario: Logging in
    When I go to the 'management consultancy' start page for 'RM6187'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your management consultancy buyer account' page
    Then I should sign in as an 'mc' buyer
    Then I am on the 'Improvements to Crown Commercial Service digital solutions' page
