Feature: Legal Panel for Government - Non central governemnt

  Scenario: If my requirements are not suitable, I cannot continue
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the "Sorry, this panel isn't suitable for you" page
    And I click on the Back to start button
    Then I am on the 'Find legal services for government' page
