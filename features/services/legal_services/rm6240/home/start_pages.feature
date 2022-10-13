@pipeline
Feature: Legal Services - Start pages

  Scenario: Buyer sees start page
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page

  Scenario: Buyer navigates to sign in page
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your legal services account' page

  Scenario: Logging in
    When I go to the 'legal services' start page for 'RM6240'
    Then I am on the 'Find legal services for the wider public sector' page
    When I click on 'Start now'
    Then I am on the 'Sign in to your legal services account' page
    Then I should sign in as an 'ls' buyer
    Then I am on the 'Do you work for central government?' page
