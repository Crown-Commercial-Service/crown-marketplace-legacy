@accessibility @javascript
Feature: Supply Teachers - Agency results - Accessibility

  Background: Login and then navigate to the start page
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page

  Scenario: What is your school looking for? page
    Then the page should be axe clean

  Scenario: Do you want an agency to supply the worker? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    Then the page should be axe clean

  Scenario: Do you want the agency to manage the worker’s pay? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    Then the page should be axe clean

  Scenario: School postcode and worker requirements page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    Then the page should be axe clean

  @geocode_london
  Scenario: Agency results - agency payroll page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I select 'Unqualified teacher: non-SEN roles'
    And I select 'Up to 1 week'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    Then the page should be axe clean

  Scenario: What date do you want the employee to start? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No, I want to put the worker on our payroll'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    Then the page should be axe clean

  Scenario: What date do you want the employee to stop working? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No, I want to put the worker on our payroll'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    Then the page should be axe clean

  Scenario: What would the employee's annual salary be? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No, I want to put the worker on our payroll'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    Then the page should be axe clean

  Scenario: What is your school’s postcode? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No, I want to put the worker on our payroll'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    Then the page should be axe clean

  @geocode_london
  Scenario: Agency results - fixed term page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No, I want to put the worker on our payroll'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '28000' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    Then the page should be axe clean

  Scenario: What is your school’s postcode? page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    Then the page should be axe clean

  @geocode_london
  Scenario: Agency results - nominated worker page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    Then the page should be axe clean

  @geocode_birmingham
  Scenario: Agency results - no agencies page
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'B6 6HE' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    Then the page should be axe clean
