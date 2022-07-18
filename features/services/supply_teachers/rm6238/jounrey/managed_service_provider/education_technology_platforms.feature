@pipeline
Feature: Supply Teachers - Education technology platforms

  Scenario: Education technology platform results
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider'"
    And I click on 'Continue'
    Then I am on the 'What type of managed service do you want?' page
    And I select 'Education technology platform service'
    And I click on 'Continue'
    Then I am on the 'Education technology platform service providers' page
    And there are 4 managed service provider agencies
    And the managed service provider agencies are:
      | TERRY-EMMERICH                |
      | HERMAN AND SONS               |
      | HAGENES, KASSULKE AND TREUTEL |
      | DECKOW LLC                    |
    And the contact details for the managed service provider 'TERRY-EMMERICH' are:
      | Msgr. Rachel Abernathy        |
      | 238.481.0154 x64340           |
      | emmerich_terry@ondricka.info  |
    And the education technology platform agency 'TERRY-EMMERICH' has the following rates:
      | Agency Management Fee: Daily supply worker (per worker, per day)              | £22.23  |
      | Agency Management Fee: Long term assignment (6 weeks+) (per worker, per day)  | £21.11  |
      | A specific person                                                             | £20.00  |
      | Employed directly                                                             | 5.0%    |
    And I click on 'Back'
    Then I am on the 'What type of managed service do you want?' page
