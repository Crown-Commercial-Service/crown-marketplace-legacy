Feature: Legal Panel for Government - Start pages

  Scenario: Buyer sees start page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page

  Scenario: Buyer navigates to sign in page
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your legal panel for government account' page

  Scenario: Logging in
    When I go to the 'legal panel for government' start page for 'RM6360'
    Then I am on the 'Find legal services for government' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your legal panel for government account' page
    Then I should sign in as an 'ls' buyer
    Then I am on the 'Do you work for central government?' page
