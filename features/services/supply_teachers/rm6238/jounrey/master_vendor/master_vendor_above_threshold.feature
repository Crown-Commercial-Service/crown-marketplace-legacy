@pipeline
Feature: Supply Teachers - Master vendors - Above threshold

  Scenario: Master vendors - Above threshold results
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    And the caption is 'Contract worth more than £2.5 million'
    And there are 3 managed service provider agencies
    And the managed service provider agencies are:
      | O'HARA LLC                    |
      | BOGAN, REICHERT AND COLLIER   |
      | MCGLYNN, BAILEY AND NIKOLAUS  |
    And the contact details for the managed service provider 'BOGAN, REICHERT AND COLLIER' are:
      | Ok Kuphal                             |
      | (670) 117-8868 x86891                 |
      | bogan.and.collier.reichert@murray.net |
    And the master vendor agency 'BOGAN, REICHERT AND COLLIER' has the following rates:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) | £57.16  | £54.30  |
      | Over 12 Week Reduction                                      | 6.0%    | £228.64 |
      | Fixed Term                                                  | 34.3%   | 34.3%   |
    And I click on 'Back'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
