@accessibility @javascript
Feature: Supply Teachers - Education technology platforms - Accessibility

  Scenario: Education technology platform service providers page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'A supplier that will provide a digital platform to create a pool of workers'
    And I click on 'Continue'
    Then I am on the 'Education technology platform service providers' page
    Then the page should pass the accessibility checks
