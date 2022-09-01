@pipeline
Feature: Supply Teachers - Master vendors - Below threshold

  Scenario: Master vendors - Below threshold results
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    And the caption is 'Contract worth less than £2.5 million'
    And there are 3 managed service provider agencies
    And the managed service provider agencies are:
      | LUETTGEN-GUTMANN            |
      | O'HARA LLC                  |
      | BOGAN, REICHERT AND COLLIER |
    And the contact details for the managed service provider 'LUETTGEN-GUTMANN' are:
      | Adrian Hane                                   |
      | 1-943-719-6600 x77799                         |
      | luettgen.gutmann@wintheiser-breitenberg.name  |
    And the master vendor agency 'LUETTGEN-GUTMANN' has the following rates:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) | £54.32  | £51.60  |
      | Over 12 Week Reduction                                      | 0.0%	  | £217.28 |
      | Fixed Term                                                  | 32.6%   | 32.6%   |
    And I click on 'Back'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
