Feature: Supply Teachers - Temp to perm - Effects of holiday

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/02/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    Given I enter '29/03/2021' for the 'hire' date

  Scenario: Adding one week of holiday has the same affect as reducing the hire date by one week
    Given I enter '07/03/2021' for the 'holiday 1 start' date
    And I enter '13/03/2021' for the 'holiday 1 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£675.00'
    And I click on 'Back'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '22/03/2021' for the 'hire' date
    And I enter ' / / ' for the 'holiday 1 start' date
    And I enter ' / / ' for the 'holiday 1 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£675.00'

  Scenario: Adding two weeks of holiday has the same affect as reducing the hire date by two weeks
    Given I enter '07/03/2021' for the 'holiday 1 start' date
    And I enter '20/03/2021' for the 'holiday 1 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£800.00'
    And I click on 'Back'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '15/03/2021' for the 'hire' date
    And I enter ' / / ' for the 'holiday 1 start' date
    And I enter ' / / ' for the 'holiday 1 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£800.00'

  Scenario: Adding two seperate weeks of holiday has the same affect as reducing the hire date by two weeks
    Given I enter '01/03/2021' for the 'holiday 1 start' date
    And I enter '07/03/2021' for the 'holiday 1 end' date
    And I enter '08/03/2021' for the 'holiday 2 start' date
    And I enter '14/03/2021' for the 'holiday 2 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£800.00'
    And I click on 'Back'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '15/03/2021' for the 'hire' date
    And I enter ' / / ' for the 'holiday 1 start' date
    And I enter ' / / ' for the 'holiday 1 end' date
    And I enter ' / / ' for the 'holiday 2 start' date
    And I enter ' / / ' for the 'holiday 2 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£800.00'

  Scenario: Holidays on a weekend does not change the result
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£550.00'
    And I click on 'Back'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    And I enter '13/02/2021' for the 'holiday 1 start' date
    And I enter '14/02/2021' for the 'holiday 1 end' date
    And I enter '20/03/2021' for the 'holiday 2 start' date
    And I enter '21/03/2021' for the 'holiday 2 end' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And my temp to perm fee is '£550.00'
