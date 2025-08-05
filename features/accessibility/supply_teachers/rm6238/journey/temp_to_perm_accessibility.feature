@accessibility @javascript
Feature: Supply Teachers - Temp to perm - Accessibility

  Background: Login and then navigate to the Temp to perm start page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    Then I am on the 'What is your school looking for?' page
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
  
  Scenario:  Temp to perm start page
    Then the page should be axe clean excluding ".ccs-contact-us"
  
  Scenario: No notice given - hiring after 12 weeks - results page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter '03/08/2021' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£0' and '£500'
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: No notice given - hiring between 9 and 12 weeks - results page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter '19/06/2021' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is between '£200.00' and '£500.00'
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: No notice given - hiring before 9 weeks - results page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter '31/05/2021' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£550.00'
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario: Notice given - results page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter '19/06/2021' for the 'hire' date
    And I enter '30/05/2021' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£375.00'
    Then the page should be axe clean excluding ".ccs-contact-us"
