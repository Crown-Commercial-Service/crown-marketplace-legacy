@pipeline
Feature: Legal services - Central governemnt - fees over £20,000

  Scenario: If my fees are over £20,000, I cannot continue
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the "Sorry, this panel isn't suitable for you" page
    And I click on the 'Back to start' button
    Then I am on the 'Find legal services for the wider public sector' page
