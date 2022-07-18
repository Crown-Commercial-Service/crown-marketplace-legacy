@pipeline
Feature: Supply Teachers - Master vendors - Below threshold

  Scenario: Master vendors - Below threshold results
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'What type of managed service do you want?' page
    And I select 'Master vendor managed service'
    And I click on 'Continue'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    And the caption is 'Contract worth less than £2.5 million'
    And there are 3 managed service provider agencies
    And the managed service provider agencies are:
      | ONDRICKA LLC                  |
      | MAGGIO GROUP                  |
      | SHIELDS, HERZOG AND NITZSCHE  |
    And the contact details for the managed service provider 'ONDRICKA LLC' are:
      | Deirdre Pagac                   |
      | 1-871-086-0283                  |
      | ondricka_llc@ruecker-sipes.biz  |
    And the master vendor agency 'ONDRICKA LLC' has the following rates:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) | £41.40  | £39.33  |
      | Over 12 Week Reduction                                      | 5.0%    | £165.60 |
      | Employed directly                                           | 24.8%   | 24.8%   |
    And I click on 'Back'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
