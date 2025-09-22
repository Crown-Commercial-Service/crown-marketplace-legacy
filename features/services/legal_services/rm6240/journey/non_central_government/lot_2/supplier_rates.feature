Feature: Legal services - Non central governemnt - Lot 2 - Supplier rates

  Scenario Outline: Check the supplier has different rates in different jurisdictions
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'
    When I check the following items:
      | Court of Protection |
      | Licensing           |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - General service provision'
    And I select '<jurisdiction>'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    Given I click on 'GUSIKOWSKI, BOSCO AND CRIST'
    Then I am on the 'GUSIKOWSKI, BOSCO AND CRIST' page
    And the 'Partner' hourly rate is '<partner_rate>'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '<senior_solicitor_rate>'
    And the 'Solicitor, Associate' hourly rate is '<solicitor_rate>'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '<nq_solicitor_rate>'
    And the 'Trainee' hourly rate is '<trainee_rate>'
    And the 'Paralegal, Legal Assistant' hourly rate is '<paralegal_rate>'
    And the 'LMP (Legal project manager)' hourly rate is '<lmp_rate>'

    Examples:
      | jurisdiction      | partner_rate | senior_solicitor_rate | solicitor_rate | nq_solicitor_rate | trainee_rate | paralegal_rate | lmp_rate |
      | England and Wales | £175.00      | £150.00               | £125.00        | £100.00           | £75.00       | £50.00         | £165.00  |
      | Scotland          | £175.00      | £150.00               | £125.00        | £100.00           | £75.00       | £50.00         | £137.50  |
