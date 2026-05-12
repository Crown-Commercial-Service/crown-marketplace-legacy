Feature: Supply Teachers - Start pages

  Scenario: Buyer sees start page
    When I go to the 'supply teachers' start page for 'RM6376'
    Then I am on the 'Supply Teachers and Education Recruitment' page

  Scenario: Buyer navigates to sign in page
    When I go to the 'supply teachers' start page for 'RM6376'
    Then I am on the 'Supply Teachers and Education Recruitment' page
    When I click on 'Start now'
    Then I am on the 'Sign in for Supply Teachers and Education Recruitment' page

  Scenario: Logging in
    When I go to the 'supply teachers' start page for 'RM6376'
    Then I am on the 'Supply Teachers and Education Recruitment' page
    When I click on 'Start now'
    Then I am on the 'Sign in for Supply Teachers and Education Recruitment' page
    Then I click on 'Sign in with GCA'
    Then I should sign in as an 'st' buyer
    Then I am on the 'What is your school looking for?' page
