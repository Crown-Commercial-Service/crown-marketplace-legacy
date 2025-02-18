Feature: Management Consultancy - Start pages

  Scenario: Buyer sees start page
    When I go to the 'management consultancy' start page for 'RM6309'
    Then I am on the 'Find management consultants' page

  Scenario: Buyer navigates to sign in page
    When I go to the 'management consultancy' start page for 'RM6309'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your management consultancy account' page

  Scenario: Logging in
    When I go to the 'management consultancy' start page for 'RM6309'
    Then I am on the 'Find management consultants' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your management consultancy account' page
    Then I should sign in as an 'mc' buyer
    Then I am on the 'Select the lot you need' page
