@pipeline
Feature: Supply Teachers - Master vendors - Above threshold

  Scenario: Master vendors - Above threshold results
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'What type of managed service do you want?' page
    And I select 'Master vendor managed service'
    And I click on 'Continue'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    And the caption is 'Contract worth more than £2.5 million'
    And there are 3 managed service provider agencies
    And the managed service provider agencies are:
      | MAGGIO GROUP                  |
      | SHIELDS, HERZOG AND NITZSCHE  |
      | EBERT AND SONS                |
    And the contact details for the managed service provider 'MAGGIO GROUP' are:
      | Dean Hackett              |
      | 1-992-898-2027 x3413      |
      | maggio_group@streich.info |
    And the master vendor agency 'MAGGIO GROUP' has the following rates:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors) | £36.65  | £34.81  |
      | Over 12 Week Reduction                                      | 4.0%    | £146.60 |
      | Employed directly                                           | 22.0%   | 22.0%   |
    And I click on 'Back'
    Then I am on the 'Is your contract likely to be worth more than £2.5 million?' page
