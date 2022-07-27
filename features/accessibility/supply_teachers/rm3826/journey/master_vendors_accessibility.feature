@accessibility @javascript
Feature: Supply Teachers - Master vendors - Accessibility

  Scenario: Master vendors page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page
    And I select "An agency to manage all my school's needs; a 'managed service provider - Master Vendor'"
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    Then the page should be axe clean