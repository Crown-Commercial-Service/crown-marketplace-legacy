@javascript
Feature: Supply Teachers - All agencies - Validations

  Scenario: Invlaid postcode
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'Find an agency' page
    And a list of 15 agencies are shown
    And I enter "Fake Postcode" for the agency postcode search
    Then I should see the following error message for the agency postcode 'Enter a valid postcode'
